import { Component, OnInit } from '@angular/core';
import { IngredientService } from './ingredient.page.service';

@Component({
  templateUrl: './ingredient.page.html',
  styleUrl: './ingredient.page.scss'
})
export class IngredientPage implements OnInit {
  ingredients: any[] = [];
  paginatedIngredients: any[] = [];
  currentPage: number = 1;
  pageSize: number = 50;

  constructor(private ingredientService: IngredientService) {}

  ngOnInit(): void {
    this.ingredientService.getAll().subscribe((data) => {
      this.ingredients = data;
      this.updatePaginatedIngredients();
    });
  }

  updatePaginatedIngredients(): void {
    const start = (this.currentPage - 1) * this.pageSize;
    const end = start + this.pageSize;
    this.paginatedIngredients = this.ingredients.slice(start, end);
  }

  goToPage(page: number): void {
    this.currentPage = page;
    this.updatePaginatedIngredients();
  }

  nextPage(): void {
    if (this.currentPage < this.totalPages){
      this.currentPage++;
      this.updatePaginatedIngredients();
    }
  }

  prevPage(): void {
    if (this.currentPage > 1) {
      this.currentPage--;
      this.updatePaginatedIngredients();
    }
  }

  get totalPages(): number {
    return Math.ceil(this.ingredients.length / this.pageSize);
  }
}
