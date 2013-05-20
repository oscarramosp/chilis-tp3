using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BELocal: BEBase
    {
        public int CodigoLocal{ get; set; }
        public string Nombre { get; set; }
        public string Direccion { get; set; }
        public string Telefono { get; set; }
        public int Capacidad { get; set; }

        public BELocal() { }
        public BELocal(IDataReader reader) { }
    }
}
