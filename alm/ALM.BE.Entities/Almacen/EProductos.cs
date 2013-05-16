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
        public string CodigoPr { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Familia { get; set; }
        public string SubFamilia { get; set; }
        public string Medida { get; set; }
        public string Marca { get; set; }
        public string UN { get; set; }
        public int CodUN { get; set; }
        public int CodMarca { get; set; }
    }

    [Serializable]
    public class EUltimoItem : EAuditoria
    {
        public int UltimoItem { get; set; }
     }
}
