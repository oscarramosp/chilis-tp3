using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BEValorParametroClasificacion : BEBase 
    {
        public int CodigoParametro { get; set; }
        public int CodigoClasificacion { get; set; }
        public int Valor { get; set; }

        public BEValorParametroClasificacion() { }
        public BEValorParametroClasificacion(IDataReader reader) { }
    }
}
