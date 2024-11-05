import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
    {
      path: '',
        loadChildren: () =>
            import('./home/home.module').then(
                (m) => m.HomePageModule,
            ),
    },
    {
        path: 'recipes',
        loadChildren: () =>
            import('./recipe/recipe.module').then(
                (m) => m.RecipePageModule,
            ),
    },
    {
        path: 'ingredients',
        loadChildren: () =>
            import('./ingredient/ingredient.module').then(
                (m) => m.IngredientPageModule,
            ),
    },
];

@NgModule({
    imports: [RouterModule.forRoot(routes, {})],
    exports: [
      RouterModule,
      HttpClientModule
    ],
    declarations: [],
})
export class PagesModule {}
