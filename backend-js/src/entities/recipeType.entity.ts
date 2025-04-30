import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';

@Entity('recipe_types')
export class RecipeType {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;
}

