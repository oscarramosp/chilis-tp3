using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BELayer;
using BLLayer;

namespace cyr
{
    public partial class RegistroReclamos : System.Web.UI.Page
    {
        BLLocal oBLLocal = new BLLocal();
        BLReclamos oBLReclamo = new BLReclamos();
        BLRespuestaReclamo oBLRespuesta = new BLRespuestaReclamo();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ucBuscarCliente.Referrer = "RegistroReclamos.aspx";

                setControles();


                BEReclamo objReclamo = Util.SessionHelper.getReclamoEditar();

                if (objReclamo == null)
                {
                    objReclamo = new BEReclamo();
                    objReclamo.Respuestas = new List<BERespuesta>();
                    Util.SessionHelper.setReclamoEditar(objReclamo);
                }
                else
                {
                    if (objReclamo.Respuestas == null)
                        objReclamo.Respuestas = new List<BERespuesta>();

                    cargarDatosReclamo(objReclamo);
                }



                BECliente oCliente = null;

                oCliente = Util.SessionHelper.getClienteEditar();

                if (objReclamo != null)
                {
                    ucBuscarCliente.cargarDatosCliente(oCliente);
                    Util.SessionHelper.setClienteEditar(null);
                    Util.SessionHelper.setConsultaClienteReferrer(null);
                }
            }

        }

        private void cargarDatosReclamo(BEReclamo objReclamo)
        {
            if (objReclamo.CodigoReclamo == 0)
            {
                txtNumeroReclamo.Text = String.Empty;
                ddlEstado.SelectedValue = String.Empty;
                txtFecCre.Text = String.Format("{0:dd/MM/yyy}", DateTime.Now);
                txtFecCie.Text = String.Empty;
                ddlLocal.SelectedValue = "0";
                txtReclamo.Text = objReclamo.Detalle;
                ddlTipoReclamo.Text = String.Empty;
            }
            else {
                txtNumeroReclamo.Text = objReclamo.CodigoReclamo.ToString();
                ddlEstado.SelectedValue = objReclamo.Estado;
                txtFecCre.Text = String.Format("{0:dd/MM/yyy}", objReclamo.FechaCreacion);
                txtFecCie.Text = String.Format("{0:dd/MM/yyy}", objReclamo.FechaCierre);
                ddlLocal.SelectedValue = objReclamo.CodigoLocal.ToString();
                txtReclamo.Text = objReclamo.Detalle;
                ddlTipoReclamo.Text = objReclamo.TipoReclamo;
            }

            objReclamo.Respuestas = oBLRespuesta.selectRespuestas(objReclamo);

            for (int i = 0; i < objReclamo.Respuestas.Count; i++)
            {
                objReclamo.Respuestas[i].NumeroRespuesta = i + 1;
            }

            dgvRespuestas.DataSource = objReclamo.Respuestas;
            dgvRespuestas.DataBind();
        }

        private void setControles()
        {
            cargarEstados();
            cargarLocales();
            cargarTipoReclamo();
        }

        private void cargarTipoReclamo()
        {
            ddlTipoReclamo.Items.Add(new ListItem("Seleccionar", ""));
            ddlTipoReclamo.Items.Add(new ListItem("Producto", "P"));
            ddlTipoReclamo.Items.Add(new ListItem("Servicio", "S"));
        }


        private void cargarLocales()
        {
            BELocal oLocal = new BELocal();
            oLocal.CodigoLocal = 0;
            oLocal.Nombre = "Seleccionar";

            List<BELocal> oListaLocales = oBLLocal.selectLocales(oLocal);            

            oListaLocales.Insert(0, oLocal);

            ddlLocal.DataSource = oListaLocales;
            ddlLocal.DataTextField = "Nombre";
            ddlLocal.DataValueField = "CodigoLocal";
            ddlLocal.DataBind();

        }

        private void cargarEstados()
        {
            ddlEstado.Items.Add(new ListItem("Seleccionar", ""));
            ddlEstado.Items.Add(new ListItem("Pendiente", "P"));
            ddlEstado.Items.Add(new ListItem("Atendido", "A"));
        }

        protected void btnAgregarRespuesta_Click(object sender, EventArgs e)
        {
            BEReclamo oReclamo = Util.SessionHelper.getReclamoEditar();

            BERespuesta oRespuesta = new BERespuesta();

            oRespuesta.NumeroRespuesta = getNumeroRespuesta(oReclamo.Respuestas);

            oReclamo.Respuestas.Add(oRespuesta);

            dgvRespuestas.DataSource = null;
            dgvRespuestas.DataSource = oReclamo.Respuestas;

            dgvRespuestas.DataBind();

            upRespuestas.Update();
        }

        private int getNumeroRespuesta(List<BERespuesta> oListaRespuestas)
        {
            if (oListaRespuestas == null)
                return 1;
            else
                return oListaRespuestas.Count + 1;
        }

        protected void btnGrabarReclamo_Click(object sender, EventArgs e)
        {
            BEReclamo objReclamo = Util.SessionHelper.getReclamoEditar();

            objReclamo.Estado = ddlEstado.SelectedValue;
            objReclamo.FechaCreacion = DateTime.Parse(txtFecCre.Text.Trim());
            if (txtFecCie.Text == String.Empty)
                objReclamo.FechaCierre = null;
            else
                objReclamo.FechaCierre = DateTime.Parse(txtFecCie.Text);
            objReclamo.CodigoLocal = Convert.ToInt32(ddlLocal.SelectedValue);
            objReclamo.TipoReclamo = ddlTipoReclamo.SelectedValue;

            if (txtReclamo.Text.Trim().Length > 2000)
                objReclamo.Detalle = txtReclamo.Text.Trim().Substring(0, 2000);
            else
                objReclamo.Detalle = txtReclamo.Text.Trim();

            objReclamo.Cliente = new BECliente();
            objReclamo.Cliente.CodigoCliente = ucBuscarCliente.CodigoCliente;

            List<BERespuesta> lstRespuestas = new List<BERespuesta>();

            foreach (GridViewRow gvRow in dgvRespuestas.Rows)
            {
                TextBox txtRespuesta = (TextBox)gvRow.FindControl("txtRespuesta");
                TextBox txtFecRes = (TextBox)gvRow.FindControl("txtFecRes");

                BERespuesta oRespuesta = new BERespuesta();
                oRespuesta.Respuesta = txtRespuesta.Text.Trim();
                oRespuesta.FechaRespuesta = DateTime.Parse(txtFecRes.Text);

                lstRespuestas.Add(oRespuesta);
            }

            objReclamo.Respuestas = lstRespuestas;
            objReclamo = oBLReclamo.grabarReclamo(objReclamo);

            if (objReclamo == null)
            {
                //error it is
                lblMensaje.Text = "Ocurrió un error al registrar el reclamo.";
            }
            else
            {
                dgvRespuestas.DataSource = null;

                for (int i = 0; i < lstRespuestas.Count; i++)
                {
                    objReclamo.Respuestas[i].NumeroRespuesta = i + 1;
                }

                txtNumeroReclamo.Text = objReclamo.CodigoReclamo.ToString();

                dgvRespuestas.DataSource = lstRespuestas;
                dgvRespuestas.DataBind();

                lblMensaje.Text = "Reclamo actualizado correctamente.";
                Util.SessionHelper.setReclamoEditar(objReclamo);
            }

        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Util.SessionHelper.setReclamoEditar(null);
            Util.SessionHelper.setClienteEditar(null);
            Response.Redirect("BusquedaReclamos.aspx");
        }

        protected void dgvRespuestas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdEliminarRespuesta")
            {
                int rowNumber = Convert.ToInt32(e.CommandArgument);

                BEReclamo oReclamo = Util.SessionHelper.getReclamoEditar();

                oReclamo.Respuestas.RemoveAt(rowNumber);
                Util.SessionHelper.setReclamoEditar(oReclamo);

                dgvRespuestas.DataSource = oReclamo.Respuestas;
                dgvRespuestas.DataBind();

                upRespuestas.Update();
            }
        }

        protected void dgvRespuestas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BERespuesta oRespuesta = (BERespuesta)e.Row.DataItem;
                LinkButton lbtElimRespuesta = (LinkButton)e.Row.FindControl("lbtElimRespuesta");
                lbtElimRespuesta.OnClientClick = String.Format("return confirmarEliminar('{0}','{1}');", oRespuesta.NumeroRespuesta, lbtElimRespuesta.ClientID);
            }
        }

    }
}
