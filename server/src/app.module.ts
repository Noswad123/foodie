import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RecipeModule } from './modules/recipe.module';
import * as Entities from './entities';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'sqlite',
      database: 'db/foodie.db',
      entities: Object.values(Entities),
      synchronize: true,
      // logging: true,
    }),
    RecipeModule,
  ],
})
export class AppModule {}
