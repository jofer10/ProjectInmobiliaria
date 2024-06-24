import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { ServerResponse } from "../interface/serve.model";
import { map } from "rxjs";

@Injectable()
export class ApiAsociados {
    constructor(private http: HttpClient){}

    getAsociadosDefault(name:string, iniFec: string, finFec: string){
        const body = {name_pry:name, fec_ini: iniFec, fec_fin:finFec }
        return this.http.post<ServerResponse>("http://localhost:3200/api/asociados", body)
        .pipe(map( res => res.body))
    }

    getAsociado(index:number){
        return this.http.get<ServerResponse>("http://localhost:3200/api/asociados/"+index)
        .pipe(map(res=>res.body))
    }
}