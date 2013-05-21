using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sisres.Application.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
		  ViewBag.Message = "Sistema de administración de cadena de restaurantes.";

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
		  ViewBag.Message = "Su página de contacto.";

            return View();
        }
    }
}
