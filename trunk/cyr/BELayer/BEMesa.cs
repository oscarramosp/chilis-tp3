using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BEMesa : BEBase
    {
        public int CodigoMesa { get; set; }
        public string NumeroMesa { get; set; }
        public int Capacidad { get; set; }
        public string Estado { get; set; }
        public int CodigoLocal { get; set; }

        public BEMesa() { }
        public BEMesa(IDataReader reader) { }
    }
}
