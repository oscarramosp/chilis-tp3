using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace AppAlmacen.Almacen

{
    [Serializable]
    public class EProductos : EAuditoria
    {
        public int Codigo { get; set; }
        public String CodigoPr { get; set; }
        public String Nombre { get; set; }
        public String Descripcion { get; set; }



        public string Medida { get; set; }
    }
}
