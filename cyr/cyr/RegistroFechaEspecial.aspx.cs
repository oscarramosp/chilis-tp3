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

namespace cyr
{
    public partial class RegistroFechaEspeciale : System.Web.UI.Page
    {
        BLFechasEspeciales oBLFechasEspeciales = new BLFechasEspeciales();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BEFechaEspecial objFechaEspecial = Util.SessionHelper.getFechaEspecialEditar();

                if (objFechaEspecial == null)
                {
                    objFechaEspecial = new BEFechaEspecial();
                    Util.SessionHelper.setFechaEspecialEditar(objFechaEspecial);
                }
                else
                {
                    cargarDatosFechaEspecial(objFechaEspecial);
                }
            }
        }

        private void cargarDatosFechaEspecial(BEFechaEspecial oFechaEspecial)
        {
            if (oFechaEspecial == null)
                return;
            txtFecha.Text = Convert.ToDateTime(oFechaEspecial.Fecha).ToString("dd/MM/yyyy");
            txtMotivo.Text = oFechaEspecial.Motivo;
            deshabilitarControlesUpdate();
        }

        private void deshabilitarControlesUpdate()
        {
            txtFecha.Enabled = false;
        }

        private void limpiarReserva()
        {
            txtFecha.Text = "";
            txtMotivo.Text = "";
        }

        protected void btnGrabar_Click(object sender, EventArgs e)
        {
            BEFechaEspecial objFechaEspecial = Util.SessionHelper.getFechaEspecialEditar();
            objFechaEspecial.Fecha = DateTime.ParseExact(txtFecha.Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
            objFechaEspecial.Motivo = txtMotivo.Text.Trim();

            DTOResultado oResultado = oBLFechasEspeciales.grabarFechaEspecial(objFechaEspecial);
            string mensaje = string.Empty;

            switch (oResultado.Codigo)
            {
                case (int)Constantes.CodigoGrabarFechaEspecial.Ok:
                    mensaje = "Fecha especial actualizada correctamente.";
                    objFechaEspecial = (BEFechaEspecial)oResultado.Objeto;
                    break;
                case (int)Constantes.CodigoGrabarReserva.Error:
                    mensaje = "Ocurrió un error al grabar la fecha especial. Por favor, inténtelo nuevamente.";
                    break;
                case (int)Constantes.CodigoGrabarFechaEspecial.FechaExiste:
                    mensaje = "Ya existe una fecha especial para el día ingresado";
                    break;
                case (int)Constantes.CodigoGrabarFechaEspecial.ExisteReservaFechaEspecial:
                    mensaje = "No se puede registrar la fecha especial porque existen reservas registradas para ese día";
                    break;
                default:
                    break;
            }

            if (objFechaEspecial == null)
            {
                //error it is
                lblMensaje.Text = "Ocurrió un error al registrar la fecha especial.";
            }
            else
            {
                lblMensaje.Text = "";
                Util.SessionHelper.setFechaEspecialEditar(objFechaEspecial);
            }

            lblMensaje.Text = mensaje;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Util.SessionHelper.setFechaEspecialEditar(null);
            Response.Redirect("BusquedaFechasEspeciales.aspx");
        }
    }
}
