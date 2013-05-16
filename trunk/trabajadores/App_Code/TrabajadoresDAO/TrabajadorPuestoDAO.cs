using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BETrabajadorPuesto;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for TrabajadorPuestoDAO
/// </summary>
namespace DAOTrabajadorPuesto
{
    public class TrabajadorPuestoDAO
    {
        public TrabajadorPuestoDAO()
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

        public Boolean InsertarTrabajadorPuesto(TrabajadorPuestoBE Po)
        {
            
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "IngresarTrabajadorPuesto";
                cmd.Parameters.Add(new SqlParameter("@idTrabajador", Po.idTrabajador));
                cmd.Parameters.Add(new SqlParameter("@idCargo", Po.idCargo));
                cmd.Parameters.Add(new SqlParameter("@IdTipoTrabajador", Po.idTipoTrabajador));
                cmd.Parameters.Add(new SqlParameter("@FechaInicio", Po.FechaInicio));
                cmd.Parameters.Add(new SqlParameter("@FechaFin", Po.FechaFin));
                cmd.Parameters.Add(new SqlParameter("@Activo", Po.Activo));

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

        public Boolean ActualizarFechasTrabajadorPuesto(TrabajadorPuestoBE Po)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ActualizarFechasTrabajadorPuesto";
                cmd.Parameters.Add(new SqlParameter("@Codigo", Po.codigo));
                cmd.Parameters.Add(new SqlParameter("@FechaInicio", Po.FechaInicio));
                cmd.Parameters.Add(new SqlParameter("@FechaFin", Po.FechaFin));
                
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

        public DataTable getTrabajadoresPuestos(int idTrabajador)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;

            try
            {
                Con.Open();

                cmd.CommandText = "ListarTrabajadorPuestos";
                cmd.Parameters.Add(new SqlParameter("@idTrabajador", idTrabajador));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarTrabajadorPuestos");

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