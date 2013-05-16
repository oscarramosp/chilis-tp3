using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEHoraExtra;
using DAOHoraExtra;
using System.Data;

/// <summary>
/// Summary description for HoraExtraBL
/// </summary>
namespace BLHoraExtra
{
    public class HoraExtraBL
    {
        public HoraExtraBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public HoraExtraBE getHoraExtra(int idTrabajador, int idsemana)
        {

            HoraExtraDAO oHorario = new HoraExtraDAO();
            return oHorario.getHoraExtraxSemanaxTrabajador(idTrabajador, idsemana);
        }

        public string InsertarHoraExtra(HoraExtraBE Ho,int Tipo, decimal Total)
        {
            string texto = "";
          
            if (Tipo == 2 )
            {
                texto = "Trabajador Part Time no puede tener Horas Extras";
            }
            else if (Tipo == 1 && Total > 15)
            {
                texto = "Trabajador Full Time no puede exceder 15 horas Extras Semanales";
            }
            else
            {
                HoraExtraDAO oHorario = new HoraExtraDAO();
                if (oHorario.InsertarHoraExtra(Ho) == true)
                {
                    texto = "Se ingreso Horas Extras Correctamente";
                }
                else texto = "Fallo el Ingreso";
            }
            return texto;
        }
    }
}