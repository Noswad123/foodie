import { NgModule } from '@angular/core';
import { CoreModule } from './core.module';
import { AppComponent } from './app.component';
import { BrowserModule } from '@angular/platform-browser';
import { PagesModule } from '../pages/pages.module';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';

@NgModule({
    bootstrap: [AppComponent],
    imports: [
      CoreModule,
      BrowserModule,
      PagesModule,
    ],
    declarations: [AppComponent],
    providers: [
      provideHttpClient(withInterceptorsFromDi()) // Configures HttpClient with interceptors from DI
  ],
})
export class AppModule {}
