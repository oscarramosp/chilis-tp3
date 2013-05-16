using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BELayer;
using BLLayer;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace cyr.UC
{
    public partial class ucBuscarCliente : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarTiposDocumento();
            }
        }

        private void cargarTiposDocumento()
        {
            try
            {
                BLTiposDocumento oBLTiposDocumento = new BLTiposDocumento();
                List<BETipoDocumento> oListaTipoDoc = oBLTiposDocumento.selectTiposDocumento(new BETipoDocumento());
                BETipoDocumento oTipoDocTodos = new BETipoDocumento();
                oTipoDocTodos.CodigoTipoDocumento = 0;
                oTipoDocTodos.Acronimo = "Seleccionar";
                oListaTipoDoc.Insert(0, oTipoDocTodos);
                ddlTipoDoc.DataSource = oListaTipoDoc;
                ddlTipoDoc.DataValueField = "CodigoTipoDocumento";
                ddlTipoDoc.DataTextField = "Acronimo";
                ddlTipoDoc.DataBind();
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }
        }

        public void cargarDatosCliente(BECliente oCliente)
        {
            if (oCliente != null)
            {
                hdnCodigoCliente.Value = oCliente.CodigoCliente.ToString();
                ddlTipoDoc.SelectedValue = oCliente.TipoDocumento.CodigoTipoDocumento.ToString();
                txtNroDoc.Text = oCliente.NumeroDocumento;
                txtTelefono.Text = oCliente.TelefonoPrincipal;
                txtNombre.Text = oCliente.TipoCliente.Equals("N") ? oCliente.Nombres + " " + oCliente.ApellidoPaterno + " " + oCliente.ApellidoMaterno: oCliente.RazonSocial;
            }
        }

        protected void btnBuscarCliente_Click(object sender, EventArgs e)
        {
            // Incluir a buscar clientes. OH GOD WHY
            Util.SessionHelper.setConsultaClienteReferrer(this.Referrer);
            Response.Redirect("BusquedaClientes.aspx?m=consulta&ref=" + this.Referrer);
        }

        public void limpiarDatos()
        {
            txtNombre.Text = "";
            txtNroDoc.Text = "";
            ddlTipoDoc.SelectedIndex = 0;
            hdnCodigoCliente.Value = "";
            txtTelefono.Text = "";
        }

        public bool HabilitarBusqueda 
        {
            set { btnBuscarCliente.Enabled = value; }
        }

        public string Referrer 
        {
            get { return ViewState["referrer"] != null ? ViewState["referrer"].ToString() : null; }
            set { ViewState["referrer"] = value; }
        }

        public string CodigoClienteClientID
        {
            get { return hdnCodigoCliente.ClientID; }
        }

        public int CodigoCliente 
        {
            get { return string.IsNullOrEmpty(hdnCodigoCliente.Value) ? 0 : Convert.ToInt32(hdnCodigoCliente.Value); }
        }
    }
}