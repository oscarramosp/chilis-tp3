using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;
using System.Web.UI;
using AjaxControlToolkit;

using System.Configuration;

    public class Enumeraciones
    {

      

        public enum ETipoSeleccion
        {
            Todos = 1,
            Seleccione = 2
        }

        public enum TipoOperacion
        {
            Ninguna,
            Creacion,
            Modificacion,
            Eliminacion,
            Consulta,
            ConsultarEditar
        }

      

        public enum TipoArchivo
        {
            EXCEL,
            PDF
        }

        public enum TipoNotificacion
        {
            Asignacion,
            Observacion,
            Desestimacion,
            Indemnizacion,
            Documentado
        }

      
    }
