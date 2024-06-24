import { NgModule, importProvidersFrom } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { SidebarModule } from 'primeng/sidebar';
import { ButtonModule } from 'primeng/button';
import { MainComponent } from './main/main.component';
import { AvatarModule } from 'primeng/avatar';
import { InputTextModule } from 'primeng/inputtext';
import { CalendarModule } from 'primeng/calendar';
import { FormsModule } from '@angular/forms';
import { ToolbarModule } from 'primeng/toolbar';
import { MenubarModule } from 'primeng/menubar';
import { RippleModule } from 'primeng/ripple';
import { BadgeModule } from 'primeng/badge';
import { TableModule } from 'primeng/table';
import { ApiAsociados } from './service/api.asociados.service';
import { AsociadosServicio } from './service/asociados.service';
import { HttpClientModule } from '@angular/common/http';
import { DatePipe } from '@angular/common';
import { MainDetailComponent } from './main-detail/main-detail.component';

@NgModule({
  declarations: [AppComponent, MainComponent, MainDetailComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    SidebarModule,
    ButtonModule,
    InputTextModule,
    CalendarModule,
    FormsModule,
    ToolbarModule,
    MenubarModule,
    AvatarModule,
    RippleModule,
    BadgeModule,
    TableModule,
  ],
  providers: [
    ApiAsociados,
    AsociadosServicio,
    DatePipe,
    importProvidersFrom(HttpClientModule),
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
