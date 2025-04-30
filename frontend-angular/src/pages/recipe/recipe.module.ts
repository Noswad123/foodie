import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { RecipePage } from './recipe.page';
import { CommonModule } from '@angular/common';
import { SharedModule } from '../../shared/shared.module';


@NgModule({
    declarations: [RecipePage],
    imports: [
      RouterModule.forChild([
        { path: '', component: RecipePage }
      ]),
      SharedModule
    ],
    exports: [RecipePage],
})
export class RecipePageModule {}
