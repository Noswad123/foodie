import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CoreModule } from '../../app/core.module';
import { IngredientPage } from './ingredient.page';
import { CommonModule } from '@angular/common';

const routes: Routes = [{ path: '', component: IngredientPage }];

@NgModule({
    declarations: [IngredientPage],
    imports: [
        RouterModule.forChild(routes),
        CoreModule,
        CommonModule,
    ],
    exports: [IngredientPage],
})
export class IngredientPageModule {}
