import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { DetailsComponent } from '../../shared/detailComponent/detail.component';
import { RecipeDetailsService } from './recipe-details.page.service';

@Component({
  templateUrl: './recipe-details.page.html',
  styleUrls: ['./recipe-details.page.scss']
})
export class RecipeDetailsPage extends DetailsComponent implements OnInit  {
  constructor(
      recipeDetailsService: RecipeDetailsService,
      route: ActivatedRoute
  ) {
    super(recipeDetailsService, route)
  }
}
