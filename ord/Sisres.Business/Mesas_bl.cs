using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sisres.Model;
using System.Data;
using System.Data.Entity;

namespace Sisres.Business
{
	public class Mesas_bl
	{
		 SisresEntities db = new SisresEntities();
		
		public bool reservarMesa(int pIdMesa, int pIdAnfitrion, string pCliente, int pCantidad)
		{
			Mesas vl_mesa = db.Mesas.Where(p => p.IdMesa == pIdMesa).First();
			vl_mesa.IdAnfitrion = pIdAnfitrion;
			vl_mesa.Cliente = pCliente;
			vl_mesa.Cantidad = pCantidad;
			vl_mesa.Estado = true;
			db.SaveChanges();
			return true;
		}

		public bool liberarMesa(int pIdMesa)
		{
			Mesas vl_mesa = db.Mesas.Where(p => p.IdMesa == pIdMesa).First();
			vl_mesa.IdAnfitrion = int.MinValue;
			vl_mesa.Cliente = "";
			vl_mesa.Cantidad = int.MinValue;
			vl_mesa.Estado = false;
			db.SaveChanges();
			return true;
		}
	}
}
