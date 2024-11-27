import { NgModule } from '@angular/core';
import { RecipeDetailsPage } from './recipe-details.page';
import { SharedModule } from '../../shared/shared.module';
import { RouterModule } from '@angular/router';


@NgModule({
    declarations: [RecipeDetailsPage],
    imports: [
      RouterModule.forChild([
        { path: '', component: RecipeDetailsPage }
      ]),
      SharedModule
    ],
    exports: [RecipeDetailsPage],
})
export class RecipeDetailsPageModule {}
