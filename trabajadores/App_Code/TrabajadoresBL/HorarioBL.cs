using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEHorario;
using DAOHorario;
using System.Data;

/// <summary>
/// Summary description for HorarioBL
/// </summary>
namespace BLHorario
{
    public class HorarioBL
    {
        public HorarioBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public DataTable getHorassSemanaLunes(int idSemana,string Horas) {

            HorarioDAO oHoras = new HorarioDAO();

            return oHoras.getHorassSemanaLunes(idSemana,Horas);
        
        }

        public DataTable getHorassSemanaMartes(int idSemana, string Horas)
        {

            HorarioDAO oHoras = new HorarioDAO();

            return oHoras.getHorassSemanaMartes(idSemana, Horas);

        }

        public DataTable getHorassSemanaMiercoles(int idSemana, string Horas)
        {

            HorarioDAO oHoras = new HorarioDAO();

            return oHoras.getHorassSemanaMiercoles(idSemana, Horas);

        }

        public DataTable getHorassSemanaJueves(int idSemana, string Horas)
        {

            HorarioDAO oHoras = new HorarioDAO();

            return oHoras.getHorassSemanaJueves(idSemana, Horas);

        }

        public DataTable getHorassSemanaViernes(int idSemana, string Horas)
        {

            HorarioDAO oHoras = new HorarioDAO();

            return oHoras.getHorassSemanaViernes(idSemana, Horas);

        }

        public DataTable getHorassSemanaSabado(int idSemana, string Horas)
        {

            HorarioDAO oHoras = new HorarioDAO();

            return oHoras.getHorassSemanaSabado(idSemana, Horas);

        }

        public DataTable getHorassSemanaDomingo(int idSemana, string Horas)
        {

            HorarioDAO oHoras = new HorarioDAO();

            return oHoras.getHorassSemanaDomingo(idSemana, Horas);

        }

        public DataTable getHoras()
        {
            HorarioDAO oHoras = new HorarioDAO();

            return oHoras.getHoras();

        }

        public string InsertarHorario(HorarioBE Ho,int Tipo,decimal Total)
        {
            string texto = "";

            if (Tipo == 2 && Total > 20)
            {
                texto= "Trabajador Part Time no puede exceder las 20 horas semanales";
            }
            else if  (Tipo==1 && Total >40)
            {
                texto = "Trabajador Full Time no puede exceder las 40 horas semanales";
            }
            else
            {
                HorarioDAO oHorario = new HorarioDAO();
                if (oHorario.InsertarHorario(Ho) == true)
                {
                    texto = "Se ingreso Horario Correctamente";
                }
                else texto = "Fallo el Ingreso";
            }
            return texto;
        }

        public HorarioBE getHorario(int idTrabajador, int idsemana, int idTipo)
        {

            HorarioDAO oHorario = new HorarioDAO();
            return oHorario.getHorarioxSemanaxTrabajador(idTrabajador, idsemana, idTipo);
        }
    }
}