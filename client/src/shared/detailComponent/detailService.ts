import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export abstract class DetailsService {

  constructor(private http: HttpClient, private apiUrl: string) { }

  get(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/${id}`);
  }
}
