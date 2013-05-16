using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using BEHoraExtra;

/// <summary>
/// Summary description for HoraExtraDAO
/// </summary>
namespace DAOHoraExtra
{
    public class HoraExtraDAO
    {
        public HoraExtraDAO()
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

        public Boolean InsertarHoraExtra(HoraExtraBE Po)
        {
            
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "IngresarHoraExtra";
                cmd.Parameters.Add(new SqlParameter("@IdTrabajador", Po.idTrabajador));
                cmd.Parameters.Add(new SqlParameter("@IdSemana", Po.idSemana));
                cmd.Parameters.Add(new SqlParameter("@Lunes", Po.Lunes));
                cmd.Parameters.Add(new SqlParameter("@Martes", Po.Martes));
                cmd.Parameters.Add(new SqlParameter("@Miercoles", Po.Miercoles));
                cmd.Parameters.Add(new SqlParameter("@Jueves", Po.Jueves));
                cmd.Parameters.Add(new SqlParameter("@Viernes", Po.Viernes));
                cmd.Parameters.Add(new SqlParameter("@Sabado", Po.Sabado));
                cmd.Parameters.Add(new SqlParameter("@Domingo", Po.Domingo));
    
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

        public HoraExtraBE getHoraExtraxSemanaxTrabajador(int idTrabajador, int idsemana)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            HoraExtraBE Horario = new HoraExtraBE();

            try
            {
                Con.Open();

                cmd.CommandText = "ListarHoraExtrasxSemanaxTrabajador";
                cmd.Parameters.Add(new SqlParameter("@idTrabajador", idTrabajador));
                cmd.Parameters.Add(new SqlParameter("@idSemana", idsemana));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHoraExtrasxSemanaxTrabajador");

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    Horario.Lunes = int.Parse(row["Lunes"].ToString());
                    Horario.Martes = int.Parse(row["Martes"].ToString());
                    Horario.Miercoles = int.Parse(row["Miercoles"].ToString());
                    Horario.Jueves = int.Parse(row["Jueves"].ToString());
                    Horario.Viernes = int.Parse(row["Viernes"].ToString());
                    Horario.Sabado = int.Parse(row["Sabado"].ToString());
                    Horario.Domingo = int.Parse(row["Domingo"].ToString());
                }

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
            return Horario;
        }
    }
}