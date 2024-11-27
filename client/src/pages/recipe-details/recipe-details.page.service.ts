import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DetailsService } from '../../shared/detailComponent/detailService';

@Injectable({
  providedIn: 'root'
})
export class RecipeDetailsService extends DetailsService {
  constructor(http: HttpClient) {
    super(http, 'http://localhost:3000/recipes');
  }
}
