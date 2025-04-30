import { RouterModule, Routes } from '@angular/router';
import { NgModule } from '@angular/core';
import { HomePage } from '../pages/home/home.page';

export const routes: Routes = [
  { path: '', component: HomePage },
  {
    path: 'login', loadChildren: () => import('./user/user.module').then(m => m.UserModule)
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
