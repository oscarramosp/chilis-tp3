using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Sisres.Model;
using Sisres.Application.Models;
using Sisres.Entities;
using Util;
using Sisres.Business;

namespace Sisres.Application.Controllers
{
    public class SisresController : Controller
    {
        SisresEntities db = new SisresEntities();
        //DefaultControllerFactoryDefaultConnection
        //
        // GET: /Sisres/

        public ActionResult Index()
        {
            return View();
        }

	  #region Mesas
	  public ActionResult ActualizaMesa()
	  {
		  List<Mesas> vl_listaMesas = db.Mesas.ToList();
		  List<DistribucionMesas> vl_listaDistribucion = new List<DistribucionMesas>();
		  DistribucionMesas vl_distribucion;
		  int cont = 0;
		  for (int i = 0; i < vl_listaMesas.Count / (int)SisresCons.MaxColMesas; i++)
		  {
			  vl_distribucion = new DistribucionMesas();
			  vl_distribucion.Col1 = vl_listaMesas[cont++];
			  vl_distribucion.Col2 = vl_listaMesas[cont++];
			  vl_distribucion.Col3 = vl_listaMesas[cont++];
			  vl_distribucion.Col4 = vl_listaMesas[cont++];
			  vl_listaDistribucion.Add(vl_distribucion);
		  }

		  var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaDistribucion,
			  //defaultSort: "DataId",
			ajaxUpdateCallback: "GridUpdate",
			ajaxUpdateContainerId: "grid",
			rowsPerPage: 10);

		  var model = new PartialModels() { Text = webgridd.GetHtml().ToHtmlString() };
		  ViewBag.listaMesas = vl_listaDistribucion;
		  return View("_listaMesasPartial", model);
	  }

	  public ActionResult Mesa()
	  {
		  List<Mesas> vl_listaMesas = db.Mesas.ToList();
		  List<DistribucionMesas> vl_listaDistribucion = new List<DistribucionMesas>();
		  DistribucionMesas vl_distribucion;
		  int cont = 0;
		  for (int i = 0; i < vl_listaMesas.Count / (int)SisresCons.MaxColMesas; i++)
		  {
			  vl_distribucion = new DistribucionMesas();
			  vl_distribucion.Col1 = vl_listaMesas[cont++];
			  vl_distribucion.Col2 = vl_listaMesas[cont++];
			  vl_distribucion.Col3 = vl_listaMesas[cont++];
			  vl_distribucion.Col4 = vl_listaMesas[cont++];
			  vl_listaDistribucion.Add(vl_distribucion);
		  }
		  ViewBag.listaMesas = vl_listaDistribucion;

		  var vl_listaAnfitriones = db.Anfitriones.Select(p => new { IdAnfitrion = p.IdAnfitrion, NombresApellidos = p.Nombres + " " + p.Apellidos });
		  ViewBag.listaAnfitriones = new SelectList(vl_listaAnfitriones, "IdAnfitrion", "NombresApellidos");
		  return View();
	  }

	  public string GetDataReserva(int pIdMesa)
	  {
		  string data = string.Empty;
		  Mesas vl_mesa = db.Mesas.Where(p => p.IdMesa == pIdMesa).First();
		  data = vl_mesa.IdAnfitrion + "|" + vl_mesa.Cliente + "|" + vl_mesa.Cantidad.ToString();
		  //Session["IdMesa"] = pIdMesa;
		  return data;
	  }

	  public bool Reservar(int pIdMesa, int pIdAnfitrion, string pCliente, int pCantidad)
	  {
		  Business.Mesas_bl vl_Mesas= new Business.Mesas_bl();
		  return vl_Mesas.reservarMesa(pIdMesa, pIdAnfitrion, pCliente, pCantidad);
	  }

	  public bool Liberar(int pIdMesa)
	  {
		  Business.Mesas_bl vl_Mesas = new Business.Mesas_bl();
		  return vl_Mesas.liberarMesa(pIdMesa);
	  }
	  #endregion

	  #region Insumos
	  public ActionResult Insumos()
	  {
		  ViewBag.listaInsumos = db.Insumos.Where(p => p.Estado == true).ToList();
		  ViewBag.listaSolicitudes = db.Solicitudes.Where(p => p.Estado == false &&
			  p.Insumos.Estado == true).ToList();
		  return View();
	  }

	  public ActionResult SolicitarInsumo(string plistaInsumos)
	  {
		  string[] vl_arrayInsumos = plistaInsumos.Split('|');
		  List<Solicitudes> vl_listaSolicitudes = new List<Solicitudes>();
		  for (int i = 0; i < vl_arrayInsumos.Length; i++)
		  {
			  int vl_id = Convert.ToInt16(vl_arrayInsumos[i].Split(':')[0]);
			  int vl_cantidad = Convert.ToInt16(vl_arrayInsumos[i].Split(':')[1]);
			  Solicitudes vl_solicitud;

			  var insumo = db.Insumos.Where(p => p.IdInsumo == vl_id).First();
			  vl_solicitud = new Solicitudes();
			  vl_solicitud.Insumos = insumo;
			  vl_solicitud.Fecha = DateTime.Now;
			  vl_solicitud.IdEstadoSolicitud = (int)SisresEnums.EstadoSolicitud.Pendiente;
			  vl_solicitud.IdInsumo = vl_id;
			  vl_solicitud.CantidadSolicitada = vl_cantidad;
			  //vl_solicitud.IdPrioridad = insumo.IdPrioridad;
			  vl_solicitud.CantidadRecibida = 0;
			  vl_solicitud.Estado = false;
			  db.Solicitudes.Add(vl_solicitud);
		  }
		  db.SaveChanges();

		  return ActualizarSolicitud();
	  }

	  public ActionResult ActualizarInsumo()
	  {
		  List<Insumos> vl_listaInsumos = db.Insumos.Where(p => p.Estado == true).ToList();
		  var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaInsumos,
			  //defaultSort: "DataId",
			ajaxUpdateCallback: "GridUpdate",
			ajaxUpdateContainerId: "grid",
			rowsPerPage: 10);

		  var model = new PartialModels { Text = webgridd.GetHtml().ToHtmlString() };

		  ViewBag.listaInsumos = vl_listaInsumos;
		  return View("_listaInsumosPartial", model);
	  }

	  public ActionResult EliminarInsumo(int pIdInsumo)
	  {
		  Business.Insumos_bl vl_Insumos = new Business.Insumos_bl();
		  bool action= vl_Insumos.eliminarInsumo(pIdInsumo);
		  return ActualizarSolicitud();
	  }

	  public ActionResult ActualizarSolicitud()
	  {
		  List<Solicitudes> vl_listaSolicitudes = db.Solicitudes.Where(p => p.Estado == false &&
			  p.Insumos.Estado == true).ToList();
          foreach (Solicitudes item in vl_listaSolicitudes)
          {
              EstadosSolicitud vl_es = db.EstadosSolicitud.Where(p => p.IdEstadoSolicitud == item.IdEstadoSolicitud).First();
              item.EstadosSolicitud = vl_es;
          }
		  var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaSolicitudes,
			  //defaultSort: "DataId",
			ajaxUpdateCallback: "GridUpdate",
			ajaxUpdateContainerId: "grid",
			rowsPerPage: 10);

		  var model = new PartialModels { Text = webgridd.GetHtml().ToHtmlString() };

		  ViewBag.listaSolicitudes = vl_listaSolicitudes;
		  return View("_listaSolicitudesPartial", model);
	  }

	  public ActionResult AtenderSolicitud(string pListaInsumos)
	  {
		  string[] vl_listaInsumos = pListaInsumos.Split('|');
		  for (int i = 0; i < vl_listaInsumos.Length; i++)
		  {
			  int IdSolicitud = Convert.ToInt16(vl_listaInsumos[i].Split(':')[0]);
			  int cantidad = Convert.ToInt16(vl_listaInsumos[i].Split(':')[1]);
			  var solicitud = db.Solicitudes.Where(p => p.IdSolicitud == IdSolicitud).First();
			  solicitud.CantidadRecibida = cantidad;
			  solicitud.Estado = true;
			  solicitud.IdEstadoSolicitud = (int)SisresEnums.EstadoSolicitud.Aprobado;

			  int idInsumo = solicitud.IdInsumo;
			  var insumo = db.Insumos.Where(p => p.IdInsumo == idInsumo).First();
			  insumo.StockActual = insumo.StockActual + cantidad;
			  db.SaveChanges();
		  }
		  return ActualizarSolicitud();
	  }

	  public ActionResult InsumoMaestro()
	  {
		  ViewBag.listaUnidadMedida = new SelectList(db.tb_UnidadMedida, "Codigo", "desMed");
		  ViewBag.listaPrioridades = new SelectList(db.Prioridades, "IdPrioridad", "NombrePrioridad");
		  return View();
	  }

	  public bool GuardarInsumo(string pNombre, int pUM, int pStockNormal, int pRequerido, int pStockActual, int pStockMinimo, int pPrioridad)
	  {
		  Business.Insumos_bl vl_Insumos = new Business.Insumos_bl();
		  return vl_Insumos.guardarInsumo(pNombre, pUM, pStockNormal, pRequerido, pStockActual, pStockMinimo, pPrioridad);
	  }
	  #endregion

        #region Receta
        public ActionResult Receta()
        {
            List<Recetas> vl_listaRecetas = db.Recetas.ToList();
            ViewBag.listaRecetas = vl_listaRecetas;
            ViewBag.listaInsumosReceta = new List<InsumosPorReceta>();
            ViewBag.receta = new List<Recetas>();
            return View();
        }

	  public bool AsignarCartaVarios(string pListaRecetas)
	  {
		  string[] vl_lista = pListaRecetas.Split('|');
		  for (int i = 0; i < vl_lista.Length; i++)
		  {
			  Carta vl_carta = new Carta();
			  vl_carta.Fecha = DateTime.Now;
			  vl_carta.IdReceta = Convert.ToInt16(vl_lista[i].Split(':')[0]);
			  vl_carta.IsOferta = false;
			  vl_carta.PrecioOferta = Convert.ToDecimal(vl_lista[i].Split(':')[2]);
			  vl_carta.Estado = false;
			  db.Carta.Add(vl_carta);
			  db.SaveChanges();
		  }
		  return true;
	  }

	  public ActionResult AsignarCarta(int pReceta, string pPrecio, string pActivo)
        {
            Carta vl_carta = new Carta();            
            vl_carta.Fecha = DateTime.Now;
            vl_carta.IdReceta = pReceta;
            vl_carta.IsOferta = false;
            vl_carta.PrecioOferta = Convert.ToDecimal(pPrecio);
            if(pActivo=="checked") vl_carta.Estado=true; else vl_carta.Estado=false;
            db.Carta.Add(vl_carta);
            db.SaveChanges();
            return ActualizarCarta();
        }

        public ActionResult DetalleReceta(int pIdReceta)
        {
            List<InsumosPorReceta> vl_listaInsumos = db.InsumosPorReceta.Where(p => p.IdReceta == pIdReceta).ToList();
            var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaInsumos,
                //defaultSort: "DataId",
                ajaxUpdateCallback: "GridUpdate",
                ajaxUpdateContainerId: "grid",
                rowsPerPage: 10);

            var model = new PartialModels() { Text = webgridd.GetHtml().ToHtmlString() };
            ViewBag.listaInsumosReceta = vl_listaInsumos;
            return View("_listaInsumosRecetaPartial", model);
        }

        public ActionResult VerReceta(int pIdReceta)
        {
            List<Recetas> vl_listaRecetas= db.Recetas.Where(p => p.IdReceta == pIdReceta).ToList();
            var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaRecetas,
                //defaultSort: "DataId",
                ajaxUpdateCallback: "GridUpdate",
                ajaxUpdateContainerId: "grid",
                rowsPerPage: 10);

            var model = new PartialModels() { Text = webgridd.GetHtml().ToHtmlString() };
            ViewBag.receta = vl_listaRecetas;
            return View("_modoPreparacionPartial", model);
        }
        #endregion

        #region Carta
        public ActionResult Carta()
        {
            var listaTiposReceta = db.TiposReceta;
            int vl_selTipoReceta = listaTiposReceta.ToList().First().IdTipoReceta;
            ViewBag.listaTiposReceta = new SelectList(listaTiposReceta, "IdTipoReceta", "NombreTipoReceta");

            ViewBag.listaReceta = new SelectList(db.Recetas.Where(p=>p.IdTipoReceta==vl_selTipoReceta), "IdReceta", "NombreReceta");
            List<Carta> vl_listaCarta = db.Carta.ToList();
            ViewBag.listaCarta = vl_listaCarta;
            return View();
        }

        public bool GuardarSesionCarta(int pCarta)
        {
            Session["IdCarta"] = pCarta;
            return true;
        }
        public ActionResult EditarCarta(int pCarta,bool pEstado,string pPrecio)
        {
            if (pCarta == 0)
            {
                pCarta = (int)Session["IdCarta"];
            }
            var vl_carta = db.Carta.Where(p => p.IdCarta == pCarta).First();
            vl_carta.PrecioOferta = Convert.ToDecimal(pPrecio);
            vl_carta.Estado = pEstado;
            db.SaveChanges();
            return ActualizarCarta();
        }

        public ActionResult EliminarCarta(int pCarta)
        {
            var vl_carta = db.Carta.Where(p => p.IdCarta == pCarta).First();
            db.Carta.Remove(vl_carta);
            db.SaveChanges();
            return ActualizarCarta();
        }

        public ActionResult ActualizarCarta()
        {
            List<Carta> vl_listaCarta= db.Carta.ToList();
            foreach (Carta item in vl_listaCarta)
            {
                item.Recetas = db.Recetas.Where(p => p.IdReceta == item.IdReceta).First();
            }
            var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaCarta,
                //defaultSort: "DataId",
                ajaxUpdateCallback: "GridUpdate",
                ajaxUpdateContainerId: "grid",
                rowsPerPage: 10);

            var model = new PartialModels() { Text = webgridd.GetHtml().ToHtmlString() };
            ViewBag.listaCarta = vl_listaCarta;
            return View("_listaCartaPartial", model);
        }

        public ActionResult ListarRecetaPorTipo(int pTipoReceta)
        {
            ViewBag.listaReceta = new SelectList(db.Recetas.Where(p => p.IdTipoReceta == pTipoReceta), "IdReceta", "NombreReceta");
            return View("_recetaPartial");
        }
        #endregion Incidencia

	  #region Orden
	  public ActionResult Orden()
        {
            var vl_listaMesas = db.Mesas.Where(p => p.Estado == true || p.EstadoOrden==true);
          int vl_selMesa=vl_listaMesas.ToList().FirstOrDefault().IdMesa;
            ViewBag.listaMesas = new SelectList(vl_listaMesas, "IdMesa", "NombreMesa");

            var vl_listaAnfitriones = db.Anfitriones.Select(p => new { IdAnfitrion = p.IdAnfitrion, NombresApellidos = p.Nombres + " " + p.Apellidos });
            ViewBag.listaAnfitrion = new SelectList(vl_listaAnfitriones, "IdAnfitrion", "NombresApellidos");

            //List<Carta> vl_listaCarta = db.Carta.Where(p => p.Estado == true && p.Fecha.Day == DateTime.Now.Day && p.Fecha.Month==DateTime.Now.Month).ToList();
            var vl_listaCarta =
      from c in db.Carta.Where(p => p.Estado == true && p.Fecha.Day == DateTime.Now.Day && p.Fecha.Month == DateTime.Now.Month)
      where !(from o in db.Ordenes.Where(p => p.IdMesa == vl_selMesa && p.Estado == true)
              select o.IdReceta)
             .Contains(c.IdReceta)
      select c;
            ViewBag.listaCarta = vl_listaCarta;

            List<Ordenes> vl_listaOrdenes = db.Ordenes.Where(p => p.IdMesa == vl_selMesa && p.Estado == true).ToList();
            ViewBag.listaOrdenes = vl_listaOrdenes;
            return View();
        }

        public ActionResult  ActualizarOrdenes(int pMesa)
        {
            List<Ordenes> vl_listaOrdenes = db.Ordenes.Where(p => p.IdMesa == pMesa && p.Estado == true).ToList();
            foreach (Ordenes item in vl_listaOrdenes)
            {
                item.Recetas = db.Recetas.Where(p => p.IdReceta == item.IdReceta).First();
            }
             var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaOrdenes,
                //defaultSort: "DataId",
                ajaxUpdateCallback: "GridUpdate",
                ajaxUpdateContainerId: "grid",
                rowsPerPage: 10);

            var model = new PartialModels() { Text = webgridd.GetHtml().ToHtmlString() };
            ViewBag.listaOrdenes = vl_listaOrdenes;
            return View("_listaOrdenPartial", model);
        }

        public int ActualizarAnfitrion(int pMesa)
        {
            var vl_anfitrion = db.Ordenes.Where(p => p.IdMesa == pMesa).FirstOrDefault();
            if (vl_anfitrion != null) return vl_anfitrion.IdAnfitrion;
            return db.Anfitriones.First().IdAnfitrion;
        }

        public ActionResult ActualizarCartaOrden(int pMesa)
        {
            List<Carta> vl_listaCarta = (from c in db.Carta.Where(p => p.Estado == true && p.Fecha.Day == DateTime.Now.Day && p.Fecha.Month == DateTime.Now.Month)
                                 where !(from o in db.Ordenes.Where(p => p.IdMesa == pMesa && p.Estado == true)
                                         select o.IdReceta)
                                        .Contains(c.IdReceta)
                                 select c).ToList();

            var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaCarta,
                //defaultSort: "DataId",
               ajaxUpdateCallback: "GridUpdate",
               ajaxUpdateContainerId: "grid",
               rowsPerPage: 10);

            var model = new PartialModels() { Text = webgridd.GetHtml().ToHtmlString() };
            ViewBag.listaCarta = vl_listaCarta;
            return View("_listaCartaOrdenPartial", model);
        }
        public ActionResult Ordenar(int pMesa,int pAnfitrion, string pListaRecetas)
        {
            List<Ordenes> vl_listaOrdenes = db.Ordenes.ToList();
            int vl_max = 1;
            if (vl_listaOrdenes.Count > 0)
            {
                var vl_ordenActual = vl_listaOrdenes.Where(p => p.IdMesa == pMesa && p.Estado == true).FirstOrDefault();

                if (vl_ordenActual != null)
                {
                    vl_max = vl_ordenActual.NumeroPedido;
                }
                else
                {
                    vl_max = vl_listaOrdenes.Max(p => p.NumeroPedido);
                    vl_max++;
                }
            }
            string[] vl_listaRecetas = pListaRecetas.Split('|');
            Ordenes vl_orden;
            for (int i = 0; i < vl_listaRecetas.Length; i++)
            {
                vl_orden = new Ordenes();
                vl_orden.NumeroPedido = vl_max;
                vl_orden.IdMesa = pMesa;
                vl_orden.IdAnfitrion = pAnfitrion;
                vl_orden.IdReceta = Convert.ToInt16(vl_listaRecetas[i].Split(':')[0]);
                vl_orden.Cantidad = Convert.ToInt16(vl_listaRecetas[i].Split(':')[1]);
                vl_orden.Estado = true;
                db.Ordenes.Add(vl_orden);
            }
            db.SaveChanges();
            return ActualizarOrdenes(pMesa);
        }

        public ActionResult EliminarOrden(int pMesa, int pOrden)
        {
            Ordenes vl_orden = db.Ordenes.Where(p => p.IdOrden == pOrden).First();
            vl_orden.Estado = false;
            db.SaveChanges();
            return ActualizarOrdenes(pMesa);
        }
	  #endregion

	  #region Incidencia
	  public ActionResult Incidencia()
        {
            var vl_listaTiposIncidencia = db.TiposIncidencia;
            int vl_selTipoIncidencia = vl_listaTiposIncidencia.First().IdTipoIncidencia;
            ViewBag.listaTiposIncidencia = new SelectList(vl_listaTiposIncidencia, "IdTipoIncidencia", "NombreTipoIncidencia");

            List<Incidencias> vl_listaIncidencias = db.Incidencias.ToList();
            ViewBag.listaIncidencias = vl_listaIncidencias;
            return View();
        }

      public int RegistrarIncidencia(int pNumeroPedido, int pTipoIncidencia, string pDetalle)
      {
          var vl_listaOrdenes = db.Ordenes.Where(p => p.NumeroPedido == pNumeroPedido).FirstOrDefault();
          if (vl_listaOrdenes == null) return 1;
          //if (db.Incidencias.Where(p => p.NumeroPedido == pNumeroPedido).FirstOrDefault() != null) return 2;
          Incidencias vl_incidencia = new Incidencias();
          vl_incidencia.NumeroPedido = pNumeroPedido;
          vl_incidencia.IdTipoIncidencia = pTipoIncidencia;
          vl_incidencia.IdEstadoIncidencia = (int)SisresEnums.EstadoSolicitudIncidencia.Espera;
          vl_incidencia.Detalle = pDetalle;
          vl_incidencia.Estado = true;
          db.Incidencias.Add(vl_incidencia);
          db.SaveChanges();
          return 0;
      }

      public ActionResult GuardarIncidencia(int pNumeroPedido, int pTipoIncidencia, string pDetalle)
      {
          var vl_incidencia = db.Incidencias.Where(p => p.NumeroPedido == pNumeroPedido).First();
          vl_incidencia.IdTipoIncidencia = pTipoIncidencia;
          vl_incidencia.Detalle = pDetalle;
          db.SaveChanges();
          return ActualizarIncidencias();
      }

      public ActionResult EliminarIncidencia(int pIncidencia)
      {
          Incidencias vl_incidencia = db.Incidencias.Where(p => p.IdIncidencia == pIncidencia).First();
          db.Incidencias.Remove(vl_incidencia);
          db.SaveChanges();
          return ActualizarIncidencias();
      }

      public string EditarIncidencia(int pIncidencia)
      {
          string data;
          Incidencias vl_incidencia = db.Incidencias.Where(p => p.IdIncidencia == pIncidencia).First();
          data = vl_incidencia.NumeroPedido.ToString() + "|" + vl_incidencia.IdTipoIncidencia.ToString() + "|" + vl_incidencia.Detalle;
          return data;
      }
      public ActionResult ActualizarIncidencias()
      {
          List<Incidencias> vl_listaIncidencias = db.Incidencias.ToList();
          var webgridd = new System.Web.Helpers.WebGrid(source: vl_listaIncidencias,
              //defaultSort: "DataId",
               ajaxUpdateCallback: "GridUpdate",
               ajaxUpdateContainerId: "grid",
               rowsPerPage: 10);

          var model = new PartialModels() { Text = webgridd.GetHtml().ToHtmlString() };
          ViewBag.listaIncidencias = vl_listaIncidencias;
          return View("_listaIncidenciasPartial", model);
      }
	  #endregion Incidencia

	  
    }
}
