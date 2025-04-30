import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { IngredientDetailsService } from './ingredient-details.page.service';

@Component({
  templateUrl: './ingredient-details.page.html',
  styleUrls: ['./ingredient-details.page.scss']
})
export class IngredientDetailsPage implements OnInit {
  id?: number;
  ingredient: any;

  constructor(
    private ingredientDetailService: IngredientDetailsService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      const rawId = params.get('id');
      console.log(rawId);
      if (rawId) {
        this.id = parseInt(rawId, 10);
        this.ingredientDetailService.getIngredient(this.id).subscribe((data) => {
          this.ingredient = data;
          console.log(this.ingredient);
        });
      } else {
        console.error('No ID provided in the route');
      }
    });
  }
}
