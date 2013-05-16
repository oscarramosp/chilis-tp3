using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using BECese;

/// <summary>
/// Summary description for CeseDAO
/// </summary>
namespace DAOCese
{
    public class CeseDAO
    {
        public CeseDAO()
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
        public Boolean InsertarCese(CeseBE Po)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "IngresarCese";
                cmd.Parameters.Add(new SqlParameter("@idTrabajador", Po.idtrabajador));
                cmd.Parameters.Add(new SqlParameter("@FechaCese", Po.FechaCese));
                cmd.Parameters.Add(new SqlParameter("@idMotivo", Po.idMotivo));
                cmd.Parameters.Add(new SqlParameter("@Observacion", Po.Observacion));
                cmd.Parameters.Add(new SqlParameter("@FechaCreacion", Po.FechaCreacion));

                Con.Open();
                cmd.ExecuteNonQuery();

                Con.Close();
                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw new Exception(ex.Message);

            }
            finally
            {
                cmd.Dispose();
                if (Con.State != ConnectionState.Closed)
                    Con.Close();
            }

        }
    }
}