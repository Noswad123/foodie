import { Component } from '@angular/core';
import { RecipeService } from './recipe.page.service';

@Component({
  templateUrl: './recipe.page.html',
})
export class RecipeListComponent {
  recipes: any[] = [];

  constructor(private recipeService: RecipeService) { }

  ngOnInit(): void {
    this.recipeService.getAllRecipes().subscribe((data) => {
      this.recipes = data;
    });
  }
}
