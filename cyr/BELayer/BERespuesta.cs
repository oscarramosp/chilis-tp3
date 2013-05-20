using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BERespuesta : BEBase
    {
        public int NumeroRespuesta { get; set; }
        public int CodigoRespuesta { get; set; }
        public string Respuesta { get; set; }
        public DateTime? FechaRespuesta { get; set; }        
        public int CodigoReclamo { get; set; }

        public BERespuesta() { }
        public BERespuesta(IDataReader reader) { }
    }
}
