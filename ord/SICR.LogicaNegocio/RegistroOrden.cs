using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SICR.Persistencia;
using SubSonic.Schema;

namespace SICR.LogicaNegocio
{
    public class RegistroOrden
    {
        public static MAsignacion BuscarAsignacion(int codMesa)
        {

            ORDENDB db = new ORDENDB();
            StoredProcedure usp = db.usp_BuscarMAsignacion(codMesa);
            int AsiCodigo = usp.ExecuteScalar<int>();

            MAsignacion asig = new MAsignacion(x => x.AsiCodigo == AsiCodigo);

            return asig;


        }

        public static MEspecialidad[] ObtenerEspcialidades()
        {
            return (from es in MEspecialidad.All() select es).ToArray();
        }

        public static MMesa[] ObtenerMesasAsignadas()
        {
            return (from m in MMesa.All() where m.MesAsigna == "A" select m).ToArray();
        }
        public static MPlatoBebida[] ObtenerPlatoBebida(int EspCodigo)
        {
            return (from es in MPlatoBebida.All() where es.EspCodigo == EspCodigo select es).ToArray();
        }

        public static void GuardarPedido(MPedido[] lista)
        {
            if (lista.Length > 0)
            {
                MOrden o = new MOrden();
                o.AsiCodigo = lista[0].OrdCodigo.Value;
                o.OrdFecha = DateTime.Now;
                o.Save();

                foreach (MPedido p in lista)
                {
                    p.OrdCodigo = o.OrdCodigo;
                    p.PedEstado = "A";
                    p.Save();
                }
            }

        }

        public static MSilla[] ObtenerSillas(int MesCodigo)
        {
            return (from s in MSilla.All() where s.MesCodigo == MesCodigo select s).ToArray();
        }
    }
}
