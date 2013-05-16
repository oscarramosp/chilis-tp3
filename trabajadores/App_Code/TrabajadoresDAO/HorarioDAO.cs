using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using BEHorario;


/// <summary>
/// Summary description for HorarioDAO
/// </summary>
namespace DAOHorario
{
    public class HorarioDAO
    {
        public HorarioDAO()
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

        public Boolean InsertarHorario(HorarioBE Po)
        {

            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();

            try
            {
                cmd.Connection = Con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "IngresarHorario";
                cmd.Parameters.Add(new SqlParameter("@IdTrabajador", Po.idTrabajador));
                cmd.Parameters.Add(new SqlParameter("@IdSemana", Po.idSemana));
                cmd.Parameters.Add(new SqlParameter("@IdTipoRegistroHora", Po.IdTipoRegistroHora));
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
        public DataTable getHoras() { 
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            try
            {
                Con.Open();

                cmd.CommandText = "ListarHoras";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHoras");


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

        public HorarioBE getHorarioxSemanaxTrabajador(int idTrabajador, int idsemana, int idTipo)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            HorarioBE Horario = new HorarioBE();

            try
            {
                Con.Open();

                cmd.CommandText = "ListarHorarioxSemanaxTrabajador";
                cmd.Parameters.Add(new SqlParameter("@idTrabajador", idTrabajador));
                cmd.Parameters.Add(new SqlParameter("@idSemana", idsemana));
                cmd.Parameters.Add(new SqlParameter("@idTipo", idTipo));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHorarioxSemanaxTrabajador");

                foreach (DataRow row in ds.Tables[0].Rows)
                {

                    Horario.Lunes = row["Lunes"].ToString();
                    Horario.Martes = row["Martes"].ToString();
                    Horario.Miercoles = row["Miercoles"].ToString();
                    Horario.Jueves = row["Jueves"].ToString();
                    Horario.Viernes = row["Viernes"].ToString();
                    Horario.Sabado = row["Sabado"].ToString();
                    Horario.Domingo = row["Domingo"].ToString();
                   
                    
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

        public DataTable getHorassSemanaLunes(int idSemana, string hora)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            try
            {
                Con.Open();

                cmd.CommandText = "ListarHorasxSemanaLunes";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idSemana", idSemana));
                cmd.Parameters.Add(new SqlParameter("@Hora", hora));
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHorasxSemanaLunes");


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
        public DataTable getHorassSemanaMartes(int idSemana, string hora)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            try
            {
                Con.Open();

                cmd.CommandText = "ListarHorasxSemanaMartes";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idSemana", idSemana));
                cmd.Parameters.Add(new SqlParameter("@Hora", hora));
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHorasxSemanaMartes");


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

        public DataTable getHorassSemanaMiercoles(int idSemana, string hora)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            try
            {
                Con.Open();

                cmd.CommandText = "ListarHorasxSemanaMiercoles";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idSemana", idSemana));
                cmd.Parameters.Add(new SqlParameter("@Hora", hora));
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHorasxSemanaMiercoles");


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

        public DataTable getHorassSemanaJueves(int idSemana, string hora)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            try
            {
                Con.Open();

                cmd.CommandText = "ListarHorasxSemanaJueves";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idSemana", idSemana));
                cmd.Parameters.Add(new SqlParameter("@Hora", hora));
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHorasxSemanaJueves");


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

        public DataTable getHorassSemanaViernes(int idSemana, string hora)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            try
            {
                Con.Open();

                cmd.CommandText = "ListarHorasxSemanaViernes";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idSemana", idSemana));
                cmd.Parameters.Add(new SqlParameter("@Hora", hora));
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHorasxSemanaViernes");


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

        public DataTable getHorassSemanaSabado(int idSemana, string hora)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            try
            {
                Con.Open();

                cmd.CommandText = "ListarHorasxSemanaSabado";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idSemana", idSemana));
                cmd.Parameters.Add(new SqlParameter("@Hora", hora));
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHorasxSemanaSabado");


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

        public DataTable getHorassSemanaDomingo(int idSemana, string hora)
        {
            DataSet ds = new DataSet();
            SqlConnection Con = new SqlConnection(getCNX());
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            try
            {
                Con.Open();

                cmd.CommandText = "ListarHorasxSemanaDomingo";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idSemana", idSemana));
                cmd.Parameters.Add(new SqlParameter("@Hora", hora));
                cmd.Connection = Con;
                ds = new DataSet();
                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(ds, "ListarHorasxSemanaDomingo");


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