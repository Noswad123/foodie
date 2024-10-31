import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, JoinColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';
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

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;

  @ManyToOne(() => RecipeType)
  @JoinColumn({ name: 'type_id' })
  type: RecipeType;

  @OneToMany(() => RecipeIngredient, (recipeIngredient) => recipeIngredient.recipe)
  recipeIngredients: RecipeIngredient[];
}
