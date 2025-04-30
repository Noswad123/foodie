import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Recipe } from '../entities/recipe.entity';
import { RecipeService } from '../services/recipe.service';
import { RecipeController } from '../controllers/recipe.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Recipe])],
  providers: [RecipeService],
  controllers: [RecipeController],
})
export class RecipeModule {}
