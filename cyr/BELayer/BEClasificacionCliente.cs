using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BEClasificacionCliente : BEBase
    {
        public int CodigoClasificacion { get; set; }
        public string Nombre { get; set; }

        public BEClasificacionCliente() { }
        public BEClasificacionCliente(IDataReader reader) { }
    }
}
