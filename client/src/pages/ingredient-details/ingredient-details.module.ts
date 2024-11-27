import { NgModule } from '@angular/core';
import { IngredientDetailsPage } from './ingredient-details.page';
import { SharedModule } from '../../shared/shared.module';
import { RouterModule } from '@angular/router';


@NgModule({
    declarations: [IngredientDetailsPage],
    imports: [
      RouterModule.forChild([
        { path: '', component: IngredientDetailsPage }
      ]),
      SharedModule
    ],
    exports: [IngredientDetailsPage],
})
export class IngredientDetailsPageModule {}
