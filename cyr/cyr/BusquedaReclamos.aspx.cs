using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLLayer;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System.Globalization;
using Microsoft.VisualBasic;

namespace cyr
{
    public partial class BusquedaReclamos : System.Web.UI.Page
    {
        BLReclamos oBLReclamos = new BLReclamos();
        BLTiposDocumento oBLTiposDocumento = new BLTiposDocumento();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setControles();
            }
        }

        private void setControles()
        {
            cargarTiposDocumento();
            cargarEstados();
            precargarFechas();
        }

        private void precargarFechas()
        {
            txtFechaInicio.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd/MM/yyyy");
            txtFechaFin.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month + 1, 1).AddDays(-1).ToString("dd/MM/yyyy");
        }

        private void cargarTiposDocumento()
        {
            try
            {
                List<BETipoDocumento> oListaTipoDoc = oBLTiposDocumento.selectTiposDocumento(new BETipoDocumento());
                BETipoDocumento oTipoDocTodos = new BETipoDocumento();
                oTipoDocTodos.CodigoTipoDocumento = 0;
                oTipoDocTodos.Acronimo = "TODOS";
                oListaTipoDoc.Insert(0, oTipoDocTodos);
                ddlTipoDocumento.DataSource = oListaTipoDoc;
                ddlTipoDocumento.DataValueField = "CodigoTipoDocumento";
                ddlTipoDocumento.DataTextField = "Acronimo";
                ddlTipoDocumento.DataBind();
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }
        }

        private void cargarEstados()
        {
            ddlEstado.Items.Add(new ListItem("--Todos--", ""));
            ddlEstado.Items.Add(new ListItem("Atendido", "A"));
            ddlEstado.Items.Add(new ListItem("Pendiente", "P"));
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            buscarReclamos();
        }

        private void buscarReclamos()
        {
            DateTime fecIni = DateTime.ParseExact(txtFechaInicio.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime fecFin = DateTime.ParseExact(txtFechaFin.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            List<BEReclamo> oListaReclamos = oBLReclamos.selectReclamos(generarObjetoBusqueda(), txtNomRazSoc.Text.Trim(), fecIni, fecFin);
            if (oListaReclamos.Count == 0)
            {
                lblSinResultados.Visible = true;
                lblSinResultados.Text = "No se encontraron reclamos para los parámetros ingresados";
                dgvReclamos.DataSource = null;
                dgvReclamos.DataBind();
            }
            else
            {
                Session["lstBusquedaReclamos"] = oListaReclamos;
                dgvReclamos.DataSource = oListaReclamos;
                dgvReclamos.DataBind();
                lblSinResultados.Visible = false;
                lblSinResultados.Text = String.Empty;
            }
        }

        private BEReclamo generarObjetoBusqueda()
        {
            BEReclamo oReclamo = new BEReclamo();
            BECliente oCliente = new BECliente();
            BETipoDocumento oTipoDocumento = new BETipoDocumento();

            oReclamo.CodigoReclamo = (txtNroRec.Text.Trim() == String.Empty ? 0 : Convert.ToInt32(txtNroRec.Text.Trim()));

            oReclamo.Estado = ddlEstado.SelectedValue;

            oTipoDocumento.CodigoTipoDocumento = Convert.ToInt32(ddlTipoDocumento.SelectedValue);

            oCliente.NumeroDocumento = txtNumDoc.Text;

            oCliente.TipoDocumento = oTipoDocumento;

            oReclamo.Cliente = oCliente;

            return oReclamo;
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistroReclamos.aspx");
        }

        static Predicate<BEReclamo> ById(Int32 codigoReclamo)
        {
            return delegate(BEReclamo oReclamo)
            {
                return oReclamo.CodigoReclamo == codigoReclamo;
            };
        }

        protected void dgvReclamos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BEReclamo oReclamo = (BEReclamo) e.Row.DataItem;
                LinkButton lbtEliminarReclamo = (LinkButton)e.Row.FindControl("lbtElimReclamo");
                lbtEliminarReclamo.OnClientClick = String.Format("return confirmarEliminar('{0}','{1}');", oReclamo.CodigoReclamo, lbtEliminarReclamo.ClientID);
            }
        }

        protected void dgvReclamos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdDetalleReclamo")
            {
                Int32 codigoReclamo = Convert.ToInt32(e.CommandArgument);
                if (!(Session["lstBusquedaReclamos"] == null))
                {
                    List<BEReclamo> lstReclamos = (List<BEReclamo>)Session["lstBusquedaReclamos"];
                    BEReclamo oReclamo = lstReclamos.Find(ById(codigoReclamo));
                    Util.SessionHelper.setReclamoEditar(oReclamo);
                    Util.SessionHelper.setClienteEditar(oReclamo.Cliente);

                    //string referrer = Util.SessionHelper.getConsultaClienteReferrer();

                    //if (!string.IsNullOrEmpty(referrer))
                    //{
                    //    Response.Redirect(referrer);
                    //    return;
                    //}

                    Response.Redirect("RegistroReclamos.aspx");
                }
            }
            else if (e.CommandName == "cmdEliminarReclamo")
            {
                Int32 codigoReclamo = Convert.ToInt32(e.CommandArgument);
                BEReclamo oReclamo = new BEReclamo();
                oReclamo.CodigoReclamo = codigoReclamo;

                int codigoEliminacion = oBLReclamos.eliminarReclamo(oReclamo);
                string mensaje = string.Empty;

                switch (codigoEliminacion)
                {
                    case (int)BLLayer.Constantes.CodigoEliminacion.Eliminado:
                        mensaje = "El reclamo ha sido eliminado correctamente";
                        buscarReclamos();                        
                        break;
                    case (int)BLLayer.Constantes.CodigoEliminacion.Error:
                        mensaje = "Ocurrió un error al eliminar el reclamo";
                        break;
                }

                lblSinResultados.Text = mensaje;
                lblSinResultados.Visible = true;
            }

        }
    }
}
