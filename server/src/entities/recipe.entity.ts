// src/recipe/recipe.entity.ts
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, JoinColumn } from 'typeorm';
import { RecipeType } from './recipeType.entity';
import { RecipeIngredient } from './recipeIngredient.entity';

@Entity('recipes')
export class Recipe {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ nullable: true })
  instructions: string;

  @Column({ nullable: true })
  prep_time: number;

  @Column({ nullable: true })
  cooking_time: number;

  @Column()
  created_at: Date;

  @Column()
  updated_at: Date;

  @ManyToOne(() => RecipeType)
  @JoinColumn({ name: 'type_id' })
  type: RecipeType;

  @OneToMany(() => RecipeIngredient, (recipeIngredient) => recipeIngredient.recipe)
  recipeIngredients: RecipeIngredient[];
}
