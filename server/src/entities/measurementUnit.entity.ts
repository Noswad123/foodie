
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';

@Entity('measurement_units')
export class MeasurementUnit {
  @PrimaryGeneratedColumn()
  id: number;
  name: string;
  abbreviation: string;
}
