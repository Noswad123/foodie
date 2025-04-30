import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export abstract class DetailsService {

  constructor(protected http: HttpClient, protected apiUrl: string) { }

  get(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/${id}`);
  }
}
