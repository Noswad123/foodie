import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as FoodieModules from './modules';
import * as FoodieEntities from './entities';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'sqlite',
      database: 'db/foodie.db',
      entities: Object.values(FoodieEntities),
      synchronize: true,
      // logging: true,
    }),
    ...Object.values(FoodieModules)
  ],
})
export class AppModule {}
