using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BEFechaEspecial
    {
        public int Codigo { get; set; }
        public DateTime? Fecha { get; set; }
        public string Motivo { get; set; }

        public BEFechaEspecial()
        {
        }

        public BEFechaEspecial(IDataReader reader) 
        {
        }
    }
}
