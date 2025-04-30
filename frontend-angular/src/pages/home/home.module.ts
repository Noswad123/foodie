import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { HomePage } from './home.page';
import { SharedModule } from '../../shared/shared.module';

@NgModule({
    declarations: [HomePage],
    imports: [
      RouterModule.forChild([
        { path: '', component: HomePage }
      ]),
      SharedModule
    ],
    exports: [HomePage],
})
export class HomePageModule {}
