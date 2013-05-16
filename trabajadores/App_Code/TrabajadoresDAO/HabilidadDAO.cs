using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEHabilidad;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for HabilidadDAO
/// </summary>
namespace DAOHabilidad
{
    public class HabilidadDAO
    {
        public HabilidadDAO()
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

        public Boolean EliminarHabilidad(int idPostulante, int IdHabilidadLinguistica)
        {
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "EliminarLinguistica";
                cmd.Parameters.Add(new SqlParameter("@idPostulante", idPostulante));
                cmd.Parameters.Add(new SqlParameter("@IdHabilidadLinguistica", IdHabilidadLinguistica));

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

        public Boolean InsertarHabilidad(HabilidadBE Po)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "IngresarHabilidad";
                cmd.Parameters.Add(new SqlParameter("@IdPostulante", Po.IdPostulante));
                cmd.Parameters.Add(new SqlParameter("@IdIdioma", Po.IdIdioma));
                cmd.Parameters.Add(new SqlParameter("@Lectura", Po.Lectura));
                cmd.Parameters.Add(new SqlParameter("@Escritura", Po.Escritura));
                cmd.Parameters.Add(new SqlParameter("@Hablado", Po.Hablado));

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
        public Boolean ActualizarHabilidad(HabilidadBE Po)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ActualizarLinguistica";
                
                cmd.Parameters.Add(new SqlParameter("@IdPostulante", Po.IdPostulante));
                cmd.Parameters.Add(new SqlParameter("@IdIdioma", Po.IdIdioma));
                cmd.Parameters.Add(new SqlParameter("@Lectura", Po.Lectura));
                cmd.Parameters.Add(new SqlParameter("@Escritura", Po.Escritura));
                cmd.Parameters.Add(new SqlParameter("@Hablado", Po.Hablado));

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

        public DataTable getHabilidad(int idPostulante)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;

            DataSet ds = null;

            try
            {

                Con.Open();

                cmd.CommandText = "ListarLinguistica";
                cmd.Parameters.Add(new SqlParameter("@idPostulante", idPostulante));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarLinguistica");

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