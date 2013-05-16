using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEFormacion;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for FormacionDAO
/// </summary>
/// 
namespace DAOFormacion
{

public class FormacionDAO
{
	public FormacionDAO()
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

       public Boolean EliminarFormacion(int idPostulante,int idFormacion)
       {
           SqlConnection Con = new SqlConnection(getCNX());
           SqlCommand cmd = new SqlCommand();

           try
           {
               cmd.Connection = Con;
               cmd.CommandType = CommandType.StoredProcedure;
               cmd.CommandText = "EliminarFormacion";
               cmd.Parameters.Add(new SqlParameter("@idPostulante", idPostulante));
               cmd.Parameters.Add(new SqlParameter("@idFormacion", idFormacion));

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
       public Boolean InsertarFormacion(FormacionBE Po)
       {
          
           SqlConnection Con = new SqlConnection(getCNX());
           SqlCommand cmd = new SqlCommand();

           try
           {
               cmd.Connection = Con;
               cmd.CommandType = CommandType.StoredProcedure;
               cmd.CommandText = "IngresarFormacion";
               cmd.Parameters.Add(new SqlParameter("@IdPostulante", Po.IdPostulante));
               cmd.Parameters.Add(new SqlParameter("@IdNivelFormacion", Po.IdNivelFormacion));
               cmd.Parameters.Add(new SqlParameter("@Titulo", Po.Titulo));
               cmd.Parameters.Add(new SqlParameter("@FechaTitulacion", Po.FechaTitulacion));
               cmd.Parameters.Add(new SqlParameter("@IdSituacionFormacion", Po.IdSituacionFormacion));
               cmd.Parameters.Add(new SqlParameter("@AnioFormado", Po.AnioFormado));
      
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

       public Boolean ActualizarFormacion(FormacionBE Po)
       {

           SqlConnection Con = new SqlConnection(getCNX());
           SqlCommand cmd = new SqlCommand();

           try
           {
               cmd.Connection = Con;
               cmd.CommandType = CommandType.StoredProcedure;
               cmd.CommandText = "ActualizarFormacion";
               cmd.Parameters.Add(new SqlParameter("@IdPostulante", Po.IdPostulante));
               cmd.Parameters.Add(new SqlParameter("@IdNivelFormacion", Po.IdNivelFormacion));
               cmd.Parameters.Add(new SqlParameter("@Titulo", Po.Titulo));
               cmd.Parameters.Add(new SqlParameter("@FechaTitulacion", Po.FechaTitulacion));
               cmd.Parameters.Add(new SqlParameter("@IdSituacionFormacion", Po.IdSituacionFormacion));
               cmd.Parameters.Add(new SqlParameter("@AnioFormado", Po.AnioFormado));

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

       public DataTable getFormacion(int idPostulante)
       {

           SqlConnection Con = new SqlConnection(getCNX());
           SqlCommand cmd = new SqlCommand();
           SqlDataAdapter adapter;

           DataSet ds = null;

           try
           {

               Con.Open();

               cmd.CommandText = "ListarFormacion";
               cmd.Parameters.Add(new SqlParameter("@idPostulante", idPostulante));

               cmd.CommandType = CommandType.StoredProcedure;
               cmd.Connection = Con;
               ds = new DataSet();
               adapter = new SqlDataAdapter(cmd);
               adapter.Fill(ds, "ListarFormacion");

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