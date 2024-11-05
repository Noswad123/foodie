import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CoreModule } from '../../app/core.module';
import { RecipePage } from './recipe.page';
import { CommonModule } from '@angular/common';

const routes: Routes = [{ path: '', component: RecipePage }];

@NgModule({
    declarations: [RecipePage],
    imports: [
        RouterModule.forChild(routes),
        CoreModule,
        CommonModule,
    ],
    exports: [RecipePage],
})
export class RecipePageModule {}
