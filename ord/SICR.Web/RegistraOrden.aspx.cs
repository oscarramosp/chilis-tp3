using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICR.Persistencia;
using SICR.LogicaNegocio;

namespace SICR.Web
{
    public partial class RegistraOrden : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptEspecialidad.DataSource = RegistroOrden.ObtenerEspcialidades();
                rptEspecialidad.DataBind();

                ddlMesa.DataSource = RegistroOrden.ObtenerMesasAsignadas();
                ddlMesa.DataTextField = "MesNombre";
                ddlMesa.DataValueField = "MesCodigo";
                ddlMesa.DataBind();

                ddlMesa.Items.Insert(0,new ListItem("-Selecione-",""));

            }
        }
    }
}