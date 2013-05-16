using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEHabilidad;
using DAOHabilidad;
using System.Data;

/// <summary>
/// Summary description for HabilidadBL
/// </summary>
namespace BLHabilidad
{
    public class HabilidadBL
    {
        public HabilidadBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public Boolean ActualizarHabilidad(HabilidadBE Po)
        {

            HabilidadDAO oHabilidad = new HabilidadDAO();

            if (oHabilidad.ActualizarHabilidad(Po) == true) return true;
            else return false;
        }

        public Boolean InsertarHabilidad(HabilidadBE Po)
        {

            HabilidadDAO oHabilidad = new HabilidadDAO();

            if (oHabilidad.InsertarHabilidad(Po) == true) return true;
            else return false;
         }

        public Boolean EliminarHabilidad(int idPostulante, int IdHabilidadLinguistica)
        {

            HabilidadDAO oHabilidad = new HabilidadDAO();

            if (oHabilidad.EliminarHabilidad(idPostulante, IdHabilidadLinguistica) == true) return true;
            else return false;

        }

        public DataTable getHabilidad(int idPostulante)
        {

            HabilidadDAO oHabilidad = new HabilidadDAO();
            return oHabilidad.getHabilidad(idPostulante);
        }
    }
}