import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CoreModule } from '../../app/core.module';
import { HomePage } from './home.page';
import { CommonModule } from '@angular/common';

const routes: Routes = [{ path: '', component: HomePage }];

@NgModule({
    declarations: [HomePage],
    imports: [
        RouterModule.forChild(routes),
        CoreModule,
        CommonModule,
    ],
    exports: [HomePage],
})
export class HomePageModule {}
