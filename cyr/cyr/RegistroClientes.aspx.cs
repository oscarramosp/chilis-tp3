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
    public partial class FormularioClientes : System.Web.UI.Page
    {
        BLClientes oBLClientes = new BLClientes();
        BLTiposDocumento oBLTiposDocumento = new BLTiposDocumento();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setControles();

                // Ugly coding it is.
                // Cuando el objeto sesión "detalleClienteObjeto" es nulo, entonces es un registro nuevo.
                // Se instancia un objeto Cliente y se trabaja sobre este para realizar el nuevo registro.
                // Si el objeto cliente tiene un ID cero, es nuevo; caso contrario es para editar
                // Cuando el objeto sesión "detalleClienteObjeto" tiene un valor, es una edición

                BECliente objCliente = Util.SessionHelper.getClienteEditar();

                if (objCliente == null)
                {
                    objCliente = new BECliente();
                    objCliente.TipoDocumento = new BETipoDocumento();
                    objCliente.Direcciones = new List<BEDireccionCliente>(); // don't let me nullify
                    Util.SessionHelper.setClienteEditar(objCliente);
                }
                else
                {
                    cargarDatosCliente(objCliente);
                }
            } 
        }

        private void setControles()
        {
            cargarTiposDocumento();
        }

        private void cargarDatosCliente(BECliente oCliente) 
        {
            if (oCliente == null)
                return;

            if (oCliente.TipoCliente == null)
                return;

            if (oCliente.TipoCliente.Equals("N"))
            {
                rbtNatural.Checked = true;
            }
            else
            {
                rbtJuridico.Checked = true;
            }

            txtNombre.Text = (oCliente.TipoCliente.Equals("N") ? oCliente.Nombres : oCliente.RazonSocial);
            txtApellidoPaterno.Text = oCliente.ApellidoPaterno;
            txtApellidoMaterno.Text = oCliente.ApellidoMaterno;
            ddlTipoDoc.SelectedValue = oCliente.TipoDocumento.CodigoTipoDocumento.ToString();
            txtNroDoc.Text = oCliente.NumeroDocumento;
            if (oCliente.Sexo != null || !oCliente.Sexo.Equals(""))
            {
                if (oCliente.Sexo.Equals("M"))
                {
                    rbtMasculino.Checked = true;
                }
                else
                {
                    rbtFemenino.Checked = true;
                }
            }
            txtContacto.Text = oCliente.Contacto;
            txtEmail.Text = oCliente.Email;
            txtTelefono.Text = oCliente.TelefonoPrincipal;

            oCliente.Direcciones = oBLClientes.selectDireccionesxCliente(oCliente);

            if (oCliente.Direcciones.Count == 0)
            {
                lblSinResultados.Text = "No existen direcciones para este cliente.";
                lblSinResultados.Visible = true;
            }
            else
            {
                dgvDirecciones.DataSource = oCliente.Direcciones;
                dgvDirecciones.DataBind();
            }

            deshabilitarControlesUpdate();

            Util.SessionHelper.setClienteEditar(oCliente);
            Td_CheckedChanged(null, null);
        }

        private void deshabilitarControlesUpdate()
        {
            rbtJuridico.Enabled = false;
            rbtNatural.Enabled = false;
            ddlTipoDoc.Enabled = false;
            rbtMasculino.Enabled = false;
            rbtFemenino.Enabled = false;
        }

        private void cargarTiposDocumento()
        {
            try
            {
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

            upEditarCliente.Update();
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
            divApePaterno.Visible = blnHabilitar;
            divApeMaterno.Visible = blnHabilitar;
            divContacto.Visible = !blnHabilitar;
        }

        protected void btnAgregarDireccion_Click(object sender, EventArgs e)
        {
            // Can't be null at this point. If it is, you suck at programming.
            bindearDirecciones();

            BECliente objCliente = Util.SessionHelper.getClienteEditar();
            objCliente.Direcciones.Add(new BEDireccionCliente());

            Util.SessionHelper.setClienteEditar(objCliente);

            dgvDirecciones.DataSource = objCliente.Direcciones;
            dgvDirecciones.DataBind();

            upDirecciones.Update();
        }

        private void bindearDirecciones()
        {
            BECliente objCliente = Util.SessionHelper.getClienteEditar();
            List<BEDireccionCliente> lstDireccion = new List<BEDireccionCliente>();

            foreach (GridViewRow gvRow in dgvDirecciones.Rows)
            {
                BEDireccionCliente objDireccion = new BEDireccionCliente();

                Label lblCodigoDireccion = (Label)gvRow.FindControl("lblCodigoDireccion");
                DropDownList ddlTipoDir = (DropDownList)gvRow.FindControl("ddlTipoDir");
                TextBox txtDireccion = (TextBox)gvRow.FindControl("txtDireccion");
                TextBox txtReferencia = (TextBox)gvRow.FindControl("txtReferencia");
                TextBox txtTelefonoDireccion = (TextBox)gvRow.FindControl("txtTelefono");

                objDireccion.CodigoDireccion = Convert.ToInt32(lblCodigoDireccion.Text);
                objDireccion.Direccion = txtDireccion.Text;
                objDireccion.Referencia = txtReferencia.Text;
                objDireccion.Telefono = txtTelefonoDireccion.Text;
                objDireccion.TipoDireccion = ddlTipoDir.SelectedValue;

                lstDireccion.Add(objDireccion);
            }

            objCliente.Direcciones = lstDireccion;
            Util.SessionHelper.setClienteEditar(objCliente);
        }

        protected void btnGrabar_Click(object sender, EventArgs e)
        {
            // Oh god why.

            BECliente objCliente = Util.SessionHelper.getClienteEditar();

            objCliente.TipoDocumento.CodigoTipoDocumento = Convert.ToInt32(ddlTipoDoc.SelectedValue);
            objCliente.Email = txtEmail.Text.Trim();
            objCliente.NumeroDocumento = txtNroDoc.Text.Trim();
            objCliente.TelefonoPrincipal = txtTelefono.Text.Trim();
            objCliente.Estado = "A"; // CONSTANT, Y U NO?!!!!
            objCliente.FechaNacimiento = null;
            objCliente.CodigoClasificacion = null;

            if (rbtNatural.Checked) {
                objCliente.Nombres = txtNombre.Text.Trim();
                objCliente.ApellidoPaterno = txtApellidoPaterno.Text.Trim();
                objCliente.ApellidoMaterno = txtApellidoMaterno.Text.Trim();
                objCliente.Sexo = rbtMasculino.Checked ? "M" : "F";
                objCliente.TipoCliente = "N"; // CONSTANT ME, BITCH!
            }

            if (rbtJuridico.Checked) {
                objCliente.RazonSocial = txtNombre.Text.Trim();
                objCliente.Contacto = txtContacto.Text.Trim();
                objCliente.TipoCliente = "J";
            }

            // direcciones teraki.
            // ugly and disgusting coding.
            List<BEDireccionCliente> lstDireccion = new List<BEDireccionCliente>();

            foreach (GridViewRow gvRow in dgvDirecciones.Rows)
            {
                Label lblCodigoDireccion = (Label)gvRow.FindControl("lblCodigoDireccion");
                DropDownList ddlTipoDir = (DropDownList)gvRow.FindControl("ddlTipoDir");
                TextBox txtDireccion = (TextBox)gvRow.FindControl("txtDireccion");
                TextBox txtReferencia = (TextBox)gvRow.FindControl("txtReferencia");
                TextBox txtTelefonoDireccion = (TextBox)gvRow.FindControl("txtTelefono");

                BEDireccionCliente objDireccion = new BEDireccionCliente();
                objDireccion.CodigoDireccion = Convert.ToInt32(lblCodigoDireccion.Text);
                objDireccion.Direccion = txtDireccion.Text;
                objDireccion.Referencia = txtReferencia.Text;
                objDireccion.Telefono = txtTelefonoDireccion.Text;
                objDireccion.TipoDireccion = ddlTipoDir.SelectedValue;

                lstDireccion.Add(objDireccion);
            }

            objCliente.Direcciones = lstDireccion;
            objCliente = oBLClientes.grabarCliente(objCliente);

            if (objCliente == null)
            {
                //error it is
                lblMensaje.Text = "Ocurrió un error al registrar al cliente.";
            }
            else
            {
                dgvDirecciones.DataSource = lstDireccion;
                dgvDirecciones.DataBind();

                lblMensaje.Text = "Cliente actualizado correctamente.";
                Util.SessionHelper.setClienteEditar(objCliente);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Util.SessionHelper.setClienteEditar(null);
            Response.Redirect("BusquedaClientes.aspx");
        }

        protected void dgvDirecciones_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("cmdEliminarDireccion"))
            {
                int rowNumber = Convert.ToInt32(e.CommandArgument);

                // can't be null. lol
                BECliente oCliente = Util.SessionHelper.getClienteEditar();
                oCliente.Direcciones.RemoveAt(rowNumber);
                Util.SessionHelper.setClienteEditar(oCliente);

                dgvDirecciones.DataSource = oCliente.Direcciones;
                dgvDirecciones.DataBind();

                upDirecciones.Update();
            }
        }

        private void configurarFilaDireccion(GridViewRow gvRow, BEDireccionCliente objDireccion)
        {
            
            DropDownList ddlTipoDir = (DropDownList)gvRow.FindControl("ddlTipoDir");
            TextBox txtDireccion = (TextBox)gvRow.FindControl("txtDireccion");
            TextBox txtReferencia = (TextBox)gvRow.FindControl("txtReferencia");
            TextBox txtTelefono = (TextBox)gvRow.FindControl("txtTelefono");
            LinkButton lbtEliminar = (LinkButton)gvRow.FindControl("lbtEliminarDireccion");

            lbtEliminar.OnClientClick = String.Format("return confirmarEliminar('{0}');", lbtEliminar.ClientID);

            if (objDireccion.TipoDireccion != null)
                ddlTipoDir.SelectedValue = objDireccion.TipoDireccion.ToString();

            txtDireccion.Text = objDireccion.Direccion;
            txtReferencia.Text = objDireccion.Referencia;
            txtTelefono.Text = objDireccion.Telefono;
        }

        protected void dgvDirecciones_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Ugly coding.
            // meanings:
            // L = lectura
            // E = Edición
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BEDireccionCliente objDireccion = e.Row.DataItem as BEDireccionCliente;
                configurarFilaDireccion(e.Row, objDireccion);
            }
        }
    }
}
