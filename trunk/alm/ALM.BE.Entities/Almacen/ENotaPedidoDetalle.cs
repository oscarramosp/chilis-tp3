using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace AppAlmacen.Almacen

{
    [Serializable]
    public class ENotaPedidoDetalle : EAuditoria
    {
        public int CodigoDetalle { get; set; }
        public int CodigoPedido { get; set; }
       
        public string CodigoDetalle2 { get; set; }

        public string CodProducto { get; set; }
        public int CodigoProducto { get; set; }
        public int CodItem { get; set; }
        public string CodItem2 { get; set; }

        public string descripcion { get; set; }
        public Decimal cantActual { get; set; }
        public Decimal cantModif { get; set; }
        public string medida { get; set; }
        public string lote { get; set; }
        public string serie { get; set; }
       
        public int marca{ get; set; }
        public string DesMarca { get; set; }
        public DateTime fechaCaducidad { get; set; }
        public DateTime fechaElaboracion { get; set; }

        public Decimal precioUnitario { get; set; }
        public Decimal precioTotal { get; set; }

        public string DesUN { get; set; }
        
    }
}
