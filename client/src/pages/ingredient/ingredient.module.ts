import { NgModule } from '@angular/core';
import { IngredientPage } from './ingredient.page';
import { RouterModule } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';

@NgModule({
    declarations: [IngredientPage],
    imports: [
      RouterModule.forChild([
        { path: '', component: IngredientPage }
      ]),
      SharedModule
    ],
    exports: [IngredientPage],
})
export class IngredientPageModule {}
