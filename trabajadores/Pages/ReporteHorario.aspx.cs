using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using BLHorario;
using BLSemana;

public partial class Pages_ReporteHorario : System.Web.UI.Page
{
    int MidSemana = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["idSemana"] != null)
        {
            MidSemana = int.Parse(Request.QueryString["idSemana"]);
            CargarHorarioSemanal(MidSemana);
            

        }

        if (!IsPostBack) {
            
            //Cargar Semana
            SemanaBL oSemana = new SemanaBL();
            ListItem liSemana = new ListItem("", "");
            drpSemana.Items.Add(liSemana);

            foreach (DataRow row in oSemana.getSemana().Rows)
            {
                int lidSemana = int.Parse(row["idSemana"].ToString());
                string lSemana = "Del " + DateTime.Parse(row["Inicio"].ToString()).ToShortDateString() + " al " + DateTime.Parse(row["Fin"].ToString()).ToShortDateString();
                liSemana = new ListItem();
                liSemana.Value = lidSemana.ToString();
                liSemana.Text = lSemana;
                if (MidSemana == lidSemana) liSemana.Selected = true;
                drpSemana.Items.Add(liSemana);
            }
            oSemana = null;

           
        }


    }

    public void CargarHorarioSemanal(int idSemana) {
        
        HorarioBL oHoras = new HorarioBL();

        foreach (DataRow row in oHoras.getHoras().Rows)
        {

            TableRow line = new TableRow();//Fila
            TableCell column = new TableCell();//Columna

            //Agrega Horas
            line.Font.Bold = true;
            line.ForeColor = System.Drawing.Color.White;
            column = new TableCell();
            column.Font.Size = 8;
            column.BackColor = System.Drawing.Color.FromName("#4b6c9e");
            column.Text = row["Time"].ToString();
            line.Cells.Add(column);

            //Agrega Lunes
            column = new TableCell();
            column.ForeColor = System.Drawing.Color.Black;
            column.Font.Size = 8;
            HorarioBL oGetLunes = new HorarioBL();

            foreach (DataRow row2 in oGetLunes.getHorassSemanaLunes(idSemana, row["Time"].ToString()).Rows)
            {
                column.Text += row2["Paterno"].ToString() + ' ' + row2["Nombre"].ToString() + "-<font color='Green'>" + row2["cargo"].ToString() + "</font><BR>";
            }
            line.Cells.Add(column);
            oGetLunes = null;

            //Agrega Martes
            column = new TableCell();
            column.ForeColor = System.Drawing.Color.Black;
            column.Font.Size = 8;
            HorarioBL oGetMartes = new HorarioBL();

            foreach (DataRow row2 in oGetMartes.getHorassSemanaMartes(idSemana, row["Time"].ToString()).Rows)
            {
                column.Text += row2["Paterno"].ToString() + ' ' + row2["Nombre"].ToString() + "-<font color='Green'>" + row2["cargo"].ToString() + "</font><BR>";
            }
            line.Cells.Add(column);
            oGetMartes = null;

            //Agrega Miercoles
            column = new TableCell();
            column.ForeColor = System.Drawing.Color.Black;
            column.Font.Size = 8;
            HorarioBL oGetMiercoles = new HorarioBL();

            foreach (DataRow row2 in oGetMiercoles.getHorassSemanaMiercoles(idSemana, row["Time"].ToString()).Rows)
            {
                column.Text += row2["Paterno"].ToString() + ' ' + row2["Nombre"].ToString() + "-<font color='Green'>" + row2["cargo"].ToString() + "</font><BR>";
            }
            line.Cells.Add(column);
            oGetMiercoles = null;

            //Agrega Jueves
            column = new TableCell();
            column.ForeColor = System.Drawing.Color.Black;
            column.Font.Size = 8;
            HorarioBL oGetJueves = new HorarioBL();

            foreach (DataRow row2 in oGetJueves.getHorassSemanaJueves(idSemana, row["Time"].ToString()).Rows)
            {
                column.Text += row2["Paterno"].ToString() + ' ' + row2["Nombre"].ToString() + "-<font color='Green'>" + row2["cargo"].ToString() + "</font><BR>";
            }
            line.Cells.Add(column);
            oGetJueves = null;

            //Agrega Viernes
            column = new TableCell();
            column.ForeColor = System.Drawing.Color.Black;
            column.Font.Size = 8;
            HorarioBL oGetViernes = new HorarioBL();

            foreach (DataRow row2 in oGetViernes.getHorassSemanaViernes(idSemana, row["Time"].ToString()).Rows)
            {
                column.Text += row2["Paterno"].ToString() + ' ' + row2["Nombre"].ToString() + "-<font color='Green'>" + row2["cargo"].ToString() + "</font><BR>";
            }
            line.Cells.Add(column);
            oGetViernes = null;

            //Agrega Sabado
            column = new TableCell();
            column.ForeColor = System.Drawing.Color.Black;
            column.Font.Size = 8;
            HorarioBL oGetSabado = new HorarioBL();

            foreach (DataRow row2 in oGetSabado.getHorassSemanaSabado(idSemana, row["Time"].ToString()).Rows)
            {
                column.Text += row2["Paterno"].ToString() + ' ' + row2["Nombre"].ToString() + "-<font color='Green'>" + row2["cargo"].ToString() + "</font><BR>";
            }
            line.Cells.Add(column);
            oGetSabado = null;

            //Agrega Domingo
            column = new TableCell();
            column.ForeColor = System.Drawing.Color.Black;
            column.Font.Size = 8;
            HorarioBL oGetDomingo = new HorarioBL();

            foreach (DataRow row2 in oGetDomingo.getHorassSemanaDomingo(idSemana, row["Time"].ToString()).Rows)
            {
                column.Text += row2["Paterno"].ToString() + ' ' + row2["Nombre"].ToString() + "-<font color='Green'>" + row2["cargo"].ToString() + "</font><BR>";
            }
            line.Cells.Add(column);
            oGetDomingo = null;


            tbSemana.Rows.Add(line);

        }
        oHoras = null;
    
    
    
    }
    protected void ddlSemana_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            CargarHorarioSemanal(int.Parse(drpSemana.SelectedValue));
            //Response.Redirect("ReporteHorario.aspx?idSemana=" + drpSemana.SelectedValue);
            //convertToExcel(GetTableCellsToDataSet());
      
        }
        catch (Exception ee)
        {
            //lblError.Text = ee.Message;
        }


    }

    
   
}