import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Ingredient, MeasurementUnit } from '../entities';
import { IngredientService } from '../services';
import { IngredientController } from '../controllers';

@Module({
  imports: [TypeOrmModule.forFeature([Ingredient, MeasurementUnit])],
  providers: [IngredientService],
  controllers: [IngredientController],
})
export class IngredientModule {}
