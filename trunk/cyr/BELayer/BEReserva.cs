using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BEReserva : BEBase
    {
        public int CodigoReserva { get; set; }
        public DateTime? FechaReserva { get; set; }
        public string HoraInicio { get; set; }
        public string HoraFin { get; set; }
        public int CantidadPersonas { get; set; }
        public string Observacion { get; set; }
        public string Estado { get; set; }
        public int CantidadHoras { get; set; }
        public BECliente Cliente { get; set; }
        public BEMesa Mesa { get; set; }

        public BEReserva() { }
        public BEReserva(IDataReader reader) { }
    }
}
