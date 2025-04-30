import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DetailsService } from '../../shared/detailComponent/detailService';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class RecipeDetailsService extends DetailsService {
  constructor(http: HttpClient) {
    super(http, 'http://localhost:3000/recipes');
  }

  getWithIngredients(id: number): Observable<any> {
    const url = 'http://localhost:3000/recipe-ingredients';
    return this.http.get<any>(`${url}/${id}`);
  }
}
