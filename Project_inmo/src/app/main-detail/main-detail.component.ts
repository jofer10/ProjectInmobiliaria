import { Component } from '@angular/core';
import { Asociados } from '../interface/asociados.model';
import { ActivatedRoute, Route, Router } from '@angular/router';
import { AsociadosServicio } from '../service/asociados.service';
import { AsociadoDetail } from '../interface/asociadosDetail.model';

@Component({
  selector: 'app-main-detail',
  templateUrl: './main-detail.component.html',
  styleUrl: './main-detail.component.css'
})
export class MainDetailComponent {
  asocDet: AsociadoDetail[];
  asociado: Asociados;
  index: number

  constructor(private asociadoService: AsociadosServicio,private route: ActivatedRoute, private router: Router){
    this.index = route.snapshot.params['id'];
    this.asociado=asociadoService.obtenerArray(this.index)

    if (this.asociado == null) {
      router.navigate(['main'])
    } else {
      console.log(this.asociado);
      console.log(this.asociado.id_as_pry!);
      asociadoService.obtenerAsociado(this.asociado.id_as_pry!).subscribe((res => {
        this.asocDet=res
        console.log(this.asocDet);
      }))
    }
  }
}
