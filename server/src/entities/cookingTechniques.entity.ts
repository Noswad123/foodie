import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('cooking_techniques')
export class CookingTechnique {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ nullable: true })
  description: string;
}
