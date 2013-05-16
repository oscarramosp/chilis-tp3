using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLLayer;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace cyr
{
    public partial class BusquedaReclamos : System.Web.UI.Page
    {
        BLClientes oBLClientes = new BLClientes();
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {

        }
    }
}
