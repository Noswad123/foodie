import { Controller, Get } from '@nestjs/common';
import { RecipeService } from '../services/recipe.service';
import { Recipe } from '../entities/recipe.entity';

@Controller('recipes')
export class RecipeController {
  constructor(private readonly recipeService: RecipeService) {}

  @Get()
  async getAllRecipes(): Promise<Recipe[]> {
    return this.recipeService.findAll();
  }
}
