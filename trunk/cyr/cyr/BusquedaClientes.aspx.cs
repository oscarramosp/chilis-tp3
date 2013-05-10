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
    public partial class BusquedaClientes : System.Web.UI.Page
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

        protected void Td_CheckedChanged(Object sender, EventArgs e)
        {
            if (rbtNatural.Checked)
            {
                habilitarCamposTipoDoc(true);
            }

            if (rbtJuridico.Checked)
            {
                habilitarCamposTipoDoc(false);
            }

            upFiltrosCliente.Update();
        }

        private void habilitarCamposTipoDoc(Boolean blnHabilitar)
        {
            divSexo.Visible = blnHabilitar;
            if (blnHabilitar)
            {
                divCampoNombre.InnerText = "Nombre:";
            }
            else
            {
                divCampoNombre.InnerText = "Razón Social:";
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            buscarClientes();
        }

        private void buscarClientes()
        {
            List<BECliente> oListaClientes = oBLClientes.selectClientes(generarObjetoBusqueda());
            if (oListaClientes.Count == 0)
            {
                lblSinResultados.Visible = true;
                lblSinResultados.Text = "No se encontraron clientes para los parámetros ingresados";
                dgvClientes.DataSource = null;
                dgvClientes.DataBind();
            }
            else
            {
                Session["lstBusquedaClientes"] = oListaClientes;
                dgvClientes.DataSource = oListaClientes;
                dgvClientes.DataBind();
                lblSinResultados.Visible = false;
                lblSinResultados.Text = String.Empty;
            }
        }

        private BECliente generarObjetoBusqueda()
        {
            BECliente oCliente = new BECliente();

            oCliente.TipoCliente = (rbtNatural.Checked ? "N" : "J");
            oCliente.TipoDocumento.CodigoTipoDocumento = Convert.ToInt32(ddlTipoDoc.SelectedValue);
            oCliente.NumeroDocumento = txtNroDoc.Text;
            oCliente.RazonSocial = txtNombre.Text;
            if (oCliente.TipoCliente == "N")
            {
                oCliente.Sexo = (rbtAmbos.Checked ? "" : (rbtMasculino.Checked ? "M" : "F"));
            }
            return oCliente;
        }

        protected void dgvClientes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {   
                Label lblEstado = (Label)e.Row.FindControl("lblEstado");
                Label lblEstadoDes = (Label)e.Row.FindControl("lblEstadoDes");
                lblEstadoDes.Text = (lblEstado.Text.Equals("A") ? "Activo" : "Inactivo");
                String strEstado = lblEstado.Text;
                lblEstado = (Label)e.Row.FindControl("lblTipo");
                lblEstadoDes = (Label)e.Row.FindControl("lblTipoDes");
                lblEstadoDes.Text = (lblEstado.Text.Equals("N") ? "Natural" : "Jurídico");

                LinkButton lbtEliminarCliente = (LinkButton)e.Row.FindControl("lbtElimCliente");
                String strNombreCliente = Server.HtmlDecode(e.Row.Cells[2].Text);
                //lbtEliminarCliente.OnClientClick = "return window.confirm('¿Desea eliminar al cliente " + strNombreCliente + " ?');";
                lbtEliminarCliente.OnClientClick = String.Format("return confirmarEliminar('{0}','{1}');", strNombreCliente, lbtEliminarCliente.ClientID);
                if (strEstado.Equals("I"))
                {
                    lbtEliminarCliente.Visible = false;
                }
            }
        }

        static Predicate<BECliente> ById(Int32 codigoCliente)
        {
            return delegate(BECliente oCliente)
            {
                return oCliente.CodigoCliente == codigoCliente;
            };
        }

        protected void dgvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("cmdDetalleCliente"))
            {
                Int32 codigoCliente = Convert.ToInt32(e.CommandArgument);
                if (!(Session["lstBusquedaClientes"] == null))
                {
                    List<BECliente> lstClientes = (List<BECliente>)Session["lstBusquedaClientes"];
                    BECliente oCliente = lstClientes.Find(ById(codigoCliente));
                    Util.SessionHelper.setClienteEditar(oCliente);
                    Response.Redirect("RegistroClientes.aspx");
                }
            }
            if (e.CommandName.Equals("cmdEliminarCliente"))
            {
                Int32 codigoCliente = Convert.ToInt32(e.CommandArgument);
                BECliente oCliente = new BECliente();
                oCliente.CodigoCliente = codigoCliente;

                int codigoEliminacion = oBLClientes.eliminarCliente(oCliente);
                string mensaje = string.Empty;

                switch (codigoEliminacion)
                {
                    case (int)BLLayer.Constantes.CodigoEliminacion.Eliminado:
                        buscarClientes();
                        mensaje = "El cliente " + Server.HtmlDecode(((GridViewRow)((LinkButton)e.CommandSource).Parent.Parent).Cells[2].Text) + " ha sido eliminado correctamente";
                        break;
                    case (int)BLLayer.Constantes.CodigoEliminacion.Inactivado:
                        mensaje = "El cliente no ha podido ser eliminado por que cuenta con registros en el sistema.<br> Se ha actualizado su estado a inactivo.";
                        buscarClientes();
                        break;
                    case (int)BLLayer.Constantes.CodigoEliminacion.Error:
                        mensaje = "Ocurrió un error al eliminar el cliente";
                        break;
                }

                lblSinResultados.Text = mensaje;
                lblSinResultados.Visible = true;
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            Util.SessionHelper.setClienteEditar(null);
            Response.Redirect("RegistroClientes.aspx");
        }
    }
}
