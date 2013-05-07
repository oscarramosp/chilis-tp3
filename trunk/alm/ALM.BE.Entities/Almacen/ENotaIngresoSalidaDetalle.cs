using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace AppAlmacen.Almacen

{
    [Serializable]
    public class ENotaIngresoSalidaDetalle : EAuditoria
    {
        public int CodigoDetIS { get; set; }
        public int CodigoIS { get; set; }
        public int CodItem { get; set; }
        public string descripcion{ get; set; }
        public int cantActual { get; set; }
        public string medida { get; set; }
        public string lote { get; set; }
        public string serie{ get; set; }
        public DateTime fechaElaboracion { get; set; }
        public DateTime fechaCaducidad { get; set; }
        public Decimal precioUnitario { get; set; }
        public Decimal precioTotal { get; set; }
        
        
    }
}
