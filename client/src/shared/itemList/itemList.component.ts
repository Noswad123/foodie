import { Component, Input, TemplateRef } from '@angular/core';

@Component({
  selector: 'app-item-list',
  templateUrl: './itemList.component.html',
  styleUrls: ['./itemList.component.scss']
})
export class ItemListComponent {
  @Input() items: any[] = [];
  @Input() route: string = '';
  @Input() title: string = '';
  @Input() itemTemplate!: TemplateRef<any>;
}
