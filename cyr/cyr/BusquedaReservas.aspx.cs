using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using BLLayer;
using BELayer;
using System.Globalization;

namespace cyr
{
    public partial class BusquedaReservas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(BusquedaReservas), this.Page);

            if (!IsPostBack)
            {
                String fecha = DateTime.Now.ToString("dd/MM/yyyy");
                txtFechaBusqueda.Text = fecha;
            }
        }

        protected void btnNuevaReserva_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistroReserva.aspx");
        }

        #region AjaxMethods

        [AjaxMethod()]
        public List<BEMesa> obtenerMesas()
        {
            BEMesa oMesa = new BEMesa();
            oMesa.CodigoLocal = 1; // TODO: get user local code.
            BLReservas oBLReservas = new BLReservas();
            List<BEMesa> oListaMesas = oBLReservas.selectMesas(oMesa);

            return oListaMesas;
        }

        [AjaxMethod()]
        public List<BEReserva> obtenerReservas(string fechaReserva, string codigoMesa)
        {
            BEReserva oReserva = new BEReserva();
            oReserva.FechaReserva = DateTime.ParseExact(fechaReserva, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            oReserva.Mesa = new BEMesa();
            oReserva.Mesa.CodigoMesa = Convert.ToInt32(codigoMesa);
            BLReservas oBLReservas = new BLReservas();
            List<BEReserva> oListaReservas = oBLReservas.selectReserva(oReserva);
            return oListaReservas;
        }

        #endregion
    }
}
