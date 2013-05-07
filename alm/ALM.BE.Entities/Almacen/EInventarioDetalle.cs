using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace ALM.BE.Entities.Almacen
{  [Serializable]

    public class EInventarioDetalle {

        public Int32 Codigo { get; set; }
        public Int32 CodigoCabecera { get; set; }
        public Int32 Item { get; set; }
        public String Descripcion { get; set; }
        public Decimal CantidadActual { get; set; }
        public String Medida { get; set; }
        public Int32 codProducto { get; set; }
        public String nombreProducto { get; set; }
        public String codigoPr { get; set; }
    
    }
}
