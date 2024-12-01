import { DataSource, Repository } from 'typeorm';
import { Ingredient, RecipeIngredient, MeasurementUnit } from '../entities';
import { Injectable } from '@nestjs/common';
import { InjectDataSource, InjectRepository } from '@nestjs/typeorm';
import { RecipeService } from './recipe.service';
import { IngredientService } from './ingredient.service';

@Injectable()
export class SeedService {
  units: MeasurementUnit[] = [];
  constructor(
    private recipeService: RecipeService,
    private ingredientService: IngredientService,
    @InjectDataSource() private dataSource: DataSource,
  ) {
  }
  async seed(recipeData) {
    if (this.units.length === 0) {
      await this.dataSource.transaction(async manager => {
      this.units = await manager.find(MeasurementUnit);
    })
    }
    const recipes = recipeData.recipes? recipeData.recipes : [recipeData];
    for (const recipe of recipes) {
      await this.createRecipeAndIngredients(recipe);
    }}

async createRecipeAndIngredients(recipe) {
    const recipeEntity = await this.recipeService.create(recipe);
    if (!recipeEntity) {
      return;
    }
    await this.createIngredients(recipe.ingredients, recipeEntity);
}

  async createIngredients(ingredients, recipe) {
    const parsedIngredients = await this.ingredientService.parseIngredients(ingredients);

    await this.dataSource.transaction(async manager => {
      const recipeIngredients = await Promise.all(parsedIngredients.filter(ingredient => !!ingredient.name).map(async parsedIngredient => {
        let ingredientEntity = await manager.findOneBy(Ingredient, {
          name: parsedIngredient.name
        });

        if (!ingredientEntity) {
          ingredientEntity = manager.create(Ingredient, {
            name: parsedIngredient.name,
          });
          await manager.save(ingredientEntity);
        }
        const measurementUnit = await manager.findOneBy(MeasurementUnit, { id: parsedIngredient.measurementUnitId });

        const recipeIngredientEntity = manager.create(RecipeIngredient, {
          ingredient: ingredientEntity,
          recipe,
          measurementUnit,
          quantity: parsedIngredient.quantity
        });

        return manager.save(recipeIngredientEntity);
      }));

      return recipeIngredients;
    });
  }
}
