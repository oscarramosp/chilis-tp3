using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BETipoDocumento : BEBase
    {
        public int CodigoTipoDocumento { get; set; }
        public string Nombre { get; set; }
        public string Acronimo { get; set; }

        public BETipoDocumento() { }
        public BETipoDocumento(IDataReader reader) { }
    }
}
