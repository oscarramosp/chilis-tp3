using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BETrabajador;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


/// <summary>
/// Summary description for TrabajadorDAO
/// </summary>
namespace DAOTrabajador
{
    public class TrabajadorDAO
    {
        public string getCNX()
        {
            string sqlCon = ConfigurationManager.ConnectionStrings["sqlconnection"].ConnectionString;
            return sqlCon;
        }

        public TrabajadorDAO()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int InsertarTrabajador(TrabajadorBE Po)
        {
            int idTrabajador = 0;
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "IngresarTrabajador";
                cmd.Parameters.Add(new SqlParameter("@Nombre", Po.Nombre));
                cmd.Parameters.Add(new SqlParameter("@ApellidoPaterno", Po.Paterno));
                cmd.Parameters.Add(new SqlParameter("@ApellidoMaterno", Po.Materno));
                cmd.Parameters.Add(new SqlParameter("@idCargo", Po.IdCargo));
                cmd.Parameters.Add(new SqlParameter("@IdTipoTrabjador", Po.IdTipoTrabjador));
                cmd.Parameters.Add(new SqlParameter("@FechaNacimiento", Po.FechaNacimiento));
                cmd.Parameters.Add(new SqlParameter("@TipoDocumento", Po.TipoDocumento));
                cmd.Parameters.Add(new SqlParameter("@NumeroDocumento", Po.NumeroDocumento));
                cmd.Parameters.Add(new SqlParameter("@Direccion", Po.Direccion));
                cmd.Parameters.Add(new SqlParameter("@Telefono", Po.Telefono));
                cmd.Parameters.Add(new SqlParameter("@Activo", Po.Activo));
                cmd.Parameters.Add(new SqlParameter("@Sexo", Po.Sexo));
                cmd.Parameters.Add(new SqlParameter("@Correo", Po.Correo));
                
                cmd.Parameters.Add(new SqlParameter("@idTrabajador", 0)).Direction = ParameterDirection.Output;

                Con.Open();
                cmd.ExecuteNonQuery();

                idTrabajador = int.Parse(cmd.Parameters["@idTrabajador"].Value.ToString());

                Con.Close();
                return idTrabajador;
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

        public Boolean ActualizarTrabajador(TrabajadorBE Po)
        {
            
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ActualizarTrabajador";
                cmd.Parameters.Add(new SqlParameter("@idTrabajador", Po.idTrabajador));
                cmd.Parameters.Add(new SqlParameter("@Nombre", Po.Nombre));
                cmd.Parameters.Add(new SqlParameter("@ApellidoPaterno", Po.Paterno));
                cmd.Parameters.Add(new SqlParameter("@ApellidoMaterno", Po.Materno));
                cmd.Parameters.Add(new SqlParameter("@idCargo", Po.IdCargo));
                cmd.Parameters.Add(new SqlParameter("@IdTipoTrabjador", Po.IdTipoTrabjador));
                cmd.Parameters.Add(new SqlParameter("@FechaNacimiento", Po.FechaNacimiento));
                cmd.Parameters.Add(new SqlParameter("@TipoDocumento", Po.TipoDocumento));
                cmd.Parameters.Add(new SqlParameter("@NumeroDocumento", Po.NumeroDocumento));
                cmd.Parameters.Add(new SqlParameter("@Direccion", Po.Direccion));
                cmd.Parameters.Add(new SqlParameter("@Telefono", Po.Telefono));
                cmd.Parameters.Add(new SqlParameter("@Activo", Po.Activo));
                cmd.Parameters.Add(new SqlParameter("@Sexo", Po.Sexo));
                cmd.Parameters.Add(new SqlParameter("@Correo", Po.Correo));
                

                Con.Open();
                cmd.ExecuteNonQuery();
                Con.Close();
                return true;
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

        public DataTable getTrabajador(int idTrabajador)
        {
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            DataSet ds = null;

            try
            {

                Con.Open();

                cmd.CommandText = "ListarTrabajador";
                cmd.Parameters.Add(new SqlParameter("@idTrabajador", idTrabajador));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarTrabajador");

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

        public DataTable getTrabajadoresActivos()
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ListarTrabajadoresActivos";
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarTrabajadoresActivos");

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

        public DataTable ReporteTrabajadores(string Estado)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            DataSet ds = null;

            try
            {

                //Con.Open();

                cmd.CommandText = "ReporteTrabajadores";
                cmd.Parameters.Add(new SqlParameter("@activo", Estado));
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "Reporte");
                
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