import { Component, OnInit } from '@angular/core';
import { RecipeService } from './recipe.page.service';

@Component({
  templateUrl: './recipe.page.html',
  styleUrl: './recipe.page.scss'
})
export class RecipePage implements OnInit {
  recipes: any[] = [];
  paginatedRecipes: any[] = [];
  currentPage: number = 1;
  pageSize: number = 50;
  isLoading = false;

  constructor(private recipeService: RecipeService) {}

  ngOnInit(): void {
    this.recipeService.getAllRecipes().subscribe((data) => {
      this.recipes = data;
      this.updatePaginatedRecipes();
    });
  }

  updatePaginatedRecipes(): void {
    const start = (this.currentPage - 1) * this.pageSize;
    const end = start + this.pageSize;
    this.paginatedRecipes = this.recipes.slice(start, end);
  }

  goToPage(page: number): void {
    this.currentPage = page;
    this.updatePaginatedRecipes();
  }

  nextPage(): void {
    if (this.currentPage < this.totalPages) {
      this.currentPage++;
      this.updatePaginatedRecipes();
    }
  }

  prevPage(): void {
    if (this.currentPage > 1) {
      this.currentPage--;
      this.updatePaginatedRecipes();
    }
  }

  get totalPages(): number {
    return Math.ceil(this.recipes.length / this.pageSize);
  }
}
