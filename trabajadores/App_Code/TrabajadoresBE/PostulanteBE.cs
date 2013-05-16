using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PostulanteBE
/// </summary>
/// 
namespace BEPostulante
{
    public class PostulanteBE
    {
        public PostulanteBE()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int idPostulante
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



        public string DNI
        {
            get;
            set;
        }

        public DateTime FechaNacimiento
        {
            get;
            set;
        }


        public string Sexo
        {
            get;
            set;
        }


        public int IdNacionalidad
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

        public string Correo
        {
            get;
            set;
        }

        public int IdCargo
        {
            get;
            set;
        }

        public int IdDisponibilidad
        {
            get;
            set;
        }
    }
}