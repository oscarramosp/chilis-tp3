using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEExperiencia;
using DAOExperiencia;
using System.Data;

/// <summary>
/// Summary description for ExperienciaBL
/// </summary>
namespace BLExperiencia
{
    public class ExperienciaBL
    {
        public ExperienciaBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public Boolean ActualizarExperiencia(ExperienciaBE Po)
        {

            ExperienciaDAO oExperiencia = new ExperienciaDAO();

            if (oExperiencia.ActualizarExperiencia(Po) == true) return true;
            else return false;

        }

        public Boolean InsertarExperiencia(ExperienciaBE Po)
        {

            ExperienciaDAO oExperiencia = new ExperienciaDAO();

            if (oExperiencia.InsertarExperiencia(Po) == true) return true;
            else return false;

        }

        public Boolean EliminarExperiencia(int idPostulante, int idExperiencia)
        {

            ExperienciaDAO oExperiencia = new ExperienciaDAO();

            if (oExperiencia.EliminarExperiencia(idPostulante, idExperiencia) == true) return true;
            else return false;

        }

        public DataTable getExperiencia(int idPostulante)
        {

            ExperienciaDAO oExperiencia = new ExperienciaDAO();
            return oExperiencia.getExperiencia(idPostulante);
        }



    }
}