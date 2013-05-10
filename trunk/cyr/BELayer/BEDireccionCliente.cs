using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BEDireccionCliente : BEBase
    {
        public int CodigoDireccion { get; set; }
        public string Direccion { get; set; }
        public string Referencia { get; set; }
        public string Telefono { get; set; }
        public string TipoDireccion { get; set; }

        public BEDireccionCliente() { }
        public BEDireccionCliente(IDataReader reader) { }
    }
}
