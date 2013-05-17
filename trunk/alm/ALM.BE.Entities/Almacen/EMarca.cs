using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace AppAlmacen.Almacen
{
    [Serializable]
    public class EMarca : EAuditoria
    {
        public int codMarca { get; set; }
        public String Descripcion { get; set; }
        
    }
}

