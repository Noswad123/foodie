import { Controller, Get, Param } from '@nestjs/common';
import { IngredientService } from '../services';
import { Ingredient } from '../entities';

@Controller('ingredients')
export class IngredientController {
  constructor(private readonly ingredientService: IngredientService) {}

  @Get()
  async findAll(): Promise<Ingredient[]> {
    return this.ingredientService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: number): Promise<Ingredient> {
    console.log('Getting ingredient with ID:', id);
    return this.ingredientService.findOne(id);
  }
}
