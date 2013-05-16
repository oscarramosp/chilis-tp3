using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FormacionBE
/// </summary>
namespace BEFormacion
{
    public class FormacionBE
    {
        public FormacionBE()
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

        public int IdNivelFormacion
        {
            get;
            set;

        }

        public string Titulo
        {
            get;
            set;

        }

        public DateTime FechaTitulacion
        {
            get;
            set;

        }

        public int IdSituacionFormacion
        {
            get;
            set;

        }

        public int AnioFormado
        {
            get;
            set;

        }

    }
}