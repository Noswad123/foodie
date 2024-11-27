import { Controller, Get, Param } from '@nestjs/common';
import { RecipeService } from '../services/recipe.service';
import { Recipe } from '../entities/recipe.entity';

@Controller('recipes')
export class RecipeController {
  constructor(private readonly recipeService: RecipeService) {}

  @Get()
  async findAll(): Promise<Recipe[]> {
    return this.recipeService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: number): Promise<Recipe> {
    console.log('Getting ingredient with ID:', id);
    return this.recipeService.findOne(id);
  }
}
