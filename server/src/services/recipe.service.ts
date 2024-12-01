import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { EntityManager, Repository } from 'typeorm';
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

  async create(recipeData, transactionManager?: EntityManager) {
    const manager = transactionManager || this.recipeRepository.manager;
    const existingRecipe = await manager.findOne(Recipe, {where: {name: recipeData.name}});
    if (existingRecipe) {
      console.log('Recipe already exists');
      return;
    }

    const recipe = manager.create(Recipe, {
      name: recipeData.name,
      servingSize: recipeData.servingSize,
      prepTime: recipeData.prepTime,
      cookTime: recipeData.cookTime,
      instructions: this.formatInstructions(recipeData.instructions)
    });
    const savedRecipe = await manager.save(recipe);
    console.log('Recipe created', {name: savedRecipe.name, id: savedRecipe.id});
    return savedRecipe;
  }

  formatInstructions(instructions: any) {
    if (typeof instructions === 'string') {
      return instructions;
    } else {
      return JSON.stringify(instructions);
    }
  }
}
