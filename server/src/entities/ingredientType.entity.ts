
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';

@Entity('ingredient_type')
export class IngredientType {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;
}
