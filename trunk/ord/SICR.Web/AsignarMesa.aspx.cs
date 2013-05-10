using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICR.Persistencia;

namespace SICR.Web
{
    public partial class AsignarMesa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarZonas();
                MostrarMesas();
            }
        }

        protected void ddlZona_SelectedIndexChanged(object sender, EventArgs e)
        {
            MostrarMesas();
        }
        protected void pnlMesa_DataBinding(object sender, EventArgs e)
        {
            if (Eval("MesAsigna", "{0}") == "L")
            {
                Panel pnlMesa = (Panel)sender;
                pnlMesa.BackColor = System.Drawing.Color.Green;
                pnlMesa.CssClass = "divMesa";
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int codigoMesa=int.Parse(hfCodMesaActual.Value);
            MAsignacion newAsig = new MAsignacion
            {
                AnfCodigo = txtAnfitrion.Text,
                AsiCliente = txtCliente.Text,
                AsiCantidad =int.Parse( txtCantidad.Text),
                AsiFecha = DateTime.Now,
                MesCodigo= codigoMesa
            };
            
            newAsig.Save();
            MMesa selecMesa=new MMesa(x=>x.MesCodigo==codigoMesa);
            selecMesa.MesAsigna = "A";
            selecMesa.Save();

            MostrarMesas();
            txtCantidad.Text = "";
            txtAnfitrion.Text = "";
            txtCliente.Text = "";
        }
        private void MostrarZonas()
        {
            ddlZona.DataSource = (from z in MZona.All()
                                  where z.ZonEstado == "A"
                                  select z).ToArray();
            ddlZona.DataTextField = "ZonNombre";
            ddlZona.DataValueField = "ZonCodigo";
            ddlZona.DataBind();

        }
        private void MostrarMesas()
        {
            if (ddlZona.SelectedIndex != -1)
            {
                int codZona = int.Parse(ddlZona.SelectedValue);
                lvMesas.DataSource = (from m in MMesa.All()
                                      where m.ZonCodigo == codZona
                                      && m.MesEstado == "A"
                                      select m);
                lvMesas.DataBind();
            }
        }
    }
}