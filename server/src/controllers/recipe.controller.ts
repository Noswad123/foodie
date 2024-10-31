import { Controller, Get } from '@nestjs/common';

@Controller('recipes')
export class RecipeController {
  @Get()
  findAll(): string {
    return 'This action returns all cats';
  }
}