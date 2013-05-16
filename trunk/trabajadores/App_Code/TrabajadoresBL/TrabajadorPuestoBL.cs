using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BETrabajadorPuesto;
using DAOTrabajadorPuesto;
using System.Data;

/// <summary>
/// Summary description for TrabajadorPuestoBL
/// </summary>
namespace BLTrabajadorPuesto
{

    public class TrabajadorPuestoBL
    {
        public TrabajadorPuestoBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public Boolean InsertarTrabajador(TrabajadorPuestoBE Po)
        {
            
            TrabajadorPuestoDAO oTrab = new TrabajadorPuestoDAO();
            if(oTrab.InsertarTrabajadorPuesto(Po)) return true;
            else return false;
            
        }

        public Boolean ActualizarFechasTrabajadorPuesto(TrabajadorPuestoBE Po)
        {

            TrabajadorPuestoDAO oTrab = new TrabajadorPuestoDAO();
            if (oTrab.ActualizarFechasTrabajadorPuesto(Po)) return true;
            else return false;

        }

        public DataTable getTrabajadoresPuestos(int idTrabajador)
        {

            TrabajadorPuestoDAO oListarPuestos = new TrabajadorPuestoDAO();
            return oListarPuestos.getTrabajadoresPuestos(idTrabajador);

        }


    }
}