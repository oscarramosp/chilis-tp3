using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for DisponibilidadDAO
/// </summary>
namespace DAODisponibilidad{
public class DisponibilidadDAO
{
	public DisponibilidadDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string getCNX()
    {
        string sqlCon = ConfigurationManager.ConnectionStrings["sqlconnection"].ConnectionString;
        return sqlCon;
    }

    public DataTable getDisponibilidad()
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ListarDisponibilidad";
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarDisponibilidad");

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                cmd.Dispose();
                if (Con.State != ConnectionState.Closed)
                    Con.Close();
            }
            return ds.Tables[0];
        }
    }

  
}
