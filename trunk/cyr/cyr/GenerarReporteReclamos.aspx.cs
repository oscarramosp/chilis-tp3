using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLLayer;
using System.Data;
using cyr.reports;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using System.Globalization;

namespace cyr
{
    public partial class GenerarReporteReclamos : System.Web.UI.Page
    {
        BLReclamos oBLReclamos = new BLReclamos();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setControles();
            }
            
        }

        protected void setControles()
        {
            ddlEstado.Items.Add(new ListItem("--Todos--", "%"));
            ddlEstado.Items.Add(new ListItem("Atendido", "A"));
            ddlEstado.Items.Add(new ListItem("Presentado", "P"));
        }

        #region Eventos

        protected void btnGenerarReporte_Click(object sender, EventArgs e)
        {
            string fechaInicio = txtFechaInicio.Text.Trim();
            string fechaFin = txtFechaFin.Text.Trim();
            string estado = ddlEstado.SelectedValue; // % es comodín, means TODOS

            // Poblar datatable con información
            DataTable dtReclamos = oBLReclamos.selectReporteReclamos(
                DateTime.ParseExact(fechaInicio, "dd/MM/yyyy", CultureInfo.InvariantCulture),
                DateTime.ParseExact(fechaFin, "dd/MM/yyyy", CultureInfo.InvariantCulture),
                estado);

            if (dtReclamos.Rows.Count == 0)
            {
                divResultado.Visible = false;
                btnImprimir.Visible = false;
                lblSinResultados.Visible = true;
                lblSinResultados.Text = "No encontraron reclamos para generar el reporte en el periodo " + fechaInicio + " - " + fechaFin;
                return;
            }

            dtReclamos.TableName = "dtReclamos";

            divResultado.Visible = true;
            btnImprimir.Visible = true;
            lblSinResultados.Visible = false;

            lblGenerado.Text = DateTime.Today.ToString("dd/MM/yyyy");
            lblRango.Text = fechaInicio + " - " + fechaFin;

            // Cargar plantilla RPT
            ReportDocument rpt = new ReportDocument();
            rpt.Load(Server.MapPath("reports/rptReclamos.rpt"));
            rpt.SetDataSource(dtReclamos);

            crvReclamos.DisplayToolbar = false;
            crvReclamos.DisplayGroupTree = false;
            crvReclamos.ReportSource = rpt;
            crvReclamos.DataBind();
        }

        #endregion
        
    }
}
