using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BEReclamo : BEBase 
    {
        public int CodigoReclamo { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? FechaCierre { get; set; }
        public string Detalle { get; set; }
        public string Estado { get; set; }
        public int CodigoLocal { get; set; }
        public string TipoReclamo { get; set; }

        public BECliente Cliente { get; set; }

        public List<BERespuesta> Respuestas { get; set; }

        public BEReclamo() { }
        public BEReclamo(IDataReader reader) { }
    }
}
