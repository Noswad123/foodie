import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Recipe } from '../entities/recipe.entity';

@Injectable()
export class RecipeService {
  constructor(
    @InjectRepository(Recipe)
    private recipeRepository: Repository<Recipe>,
  ) {}

  async findAll(): Promise<Recipe[]> {
    await this.createTestRecipe();
    return await this.recipeRepository.query('SELECT * FROM recipes');
  }

  async createTestRecipe() {
    const recipe = this.recipeRepository.create({ name: 'Test Recipe', instructions: 'Test Instructions' });
    await this.recipeRepository.save(recipe);
  }
}
