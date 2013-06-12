﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace AppAlmacen.Almacen

{
    [Serializable]
    public class ENotaPedido : EAuditoria
    {
        public int Codigo { get; set; }
        public string Codigo2 { get; set; }
        public string Correlativo { get; set; }

        public DateTime fechaEmision { get; set; }
        public int almacenOrigen { get; set; }
        public string desalmacenOrigen { get; set; }
        public int almacenDestino { get; set; }
        public string desalmacenDestino { get; set; }
        public string areaSoliciante { get; set; }
        public string tipoOperacion { get; set; }
        public string registrador { get; set; }
        public string autorizador { get; set; }
        public string estadoNota { get; set; }
        public DateTime fechaEstadoNota { get; set; }
        public decimal precioPedido { get; set; }


        public List<ENotaPedidoDetalle> NotaPedido { get; set; }
        
    }
}