using System;
using System.Collections.Generic;
using System.Collections;
using System.Text;

namespace BLLayer
{
    public class Constantes
    {
        public enum CodigoEliminacion
        {
            Eliminado = 0,
            Inactivado = 1,
            Error = 2
        }

        public enum CodigoGrabarReserva
        {
            Error = -1,
            Ok = 0,
            FechaNoValida = 1,
            ReservaPendienteFechaEspecial = 2
        }

        public enum CodigoGrabarFechaEspecial
        {
            Error = -1,
            Ok = 0,
            FechaExiste = 1,
            ExisteReservaFechaEspecial = 2
        }

        public enum CodigoEliminarReserva
        {
            Error = -1,
            Ok = 0
        }

        public enum CodigoEliminarFechaEspecial
        {
            Error = -1,
            Ok = 0,
            FechaEspecialReserva = 1
        }

        public static Hashtable listarMeses()
        {
            Hashtable htaMeses = new Hashtable();

            htaMeses[1] = "Enero";
            htaMeses[2] = "Febrero";
            htaMeses[3] = "Marzo";
            htaMeses[4] = "Abril";
            htaMeses[5] = "Mayo";
            htaMeses[6] = "Junio";
            htaMeses[7] = "Julio";
            htaMeses[8] = "Agosto";
            htaMeses[9] = "Septiembre";
            htaMeses[10] = "Octubre";
            htaMeses[11] = "Noviembre";
            htaMeses[12] = "Diciembre";

            return htaMeses;
        }

        public enum CodigoAprobacion
        {
            aprobado = 0,
            rechazado = 1,
            Error = 2
        }

        public const String OPERACION_INSERT = "I";
        public const String OPERACION_UPDATE = "U";
        public const String OPERACION_DELETE_LOGICAL = "L";
        public const String OPERACION_DELETE_PHYSICAL = "D";
    }
}
