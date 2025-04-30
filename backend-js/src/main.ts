import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { NestExpressApplication } from '@nestjs/platform-express';
import { DataSource } from 'typeorm';
import * as fs from 'fs';
import * as path from 'path';

async function bootstrap() {
  const dbPath = path.join(process.cwd(), 'db/foodie.db');

  if (!fs.existsSync(dbPath)) {
    console.error(`Database file not found at path: ${dbPath}`);
    process.exit(1);
  } else {
    console.log(`Database file found at path: ${dbPath}`);
  }


  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.enableCors({
    origin: 'http://localhost:4200',
    methods: 'GET,POST,PUT,DELETE',
    credentials: true,
  });

  const dataSource = app.get(DataSource);

  const entities = dataSource.entityMetadatas;
  console.log('Entities registered:', entities.map(entity => entity.name));

  try {
    if (!dataSource.isInitialized) {
      await dataSource.initialize();
      console.log('Database connection established successfully.');
    }
  } catch (error) {
    console.error('Database connection failed:', error);
    process.exit(1);
  }

  await app.listen(process.env.PORT || 3000);
}

bootstrap();
