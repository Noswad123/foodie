import { Controller, Get } from '@nestjs/common';
import { IngredientService } from '../services';
import { Ingredient } from '../entities';

@Controller('ingredients')
export class IngredientController {
  constructor(private readonly ingredientService: IngredientService) {}

  @Get()
  async getAllIngredients(): Promise<Ingredient[]> {
    return this.ingredientService.findAll();
  }
}
