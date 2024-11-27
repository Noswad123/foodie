import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Ingredient } from '../entities';

@Injectable()
export class IngredientService {
  constructor(
    @InjectRepository(Ingredient)
    private ingredientRepository: Repository<Ingredient>,
  ) {}

  async findAll(): Promise<Ingredient[]> {
    return await this.ingredientRepository.find();
  }

  async findOne(id: number): Promise<Ingredient> {
    return await this.ingredientRepository.findOne({where: {id}});
  }
}
