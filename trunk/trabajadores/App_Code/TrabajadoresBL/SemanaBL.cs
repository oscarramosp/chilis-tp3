using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAOSemana;
using System.Data;

/// <summary>
/// Summary description for SemanaBL
/// </summary>
namespace BLSemana{
public class SemanaBL
{
	public SemanaBL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DataTable getSemana()
    {

        SemanaDAO oSemana = new SemanaDAO();
        return oSemana.getSemana();
    }
}
}