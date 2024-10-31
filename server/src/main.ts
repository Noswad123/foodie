import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { NestExpressApplication } from '@nestjs/platform-express';
import { DataSource } from 'typeorm';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  const dataSource = app.get(DataSource);

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
