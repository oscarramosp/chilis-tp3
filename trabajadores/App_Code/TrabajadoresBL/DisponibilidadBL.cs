using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DAODisponibilidad;

/// <summary>
/// Summary description for DisponibilidadBL
/// </summary>
namespace BLDisponibilidad
{
    public class DisponibilidadBL
    {
        DisponibilidadDAO oLog = new DisponibilidadDAO();

        public DisponibilidadBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable getDisponibilidad()
        {


            return oLog.getDisponibilidad();

        }
    }
}