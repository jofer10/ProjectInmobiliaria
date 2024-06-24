import { Injectable } from '@angular/core';
import { Asociados } from '../interface/asociados.model';
import { ApiAsociados } from './api.asociados.service';

@Injectable()
export class AsociadosServicio {
  asociados: Asociados[] = [];

  constructor(private apiAsociados: ApiAsociados) {}

  obtenerAsociadosDefa(name:string, iniFec: string, finFec: string) {
    console.log(name,iniFec, finFec);
    return this.apiAsociados.getAsociadosDefault(name, iniFec, finFec);
  }

  obtenerAsociado(index:number){
    return this.apiAsociados.getAsociado(index)
  }

  setAsociados(asociado: Asociados[]){
    this.asociados=asociado
  }

  obtenerArray(index:number){
    return this.asociados[index]
  }
}
