import { Module } from '@nestjs/common';
import { RecipeService, SeedService } from 'src/services';
import { SeedController } from 'src/controllers';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Ingredient, MeasurementUnit, Recipe, RecipeIngredient } from 'src/entities';

@Module({
  imports: [TypeOrmModule.forFeature([
    Recipe,
    Ingredient,
    RecipeIngredient,
    MeasurementUnit
  ])],
  providers: [SeedService, RecipeService],
  controllers: [SeedController],
})
export class SeedModule {}
