using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEExperiencia;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for ExperienciaDAO
/// </summary>
namespace DAOExperiencia
{
    public class ExperienciaDAO
    {
        public ExperienciaDAO()
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

        public Boolean EliminarExperiencia(int idPostulante, int idExperiencia)
        {
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                 cmd.CommandText = "EliminarExperiencia";
                cmd.Parameters.Add(new SqlParameter("@idPostulante", idPostulante));
                cmd.Parameters.Add(new SqlParameter("@IdExperiencia", idExperiencia));

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


        public Boolean InsertarExperiencia(ExperienciaBE Po)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "IngresarExperiencia";
                cmd.Parameters.Add(new SqlParameter("@IdPostulante", Po.IdPostulante));
                cmd.Parameters.Add(new SqlParameter("@NombreEmpresa", Po.NombreEmpresa));
                cmd.Parameters.Add(new SqlParameter("@FechaInicio", Po.FechaInicio));
                cmd.Parameters.Add(new SqlParameter("@FechaFinal", Po.FechaFinal));
                cmd.Parameters.Add(new SqlParameter("@IdCargo", Po.IdCargo));
                cmd.Parameters.Add(new SqlParameter("@Responsabilidad", Po.Responsabilidad));



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

        public Boolean ActualizarExperiencia(ExperienciaBE Po)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ActualizarExperiencia";
                cmd.Parameters.Add(new SqlParameter("@idPostulante", Po.IdPostulante));
                cmd.Parameters.Add(new SqlParameter("@NombreEmpresa", Po.NombreEmpresa));
                cmd.Parameters.Add(new SqlParameter("@FechaInicio", Po.FechaInicio));
                cmd.Parameters.Add(new SqlParameter("@FechaFinal", Po.FechaFinal));
                cmd.Parameters.Add(new SqlParameter("@IdCargo", Po.IdCargo));
                cmd.Parameters.Add(new SqlParameter("@Responsabilidad", Po.Responsabilidad));



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

        public DataTable getExperiencia(int idPostulante)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;

            DataSet ds = null;

            try
            {

                Con.Open();

                cmd.CommandText = "ListarExperiencia";
                cmd.Parameters.Add(new SqlParameter("@idPostulante", idPostulante));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarExperiencia");

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