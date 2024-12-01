import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Recipe } from '../entities';

@Injectable()
export class RecipeService {
  constructor(
    @InjectRepository(Recipe)
    private recipeRepository: Repository<Recipe>,
  ) {}

  async findAll(): Promise<Recipe[]> {
    return await this.recipeRepository.find();
  }

  async findOne(id: number): Promise<Recipe> {
    return await this.recipeRepository.findOne({
      where: {id},
      relations: {
      recipeIngredients: {
          ingredient: true,
          measurementUnit: true,
        }
      }
    });
  }

  async create(recipeData) {
    const recipe = new Recipe();
    recipe.name = recipeData.title;
    recipe.servingSize = recipeData.servings;
    recipe.prepTime = recipeData.prepTime;
    recipe.instructions = recipeData.instructions;
    const savedRecipe = await this.recipeRepository.save(recipe);
    console.log('Recipe created', {name: savedRecipe.name, id: savedRecipe.id});
    return savedRecipe;
  }
}
