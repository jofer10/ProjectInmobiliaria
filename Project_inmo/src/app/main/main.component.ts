import { Component } from '@angular/core';
import { AsociadosServicio } from '../service/asociados.service';
import { Asociados } from '../interface/asociados.model';
import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrl: './main.component.css'
})
export class MainComponent {
  asociados: Asociados[];
  buscarProyecto: string
  startDate: Date
  endDate: Date
  
    constructor(private asociadosService: AsociadosServicio, private datePipe: DatePipe) {
      const fechaActual = new Date()
      
      this.endDate=fechaActual

      const pastDate = new Date()
      pastDate.setDate(fechaActual.getDate()-180)
      this.startDate=pastDate

      // Convertir las fechas a string para enviar los datos al back
      let name_proyecto=this.buscarProyecto?this.buscarProyecto:''
      let inicioFecha=datePipe.transform(this.startDate, 'dd/MM/yyyy')
      let finFecha=datePipe.transform(this.endDate, 'dd/MM/yyyy')

      asociadosService.obtenerAsociadosDefa(name_proyecto!,inicioFecha!,finFecha!).subscribe((res)=>{
        if (res == null) {
          this.asociados=[]
          asociadosService.setAsociados(this.asociados)
        } else {
          this.asociados=res
          console.log(this.asociados);
          asociadosService.setAsociados(this.asociados)
        }
      })
    }

    search() {
      // convertir fechas a string para la consulta
      let inicioFecha=this.datePipe.transform(this.startDate, 'dd/MM/yyyy')
      let finFecha=this.datePipe.transform(this.endDate, 'dd/MM/yyyy')

      console.log(this.buscarProyecto?this.buscarProyecto:null+"\n"+this.datePipe.transform(this.startDate, 'dd/MM/yyyy')+"\n"+this.datePipe.transform(this.endDate, 'dd/MM/yyyy'));
      this.asociadosService.obtenerAsociadosDefa(this.buscarProyecto!, inicioFecha!, finFecha!).subscribe((res)=>{
        this.asociados=res
        console.log(this.asociados);
        this.asociadosService.setAsociados(res)
      })
    }
}
