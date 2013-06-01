using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace AppAlmacen.Almacen
{
    [Serializable]
    public class EFichaProducto : EAuditoria
    {
        public int Codigo { get; set; }
        public string codProducto { get; set; }
        public int codigoP { get; set; }
        public string Descripcion { get; set; }
        public int Item { get; set; }
        public string Lote { get; set; }
        public string Serie { get; set; }
        public string Tipo { get; set; }
        public decimal Cantidad { get; set; }
        public decimal Precio { get; set; }
        public string Medida { get; set; }
        public DateTime Fecha_Recepcion { get; set; }
        public DateTime Fecha_Elaboracion { get; set; }
        public DateTime Fecha_Vencimiento { get; set; }
        public int CodUN { get; set; }
        public int CodMarca { get; set; }

        public string UN { get; set; }
        public string Marca { get; set; }
        public decimal Total { get; set; }

        public int CodNotaIS { get; set; }
    }
}