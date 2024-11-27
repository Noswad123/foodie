import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class IngredientDetailsService {
  private apiUrl = 'http://localhost:3000/ingredients';

  constructor(private http: HttpClient) { }

  getIngredient(id: number): Observable<any> {
    console.log('Getting ingredient with ID:', id);
    return this.http.get<any>(`${this.apiUrl}/${id}`);
  }
}
