import { ActivatedRoute } from '@angular/router';
import { DetailsService } from './detailService';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Injectable } from '@angular/core';

@Injectable()
export abstract class DetailsComponent {
  id?: number;
  item: any;  // Consider replacing `any` with a specific type if available

  private destroy$ = new Subject<void>();

  constructor(
    private detailService: DetailsService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.route.paramMap.pipe(takeUntil(this.destroy$)).subscribe(params => {
      const rawId = params.get('id');
      if (rawId) {
        this.id = parseInt(rawId, 10);
        this.detailService.get(this.id).pipe(takeUntil(this.destroy$)).subscribe(
          (data) => {
            this.item = data;
            console.log(this.item);
          },
          error => {
            console.error('Failed to fetch details:', error);
          }
        );
      } else {
        console.error('No ID provided in the route');
      }
    });
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
}
