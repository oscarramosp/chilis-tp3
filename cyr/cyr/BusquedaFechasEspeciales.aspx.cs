using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLLayer;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System.Globalization;

namespace cyr
{
    public partial class BusquedaFechasEspeciales : System.Web.UI.Page
    {
        BLFechasEspeciales oBLFechasEspeciales = new BLFechasEspeciales();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setControles();
                buscarFechasEspeciales();
            }
        }

        private void setControles()
        {
            cargarAnhos();
            cargarMeses();
        }

        private void cargarAnhos()
        {
            DataRow drAnho;
            DataTable dtAnhos = new DataTable();

            dtAnhos.Columns.Add("Key");
            dtAnhos.Columns.Add("Value");

            drAnho = dtAnhos.NewRow();
            drAnho["Key"] = "0";
            drAnho["Value"] = "[Todos]";
            dtAnhos.Rows.Add(drAnho);

            //
            for (int i = DateTime.Now.Year-3; i < DateTime.Now.Year+4; i++)
			{
                drAnho = dtAnhos.NewRow();
                drAnho["Key"] = i.ToString();
                drAnho["Value"] = i.ToString();
                dtAnhos.Rows.Add(drAnho);
			}

            ddlAnho.DataSource = dtAnhos;
            ddlAnho.DataTextField = "Value";
            ddlAnho.DataValueField = "Key";
            ddlAnho.DataBind();

            ddlAnho.SelectedValue = DateTime.Now.Year.ToString();
        }

        private void cargarMeses()
        {
            Hashtable htaMeses = BLLayer.Constantes.listarMeses();
            htaMeses[0] = "[Todos]";

            DataRow drMes;
            DataTable dtMeses = new DataTable();

            dtMeses.Columns.Add("Key");
            dtMeses.Columns.Add("Value");

            for (int i = 0; i < 13; i++)
            {
                drMes = dtMeses.NewRow();
                drMes["Key"] = i.ToString();
                drMes["Value"] = htaMeses[i].ToString();
                dtMeses.Rows.Add(drMes);
            }

            ddlMes.DataSource = dtMeses;
            ddlMes.DataTextField = "Value";
            ddlMes.DataValueField = "Key";
            ddlMes.DataBind();

            ddlMes.SelectedValue = DateTime.Now.Month.ToString();

        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            buscarFechasEspeciales();
        }

        private void buscarFechasEspeciales()
        {
            List<BEFechaEspecial> oListaFechas = oBLFechasEspeciales.selectFechasEspeciales(Convert.ToInt32(ddlAnho.SelectedValue), Convert.ToInt32(ddlMes.SelectedValue), txtMotivo.Text);
            if (oListaFechas.Count == 0)
            {
                lblSinResultados.Visible = true;
                lblSinResultados.Text = "No se encontraron fechas especiales para los parámetros ingresados";
                dgvFechas.DataSource = null;
                dgvFechas.DataBind();
            }
            else
            {
                Session["lstBusquedaFechas"] = oListaFechas;
                dgvFechas.DataSource = oListaFechas;
                dgvFechas.DataBind();
                lblSinResultados.Visible = false;
                lblSinResultados.Text = String.Empty;
            }
        }

        protected void dgvFechas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lbtEliminarFecha = (LinkButton)e.Row.FindControl("lbtElimFecha");
                String strFecha = Server.HtmlDecode(e.Row.Cells[1].Text);
                String strMotivo = Server.HtmlDecode(e.Row.Cells[2].Text);
                lbtEliminarFecha.OnClientClick = String.Format("return confirmarEliminar('{0}','{1}','{2}');", strFecha, strMotivo, lbtEliminarFecha.ClientID);
            }
        }
        
        static Predicate<BEFechaEspecial> ById(Int32 codigoFechaEspecial)
        {
            return delegate(BEFechaEspecial oFechaEspecial)
            {
                return oFechaEspecial.Codigo == codigoFechaEspecial;
            };
        }

        protected void dgvFechas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("cmdDetalleFecha"))
            {
                Int32 codigoFecha = Convert.ToInt32(e.CommandArgument);
                if (!(Session["lstBusquedaFechas"] == null))
                {
                    List<BEFechaEspecial> lstFechas = (List<BEFechaEspecial>)Session["lstBusquedaFechas"];
                    BEFechaEspecial oFecha = lstFechas.Find(ById(codigoFecha));
                    Util.SessionHelper.setFechaEspecialEditar(oFecha);

                    Response.Redirect("RegistroFechaEspecial.aspx");
                }
            }
            if (e.CommandName.Equals("cmdEliminarFecha"))
            {
                Int32 codigoFecha = Convert.ToInt32(e.CommandArgument);
                BEFechaEspecial oFechaEspecial = new BEFechaEspecial();
                oFechaEspecial.Codigo = codigoFecha;
                oFechaEspecial.Fecha = DateTime.ParseExact(Server.HtmlDecode(((GridViewRow)((LinkButton)e.CommandSource).Parent.Parent).Cells[1].Text), "dd/MM/yyyy", CultureInfo.InvariantCulture);

                int codigoEliminacion = oBLFechasEspeciales.eliminarFechaEspecial(oFechaEspecial);
                string mensaje = string.Empty;

                switch (codigoEliminacion)
                {
                    case (int)BLLayer.Constantes.CodigoEliminarFechaEspecial.Ok:
                        buscarFechasEspeciales();
                        mensaje = "La fecha especial " + Server.HtmlDecode(((GridViewRow)((LinkButton)e.CommandSource).Parent.Parent).Cells[1].Text) + "-" + Server.HtmlDecode(((GridViewRow)((LinkButton)e.CommandSource).Parent.Parent).Cells[2].Text) + " ha sido eliminada correctamente";
                        break;
                    case (int)BLLayer.Constantes.CodigoEliminarFechaEspecial.FechaEspecialReserva:
                        mensaje = "La fecha especial no puede ser eliminada porque existen reservas registradas para ese día.";
                        buscarFechasEspeciales();
                        break;
                    case (int)BLLayer.Constantes.CodigoEliminarFechaEspecial.Error:
                        mensaje = "Ocurrió un error al eliminar la fecha especial";
                        break;
                }

                lblSinResultados.Text = mensaje;
                lblSinResultados.Visible = true;
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            Util.SessionHelper.setFechaEspecialEditar(null);
            Response.Redirect("RegistroFechaEspecial.aspx");
        }
    }
}
