//FECHA ACTUAL EN FORMATO TEXTO  
//Autor: Iván Nieto Pérez  
//Este script y otros muchos pueden  
//descarse on-line de forma gratuita  
//en El Código: www.elcodigo.com  
  
function MostrarFecha()  
   {  
   var nombres_dias = new Array("Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sábado");
   var nombres_meses = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");
  
   var fecha_actual = new Date();
  
   dia_mes = fecha_actual.getDate();     //dia del mes  
   dia_semana = fecha_actual.getDay();       //dia de la semana  
   mes = fecha_actual.getMonth() + 1;  
   anio = fecha_actual.getFullYear();  
  
   //escribe en pagina  
   document.write(nombres_dias[dia_semana] + ", " + dia_mes + " de " + nombres_meses[mes - 1] + " de " + anio);  
   }  
  