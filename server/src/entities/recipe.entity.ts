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

  @Column({ nullable: true, name: 'prep_time' })
  prepTime: number;

  @Column({ nullable: true, name: 'serving_size' })
  servingSize: number;

  @Column({ nullable: true, name: 'cook_time' })
  cookTime: number;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;

  @ManyToOne(() => RecipeType)
  @JoinColumn({ name: 'type_id' })
  type: RecipeType;

  @OneToMany(() => RecipeIngredient, (recipeIngredient) => recipeIngredient.recipe, {eager: true})
  recipeIngredients: RecipeIngredient[];
}
