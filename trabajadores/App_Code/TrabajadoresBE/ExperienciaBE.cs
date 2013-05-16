using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ExperienciaBE
/// </summary>
namespace BEExperiencia
{
    public class ExperienciaBE
    {
        public ExperienciaBE()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int IdPostulante
        {
            get;
            set;

        }

        public string NombreEmpresa
        {
            get;
            set;

        }

        public DateTime FechaInicio
        {
            get;
            set;

        }

        public DateTime FechaFinal
        {
            get;
            set;

        }

        public int IdCargo
        {
            get;
            set;
        }


        public string Responsabilidad
        {
            get;
            set;

        }
    }
}