import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CoreModule } from '../../app/core.module';
import { RecipeListComponent } from './recipe.page';

const routes: Routes = [{ path: '', component: RecipeListComponent }];

@NgModule({
    declarations: [RecipeListComponent],
    imports: [
        RouterModule.forChild(routes),
        CoreModule,
    ],
    exports: [RecipeListComponent],
})
export class RecipePageModule {}
