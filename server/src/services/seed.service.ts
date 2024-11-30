import { Repository } from 'typeorm';
import { Recipe, Ingredient, RecipeIngredient, MeasurementUnit } from '../entities';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class SeedService {
  units: MeasurementUnit[] = [];
  constructor(
    @InjectRepository(Recipe)
    private recipeRepository: Repository<Recipe>,
    @InjectRepository(Ingredient)
    private ingredientRepository: Repository<Ingredient>,
    @InjectRepository(RecipeIngredient)
    private recipeIngredientRepository: Repository<RecipeIngredient>,
    @InjectRepository(MeasurementUnit)
    private measurementUnitRepository: Repository<MeasurementUnit>
  ) {
  }
  async  seed(recipeData) {
    if (this.units.length === 0) {
      this.units = await this.measurementUnitRepository.find();
      console.log(this.units);
    }

    const recipe = await this.createRecipe(recipeData);
    await this.createIngredients(recipeData, recipe);

    console.log('Seeding complete!');
}

  async createRecipe(recipeData) {
    const recipe = new Recipe();
    recipe.name = recipeData.title;
    recipe.servingSize = recipeData.servings;
    recipe.prepTime = recipeData.prepTime;
    recipe.instructions = recipeData.instructions;
    // const savedRecipe = await this.recipeRepository.save(recipe);
    return recipe;
  }

  async createIngredients(recipeData, recipe) {
    this.parseIngredients(recipe.ingredients);
  }

  parseIngredients(ingredients) {
        // Regular expression to capture the quantity, unit (if exists), and ingredient name
        const pattern = /(\d*\.?\d+)\s*([a-zA-Z]+)?\s*(.*)/;

        // Set of common units of measure
        const units = new Set(
          ...this.units.map(unit => unit.name),
          ...this.units.map(unit => unit.abbreviation)
        );

        const parsedIngredients = [];

        ingredients.forEach(ingredient => {
            const match = ingredient.match(pattern);
            if (match) {
                const quantity = match[1];
                let unit = match[2];
                let name = match[3];

                if (!unit || !units.has(unit)) {
                    unit = "each";
                }

                const measurementUnitId = this.units.find(
                  u => unit === u.abbreviation || unit===u.name
                ).id;
                parsedIngredients.push({
                    measurementUnitId,
                    name: name.trim(),
                });
            }
        });
        console.log(parsedIngredients);
        return parsedIngredients;
  }
}
