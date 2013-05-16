using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEPostulante;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for PostulanteDAO
/// </summary>
namespace DAOPostulante
{
    public class PostulanteDAO
    {
        public PostulanteDAO()
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

        public int InsertarPostulante(PostulanteBE Po)
        {
            int idPostulante = 0;
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "IngresarPostulante";
                cmd.Parameters.Add(new SqlParameter("@Nombre", Po.Nombre));
                cmd.Parameters.Add(new SqlParameter("@ApellidoPaterno", Po.Paterno));
                cmd.Parameters.Add(new SqlParameter("@ApellidoMaterno", Po.Materno));
                cmd.Parameters.Add(new SqlParameter("@DNI", Po.DNI));
                cmd.Parameters.Add(new SqlParameter("@FechaNacimiento", Po.FechaNacimiento));
                cmd.Parameters.Add(new SqlParameter("@Sexo", Po.Sexo));
                cmd.Parameters.Add(new SqlParameter("@IdNacionalidad", Po.IdNacionalidad));
                cmd.Parameters.Add(new SqlParameter("@Direccion", Po.Direccion));
                cmd.Parameters.Add(new SqlParameter("@Telefono", Po.Telefono));
                cmd.Parameters.Add(new SqlParameter("@Correo", Po.Correo));
                cmd.Parameters.Add(new SqlParameter("@idCargo", Po.IdCargo));
                cmd.Parameters.Add(new SqlParameter("@IdDisponibilidad", Po.IdDisponibilidad));
                cmd.Parameters.Add(new SqlParameter("@idPostulante", 0)).Direction=ParameterDirection.Output;
                
                Con.Open();
                cmd.ExecuteNonQuery();

                idPostulante = int.Parse(cmd.Parameters["@idPostulante"].Value.ToString());

                Con.Close();
                return idPostulante;
            }
            catch (Exception ex)
            {
                //return false;
                throw new Exception(ex.Message);
                
            }
            finally
            {
                cmd.Dispose();
                if (Con.State != ConnectionState.Closed)
                    Con.Close();
            }

        }

        public Boolean ActualizarPostulante(PostulanteBE Po)
        {
            
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ActualizarPostulante";
                cmd.Parameters.Add(new SqlParameter("@idPostulante", Po.idPostulante));
                cmd.Parameters.Add(new SqlParameter("@Nombre", Po.Nombre));
                cmd.Parameters.Add(new SqlParameter("@ApellidoPaterno", Po.Paterno));
                cmd.Parameters.Add(new SqlParameter("@ApellidoMaterno", Po.Materno));
                cmd.Parameters.Add(new SqlParameter("@DNI", Po.DNI));
                cmd.Parameters.Add(new SqlParameter("@FechaNacimiento", Po.FechaNacimiento));
                cmd.Parameters.Add(new SqlParameter("@Sexo", Po.Sexo));
                cmd.Parameters.Add(new SqlParameter("@IdNacionalidad", Po.IdNacionalidad));
                cmd.Parameters.Add(new SqlParameter("@Direccion", Po.Direccion));
                cmd.Parameters.Add(new SqlParameter("@Telefono", Po.Telefono));
                cmd.Parameters.Add(new SqlParameter("@Correo", Po.Correo));
                cmd.Parameters.Add(new SqlParameter("@idCargo", Po.IdCargo));
                cmd.Parameters.Add(new SqlParameter("@IdDisponibilidad", Po.IdDisponibilidad));
                

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

        public DataTable getPostulante(int idPostulante)
        {
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            DataSet ds = null;

            try
            {

                Con.Open();

                cmd.CommandText = "ListarPostulante";
                cmd.Parameters.Add(new SqlParameter("@idPostulante", idPostulante));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarPostulante");

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