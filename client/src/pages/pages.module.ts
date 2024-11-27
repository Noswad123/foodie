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
    {
      path: 'ingredient-details/:id',
      loadChildren: () =>
          import('./ingredient-details/ingredient-details.module').then(
              (m) => m.IngredientDetailsPageModule,
          ),
  },
];

@NgModule({
    imports: [RouterModule.forRoot(routes, {})],
    exports: [
      RouterModule,
    ],
    declarations: [],
})
export class PagesModule {}
