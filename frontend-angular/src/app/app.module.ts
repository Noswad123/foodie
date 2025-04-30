import { NgModule } from '@angular/core';
import { AppComponent } from './app.component';
import { BrowserModule } from '@angular/platform-browser';
import { PagesModule } from '../pages/pages.module';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { SharedModule } from '../shared/shared.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { AppRoutingModule } from './app.routing.module';

@NgModule({
    bootstrap: [AppComponent],
    imports: [
      BrowserAnimationsModule,
      BrowserModule,
      PagesModule,
      SharedModule,
      AppRoutingModule,
    ],
    declarations: [AppComponent],
    providers: [
      provideHttpClient(withInterceptorsFromDi()),
      provideAnimationsAsync()
  ],
})
export class AppModule {}
