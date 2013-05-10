using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BEParametroClasificacion : BEBase
    {
        public int CodigoParametro { get; set; }
        public string Nombre { get; set; }

        public BEParametroClasificacion() { }
        public BEParametroClasificacion(IDataReader reader) { }
    }
}
