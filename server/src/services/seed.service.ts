import { DataSource, Repository } from 'typeorm';
import { Recipe, Ingredient, RecipeIngredient, MeasurementUnit } from '../entities';
import { Injectable } from '@nestjs/common';
import { InjectDataSource, InjectRepository } from '@nestjs/typeorm';
import { RecipeService } from './recipe.service';

@Injectable()
export class SeedService {
  units: MeasurementUnit[] = [];
  constructor(
    private recipeService: RecipeService,
    @InjectRepository(MeasurementUnit)
    private measurementUnitRepository: Repository<MeasurementUnit>,
    @InjectDataSource() private dataSource: DataSource,
  ) {
  }
  async seed(recipeData) {
    if (this.units.length === 0) {
      this.units = await this.measurementUnitRepository.find();
    }

    const recipeEntity = await this.recipeService.create(recipeData);
    if (!recipeEntity) {
      return;
    }
    await this.createIngredients(recipeData.ingredients, recipeEntity);
}

async createIngredients(ingredients, recipe) {
  const parsedIngredients = await this.parseIngredients(ingredients);

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

  parseIngredients(ingredients) {
        const pattern = /(\d*\.?\d+)\s*([a-zA-Z]+)?\s*(.*)/;

        const units = new Set([
          ...this.units.map(unit => unit.name),
          ...this.units.map(unit => unit.abbreviation)
        ]);

        const parsedIngredients = [];

        ingredients.forEach(ingredient => {
            const match = ingredient.match(pattern);
            if (match) {
                const quantity = match[1];
                let unit = match[2];
                let name = match[3];

                if (!unit || !units.has(unit)) {
                    name = unit+ " " + name;
                    unit = "each";
                }
                const measurementUnitId = this.units.find(
                  u => unit === u.abbreviation || unit===u.name
                ).id;
                parsedIngredients.push({
                    quantity,
                    measurementUnitId,
                    name: name.trim(),
                });
            }
        });
        console.log(parsedIngredients);
        return parsedIngredients;
  }
}
