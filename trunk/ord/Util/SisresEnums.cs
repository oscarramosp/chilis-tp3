using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Util
{
    public class SisresEnums
    {
        public enum Prioridad{Baja=1,Moderada=2,Alta=3};
        public enum EstadoSolicitud {Aprobado=1,Pendiente=2 };
        public enum EstadoSolicitudIncidencia { Aprobada= 1, Rechazada= 2,Espera=3 };
    }

    public class SisresCons
    {
        public const int MaxColMesas = 4;
    }
}
