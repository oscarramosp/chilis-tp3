using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BELayer
{
    public class BECliente : BEBase
    {
        public int CodigoCliente { get; set; }
        public string Nombres { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string NombreCompleto { get; set; }
        public string RazonSocial { get; set; }
        public string NumeroDocumento { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public int? CodigoClasificacion { get; set; }
        public string Email { get; set; }
        public string Sexo { get; set; }
        public string TelefonoPrincipal { get; set; }
        public string Contacto { get; set; }
        public string TipoCliente { get; set; }
        public string Estado { get; set; }

        public BETipoDocumento TipoDocumento { get; set; }
        public List<BEDireccionCliente> Direcciones { get; set; }

        public BECliente()
        {
            this.TipoDocumento = new BETipoDocumento();
            this.Direcciones = new List<BEDireccionCliente>();
        }

        public BECliente(IDataReader reader) 
        {
            this.TipoDocumento = new BETipoDocumento();
            this.Direcciones = new List<BEDireccionCliente>();
        }
    }
}
