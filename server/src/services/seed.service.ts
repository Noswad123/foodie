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
    @InjectRepository(MeasurementUnit)
    private measurementUnitRepository: Repository<MeasurementUnit>,
    @InjectDataSource() private dataSource: DataSource,
  ) {
  }
  async seed(recipeData) {
    if (this.units.length === 0) {
      this.units = await this.measurementUnitRepository.find();
    }
    const recipes = Array.isArray(recipeData) ? recipeData : [recipeData];
    await Promise.all(recipes.map(async recipe => this.createRecipeAndIngredients(recipe)));
}

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
      const measurementUnit = await this.measurementUnitRepository.findOne({where: {id: parsedIngredient.measurementUnitId}});

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
