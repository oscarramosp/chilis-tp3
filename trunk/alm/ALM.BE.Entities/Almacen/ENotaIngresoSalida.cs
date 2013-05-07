using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace AppAlmacen.Almacen

{
    [Serializable]
    public class ENotaIngresoSalida : EAuditoria
    {
        public int CodigoIS { get; set; }
        public string CodigoIS2 { get; set; }

        public ENotaPedido NotaPedido { get; set; }
        public string tipoDocumento{ get; set; }
        public string DestipoDocumento { get; set; }

        public DateTime fecha { get; set; }
        public string periodo{ get; set; }
        public string transTipo{ get; set; }
        public string DestransTipo { get; set; }
        
        public string referTipo { get; set; }
        public string DesreferTipo { get; set; }
        
        public string referNumDoc { get; set; }
        public string unidOrigen { get; set; }
        public string unidDestino { get; set; }
        public int CodunidOrigen { get; set; }
        public int CodunidDestino { get; set; }

        public int CodPedido { get; set; }
        public string CodPedido2 { get; set; }
        public string correlativo { get; set; }


        public string empleado { get; set; }

        public List<ENotaIngresoSalidaDetalle> NotaISDetalle { get; set; }
      
        
    }
}
