using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BETrabajador
{
    public class TrabajadorBE
    {
        public TrabajadorBE()
        {
        }
        public int idTrabajador
        {
            get;
            set;

        }

        public string Nombre
        {
            get;
            set;

        }


        public string Paterno
        {
            get;
            set;
        }

        public string Materno
        {
            get;
            set;

        }

        public int IdCargo
        {
            get;
            set;
        }

        public int IdTipoTrabjador
        {
            get;
            set;
        }

        public DateTime FechaNacimiento
        {
            get;
            set;
        }


        public string TipoDocumento
        {
            get;
            set;
        }

        public string NumeroDocumento
        {
            get;
            set;
        }

      

        public string Direccion
        {
            get;
            set;
        }


        public string Telefono
        {
            get;
            set;
        }

        public string Activo
        {
            get;
            set;
        }

        public string Sexo
        {
            get;
            set;
        }


        public string Correo
        {
            get;
            set;
        }

     

    }
}