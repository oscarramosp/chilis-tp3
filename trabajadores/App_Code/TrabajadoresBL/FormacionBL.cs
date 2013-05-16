using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEFormacion;
using DAOFormacion;
using System.Data;

/// <summary>
/// Summary description for FormacionBL
/// </summary>
namespace BLFormacion 
{
    public class FormacionBL
    {
        public FormacionBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public Boolean ActualizarFormacion(FormacionBE Po)
        {

            FormacionDAO oFormacion = new FormacionDAO();

            if (oFormacion.ActualizarFormacion(Po) == true) return true;
            else return false;

        }
        public Boolean InsertarFormacion(FormacionBE Po)
        {
            
            FormacionDAO oFormacion = new FormacionDAO();

            if (oFormacion.InsertarFormacion(Po) == true) return true;
            else return false;
   
        }

        public Boolean EliminarFormacion(int idPostulante, int idFormacion)
        {

            FormacionDAO oFormacion = new FormacionDAO();

            if (oFormacion.EliminarFormacion(idPostulante,idFormacion) == true) return true;
            else return false;

        }

        public DataTable getFormacion(int idPostulante)
        {

            FormacionDAO oFormacion = new FormacionDAO();
            return oFormacion.getFormacion(idPostulante);
        }

    }
}