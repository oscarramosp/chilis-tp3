using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BETrabajador;
using DAOTrabajador;
using System.Data;

/// <summary>
/// Summary description for TrabajadorBL
/// </summary>
namespace BLTrabajador
{
    public class TrabajadorBL
    {
        public TrabajadorBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public Boolean ActualizarTrabajador(TrabajadorBE Po)
        {
            
            TrabajadorDAO oTrab = new TrabajadorDAO();
            if(oTrab.ActualizarTrabajador(Po)==true) return true;
            else return false;

        }

        public int InsertarTrabajador(TrabajadorBE Po)
        {
            int idTrabajador = 0;
            TrabajadorDAO oTrab = new TrabajadorDAO();
            idTrabajador = oTrab.InsertarTrabajador(Po);
            oTrab = null;
            return idTrabajador;

        }

        public DataTable getTrabajadoresActivos()
        {

            TrabajadorDAO oListarTrab = new TrabajadorDAO();
            return oListarTrab.getTrabajadoresActivos();

        }

        public DataTable getTrabajador(int idTrabajador)
        {

            TrabajadorDAO oTrab = new TrabajadorDAO();
            return oTrab.getTrabajador(idTrabajador);
        }

        public DataTable ReporteTrabajadores(string Estado)
        {

            TrabajadorDAO oReporte = new TrabajadorDAO();
            return oReporte.ReporteTrabajadores(Estado);

        }
    }
}