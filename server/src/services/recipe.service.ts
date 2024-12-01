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
    const existingRecipe = await this.recipeRepository.findOne({where: {name: recipeData.name}});
    if (existingRecipe) {
      console.log('Recipe already exists');
      return;
    }
    
    const recipe = new Recipe();
    recipe.name = recipeData.name;
    recipe.servingSize = recipeData.servings;
    recipe.prepTime = recipeData.prepTime;
    recipe.cookTime = recipeData.cookTime;
    recipe.instructions = this.formatInstructions(recipeData.instructions);
    const createdRecipe = await this.recipeRepository.create(recipe);
    const savedRecipe = await this.recipeRepository.save(createdRecipe);
    console.log('Recipe created', {name: savedRecipe.name, id: savedRecipe.id});
    return savedRecipe;
  }

  formatInstructions(instructions: any) {
    if(typeof instructions === 'string') {
      return instructions;
    } else {
      return JSON.stringify(instructions);
    }
  }
}
