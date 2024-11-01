import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
    {
        path: 'recipe',
        loadChildren: () =>
            import('./recipe/recipe.module').then(
                (m) => m.RecipePageModule,
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
