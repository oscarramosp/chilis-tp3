using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sisres.Model;

namespace Sisres.Business
{
    public class Insumos_bl
    {
	    SisresEntities db = new SisresEntities();

	    public bool guardarInsumo(string pNombre, int pUM, int pStockNormal, int pRequerido, int pStockActual, int pStockMinimo, int pPrioridad)
	    {
		    Insumos vl_insumo = new Insumos();
		    vl_insumo.NombreInsumo = pNombre;
		    vl_insumo.CODIGO = pUM;
		    vl_insumo.StockNormal = pStockNormal;
		    vl_insumo.CantidadRequerida = pRequerido;
		    vl_insumo.StockActual = pStockActual;
		    vl_insumo.StockMinimo = pStockMinimo;
		    vl_insumo.IdPrioridad = pPrioridad;
		    vl_insumo.CantidadSolicitada = 0;
		    vl_insumo.Estado = true;
		    db.Insumos.Add(vl_insumo);
		    db.SaveChanges();
		    return true;
	    }

	    public bool eliminarInsumo(int pIdInsumo)
	    {
		    var insumo = db.Insumos.Where(p => p.IdInsumo == pIdInsumo).FirstOrDefault();
		    insumo.Estado = false;
		    db.SaveChanges();
		    return true;		    
	    }
    }
}
