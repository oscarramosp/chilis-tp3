using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DAOSituacion;

/// <summary>
/// Summary description for SituacionBL
/// </summary>
namespace BLSituacion{
public class SituacionBL
{
    SituacionDAO oLog = new SituacionDAO();
	public SituacionBL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

     public DataTable getSituacion()
        {
            return oLog.getSituacion();
        }
    }
}
