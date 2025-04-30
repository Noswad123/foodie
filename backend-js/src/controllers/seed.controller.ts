import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { SeedService } from 'src/services';

@Controller('seed')
export class SeedController {
  constructor(private readonly seedService: SeedService) {}

  @Post()
  async addRecipes(@Body() data: string): Promise<void> {
    return this.seedService.seed(data);
  }
}
