import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { EntityManager, Repository } from 'typeorm';
import { Ingredient, MeasurementUnit } from '../entities';

@Injectable()
export class IngredientService {
  units: MeasurementUnit[] = [];
  constructor(
    @InjectRepository(Ingredient)
    private ingredientRepository: Repository<Ingredient>,
    @InjectRepository(MeasurementUnit)
    private measurementUnitRepository: Repository<MeasurementUnit>,
  ) {}

  async findAll(): Promise<Ingredient[]> {
    return await this.ingredientRepository.find();
  }

  async findOne(id: number): Promise<Ingredient> {
    return await this.ingredientRepository.findOne({where: {id}});
  }

  async parseIngredients(ingredients, transactionManager?: EntityManager) {
    const manager = transactionManager || this.measurementUnitRepository.manager;
    if (this.units.length === 0) {
      this.units = await manager.find(MeasurementUnit);
    }
    const pattern = /(\d*\.?\d+)\s*([a-zA-Z]+)?\s*(.*)/;

    const units = new Set([
      ...this.units.map(unit => unit.name),
      ...this.units.map(unit => unit.abbreviation)
    ]);

    const parsedIngredients = [];

    ingredients.forEach(ingredient => {
        const match = ingredient.match(pattern);
        if (match) {
            const quantity = match[1];
            let unit = match[2];
            let name = match[3];

            if (!unit || !units.has(unit)) {
                name = unit+ " " + name;
                unit = "each";
            }
            const measurementUnitId = this.units.find(
              u => unit === u.abbreviation || unit===u.name
            ).id;
            parsedIngredients.push({
                quantity,
                measurementUnitId,
                name: name.trim(),
            });
        }
    });
    console.log(parsedIngredients);
    return parsedIngredients;
}
}
