using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;
using AppAlmacen;

namespace ALM.BE.Entities.Almacen
{
     [Serializable]
    public class EInventarioCabecera : EAuditoria
    {
        public Int32 Codigo { get; set; }
        public String Referencia { get; set; }
        public DateTime Fecha { get; set; }
        public String Responsable { get; set; }
        public String Aprobado { get; set; }
        public Int32 Estado { get; set; }
        public List<EInventarioDetalle> ListadDetalle { get; set; }


        public string NombreEstado { get; set; }

        public string codigoPr { get; set; }
    }
}
