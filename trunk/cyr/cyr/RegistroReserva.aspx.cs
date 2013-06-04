using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using BLLayer;
using System.Globalization;

namespace cyr
{
    public partial class RegistroReserva : System.Web.UI.Page
    {
        BLTiposDocumento oBLTiposDocumento = new BLTiposDocumento();
        BLReservas oBLReservas = new BLReservas();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarMesas();
                ucBuscarCliente.Referrer = "RegistroReserva.aspx";

                string method = Request.QueryString["m"] != null ? Request.QueryString["m"] : string.Empty;
                BECliente oCliente = null;
                
                // Cargar cliente seleccionado, if any.
                oCliente = Util.SessionHelper.getClienteEditar();

                if (method.Equals("edit"))
                {
                    string idReserva = Request.QueryString["id"] != null ? Request.QueryString["id"] : string.Empty;

                    if (!string.IsNullOrEmpty(idReserva))
                    {
                        BEReserva oReserva = new BEReserva();
                        oReserva.CodigoReserva = Convert.ToInt32(idReserva);
                        oReserva.Mesa = new BEMesa();
                        oReserva.Mesa.CodigoMesa = 0;
                        List<BEReserva> oListaReservas = oBLReservas.selectReserva(oReserva);

                        if (oListaReservas.Count == 1)
                        {
                            oCliente = oListaReservas[0].Cliente;
                            cargarReserva(oListaReservas[0]);
                            divCancelarReserva.Visible = true;
                            ucBuscarCliente.HabilitarBusqueda = false;
                        }
                    }
                }

                if (oCliente != null)
                {
                    ucBuscarCliente.cargarDatosCliente(oCliente);
                    Util.SessionHelper.setClienteEditar(null);
                    Util.SessionHelper.setConsultaClienteReferrer(null);
                }
            }
        }

        protected void btnGrabarReserva_Click(object sender, EventArgs e)
        {
            // retrieve data
            BEReserva oReserva = new BEReserva();
            oReserva.CodigoReserva = string.IsNullOrEmpty(txtNumeroReserva.Text.Trim()) ? 0 : Convert.ToInt32(txtNumeroReserva.Text.Trim());
            oReserva.Cliente = new BECliente();
            oReserva.Cliente.CodigoCliente = ucBuscarCliente.CodigoCliente;
            oReserva.CantidadPersonas = Convert.ToInt32(txtCantidadPersonas.Text);
            oReserva.FechaReserva = DateTime.ParseExact(txtFechaReserva.Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
            oReserva.HoraInicio = txtHoraInicio.Text;
            oReserva.HoraFin = txtHoraFin.Text;
            oReserva.Mesa = new BEMesa();
            oReserva.Mesa.CodigoMesa = Convert.ToInt32(ddlMesa.SelectedValue);

            if (txtObservaciones.Text.Trim().Length > 250)
                oReserva.Observacion = txtObservaciones.Text.Trim().Substring(0, 250);
            else
                oReserva.Observacion = txtObservaciones.Text.Trim();

            oReserva.Estado = "A";

            DTOResultado oResultado = oBLReservas.grabarReserva(oReserva);
            string mensaje = string.Empty;

            if (oResultado != null)
            {
                switch (oResultado.Codigo)
                {
                    case (int)Constantes.CodigoGrabarReserva.Ok:
                        mensaje = "La reserva se actualizó correctamente.";

                        oReserva = (BEReserva) oResultado.Objeto;
                        txtNumeroReserva.Text = oReserva.CodigoReserva.ToString();
                        break;

                    case (int)Constantes.CodigoGrabarReserva.Error:
                        mensaje = "Ocurrió un error al grabar la reserva. Por favor, inténtelo nuevamente.";
                        break;
                    case (int)Constantes.CodigoGrabarReserva.FechaNoValida:
                        mensaje = "Ya existe una reserva para la mesa seleccionada en la fecha y horas ingresadas.";
                        break;
                    case (int)Constantes.CodigoGrabarReserva.ReservaPendienteFechaEspecial:
                        mensaje = "La reserva se encuentra pendiente de aprobación por el administrador para que sea habilitada.";
                        break;
                    default:
                        break;
                }
            }

            lblMensaje.Text = mensaje;
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("BusquedaReservas.aspx");
        }

        protected void btnEliminarReserva_Click(object sender, EventArgs e)
        {
            BEReserva oReserva = new BEReserva();
            oReserva.CodigoReserva = string.IsNullOrEmpty(txtNumeroReserva.Text.Trim()) ? 0 : Convert.ToInt32(txtNumeroReserva.Text.Trim());

            DTOResultado oResultado = oBLReservas.eliminarReserva(oReserva);
            string mensaje = string.Empty;

            if (oResultado != null)
            {
                switch (oResultado.Codigo)
                {
                    case (int)Constantes.CodigoEliminarReserva.Ok:
                        mensaje = "La reserva se canceló correctamente.";
                        limpiarReserva();
                        break;

                    case (int)Constantes.CodigoEliminarReserva.Error:
                        mensaje = "Ocurrió un error al cancelar la reserva. Por favor, inténtelo nuevamente.";
                        break;
                    default:
                        break;
                }
            }

            lblMensaje.Text = mensaje;

        }

        private void cargarMesas()
        {
            try
            {
                BEMesa oMesa = new BEMesa();
                oMesa.CodigoLocal = 1; // TODO: get user local code.
                List<BEMesa> oListaMesas = oBLReservas.selectMesas(oMesa);
                oMesa = new BEMesa();
                oMesa.CodigoMesa = 0;
                oMesa.NumeroMesa = "Seleccionar";
                oListaMesas.Insert(0, oMesa);
                ddlMesa.DataSource = oListaMesas;
                ddlMesa.DataValueField = "CodigoMesa";
                ddlMesa.DataTextField = "NumeroMesa";
                ddlMesa.DataBind();
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }
        }

        private void cargarReserva(BEReserva oReserva)
        {
            txtNumeroReserva.Text = oReserva.CodigoReserva.ToString();
            txtFechaReserva.Text = Convert.ToDateTime(oReserva.FechaReserva).ToString("dd/MM/yyyy");
            txtHoraInicio.Text = oReserva.HoraInicio;
            txtHoraFin.Text = oReserva.HoraFin;
            txtCantidadPersonas.Text = oReserva.CantidadPersonas.ToString();
            ddlMesa.SelectedValue = oReserva.Mesa.CodigoMesa.ToString();
            txtObservaciones.Text = oReserva.Observacion;
        }

        private void limpiarReserva()
        {
            ucBuscarCliente.limpiarDatos();
            txtNumeroReserva.Text = "";
            txtFechaReserva.Text = "";
            txtHoraInicio.Text = "";
            txtHoraFin.Text = "";
            txtCantidadPersonas.Text = "";
            ddlMesa.SelectedIndex = 0;
            txtObservaciones.Text = "";
        }
    }
}
