using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TrabajadorPuestoBE
/// </summary>
namespace BETrabajadorPuesto
{
    public class TrabajadorPuestoBE
    {
        public TrabajadorPuestoBE()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int codigo
        {
            get;
            set;

        }

        public int idTrabajador
        {
            get;
            set;

        }

        public int idTipoTrabajador
        {
            get;
            set;

        }

        public int idCargo
        {
            get;
            set;

        }

        public DateTime FechaInicio
        {
            get;
            set;

        }

        public DateTime FechaFin
        {
            get;
            set;

        }

        public string Activo
        {
            get;
            set;

        }

    }
}