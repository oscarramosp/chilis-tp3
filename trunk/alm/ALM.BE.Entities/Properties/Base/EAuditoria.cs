using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;


namespace AppAlmacen
{
     [Serializable]
    public class EAuditoria
    {
        public int Correlativo { get; set; }
        public Boolean? EsActivo { get; set; }
        public String Version { get; set; }
        public int UsuarioRegistra { get; set; }
        public DateTime FechaRegistro { get; set; }
        public int UsuarioElimina { get; set; }
        public DateTime? FechaElimina { get; set; }
        public int UsuarioModifica { get; set; }
        public DateTime? FechaModifica { get; set; }
    }
}