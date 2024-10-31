import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { IngredientType } from './ingredientType.entity';
import { MeasurementUnit } from './measurementUnit.entity';

@Entity('ingredients')
export class Ingredient {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ nullable: true })
  notes: string;

  @Column()
  created_at: Date;

  @Column()
  updated_at: Date;

  @ManyToOne(() => IngredientType)
  @JoinColumn({ name: 'ingredient_type_id' })
  ingredientType: IngredientType;

  @ManyToOne(() => MeasurementUnit)
  @JoinColumn({ name: 'measurement_unit_id' })
  measurementUnit: MeasurementUnit;
}

