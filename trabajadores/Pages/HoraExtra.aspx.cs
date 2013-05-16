using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLSemana;
using BLTrabajador;
using BLCargo;
using BLTipoTrabajador;
using BLHorario;
using BLHoraExtra;
using BEHorario;
using BEHoraExtra;

public partial class Pages_HoraExtra : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //Cargar Horas Extras

            cargarHR(ddlLunes);
            cargarHR(ddlMartes);
            cargarHR(ddlMiercoles);
            cargarHR(ddlJueves);
            cargarHR(ddlViernes);
            cargarHR(ddlSabado);
            cargarHR(ddlDomingo);

            //Cargar Cargo
            CargoBL ocargo = new CargoBL();

            foreach (DataRow row in ocargo.getCargo().Rows)
            {
                int lidCargo = int.Parse(row["idCargo"].ToString());
                string lCargo = row["Descripcion"].ToString();
                ListItem liCargo = new ListItem();
                liCargo.Value = lidCargo.ToString();
                liCargo.Text = lCargo;

                drpCargo.Items.Add(liCargo);
            }
            ocargo = null;

            //Cargar Tipo Trabajador
            TipoTrabajadorBL oTipoTrabajador = new TipoTrabajadorBL();
            ListItem liTipoTrab = new ListItem("","");
            drpTrabajador.Items.Add(liTipoTrab);

            foreach (DataRow row in oTipoTrabajador.getTipoTrabajador().Rows)
            {
                int lidTipoTrab = int.Parse(row["id"].ToString());
                string lTipoTrab = row["Descripcin"].ToString();
                liTipoTrab = new ListItem();
                liTipoTrab.Value = lidTipoTrab.ToString();
                liTipoTrab.Text = lTipoTrab;

                drpTipo.Items.Add(liTipoTrab);
            }
            //Cargar Semana
            SemanaBL oSemana = new SemanaBL();
            ListItem liSemana = new ListItem("", "");
            drpSemana.Items.Add(liSemana);

            foreach (DataRow row in oSemana.getSemana().Rows)
            {
                int lidSemana = int.Parse(row["idSemana"].ToString());
                string lSemana ="Del " +  DateTime.Parse(row["Inicio"].ToString()).ToShortDateString() +" al " + DateTime.Parse(row["Fin"].ToString()).ToShortDateString();
                liSemana = new ListItem();
                liSemana.Value = lidSemana.ToString();
                liSemana.Text = lSemana;

                drpSemana.Items.Add(liSemana);
            }
            oSemana = null;

            TrabajadorBL oTipoTrab = new TrabajadorBL();

            foreach (DataRow row in oTipoTrab.getTrabajadoresActivos().Rows)
            {
                int lidTrab = int.Parse(row["idTrabajador"].ToString());
                string lTrab = row["ApellidoPaterno"].ToString() + " " + row["apellidoMaterno"].ToString() + " " + row["Nombre"].ToString();
                ListItem liTrab = new ListItem();
                liTrab.Value = lidTrab.ToString();
                liTrab.Text = lTrab;

                drpTrabajador.Items.Add(liTrab);
            }
            oTipoTrab = null;
        }

       

    }
    protected void ddlSemana_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            CargarHorario();
        }
        catch(Exception ee)
        {
            lblErrror.Text = ee.Message;
        }

        
    }

    protected void ddlDias_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtTotal.Text = Convert.ToString((ddlLunes.SelectedValue == "0" ? 0 : int.Parse(ddlLunes.SelectedValue)) +
                                                (ddlMartes.SelectedValue == "0" ? 0 : int.Parse(ddlMartes.SelectedValue)) +
                                                (ddlMiercoles.SelectedValue == "0" ? 0 : int.Parse(ddlMiercoles.SelectedValue)) +
                                                (ddlJueves.SelectedValue == "0" ? 0 : int.Parse(ddlJueves.SelectedValue)) +
                                                (ddlViernes.SelectedValue == "0" ? 0 : int.Parse(ddlViernes.SelectedValue)) +
                                                (ddlSabado.SelectedValue == "0" ? 0 : int.Parse(ddlSabado.SelectedValue)) +
                                                (ddlDomingo.SelectedValue == "0" ? 0 : int.Parse(ddlDomingo.SelectedValue)));

    }
    protected void ddlTrabajadores_SelectedIndexChanged(object sender, EventArgs e)
    {
        try {
            TrabajadorBL oTrab = new TrabajadorBL();

            foreach (DataRow row in oTrab.getTrabajador(int.Parse(drpTrabajador.SelectedValue)).Rows)
            {

                lblCodigo.Text = row["idTrabajador"].ToString();
                drpCargo.SelectedValue = row["IdCargo"].ToString();
                drpTipo.SelectedValue = row["IdTipoTrabjador"].ToString();
               
            }
            oTrab = null;

            CargarHorario();
        
        }
        catch(Exception ee) 
        {
            lblErrror.Text = ee.Message;
        }
        

    }

    void cargarHR(DropDownList ddl)
    {
        for (int i = 0; i < 8; i++)
        {
            if (i == 0)
            {
                ddl.Items.Add(new ListItem("", i.ToString()));

            }
            else
            {
                ddl.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

        }


    }

    private void CargarHorario()
    {

        if (drpSemana.SelectedIndex != 0 && drpTrabajador.SelectedIndex != 0)
        {
            HorarioBL oHorario = new HorarioBL();

            HorarioBE Entrada = oHorario.getHorario(int.Parse(drpTrabajador.SelectedValue), int.Parse(drpSemana.SelectedValue), 1);
            HorarioBE Salida = oHorario.getHorario(int.Parse(drpTrabajador.SelectedValue), int.Parse(drpSemana.SelectedValue), 2);

            HoraExtraBL oHoraExtra = new HoraExtraBL();
            HoraExtraBE HoraExtra = oHoraExtra.getHoraExtra(int.Parse(drpTrabajador.SelectedValue), int.Parse(drpSemana.SelectedValue));

            if (HoraExtra != null)
            {
                ddlLunes.SelectedValue = HoraExtra.Lunes == null ? "0" : Convert.ToString(HoraExtra.Lunes);
                ddlMartes.SelectedValue = HoraExtra.Martes == null ? "0" : Convert.ToString(HoraExtra.Martes);
                ddlMiercoles.SelectedValue = HoraExtra.Miercoles == null ? "0" : Convert.ToString(HoraExtra.Miercoles);
                ddlJueves.SelectedValue = HoraExtra.Jueves == null ? "0" : Convert.ToString(HoraExtra.Jueves);
                ddlViernes.SelectedValue = HoraExtra.Viernes == null ? "0" : Convert.ToString(HoraExtra.Viernes);
                ddlSabado.SelectedValue = HoraExtra.Sabado == null ? "0" : Convert.ToString(HoraExtra.Sabado);
                ddlDomingo.SelectedValue = HoraExtra.Domingo == null ? "0" : Convert.ToString(HoraExtra.Domingo);

                txtTotal.Text = Convert.ToString((HoraExtra.Lunes == null ? 0 : HoraExtra.Lunes) +
                                                 (HoraExtra.Martes == null ? 0 : HoraExtra.Martes) +
                                                 (HoraExtra.Miercoles == null ? 0 : HoraExtra.Miercoles) +
                                                 (HoraExtra.Jueves == null ? 0 : HoraExtra.Jueves) +
                                                 (HoraExtra.Viernes == null ? 0 : HoraExtra.Viernes) +
                                                 (HoraExtra.Sabado == null ? 0 : HoraExtra.Sabado) +
                                                 (HoraExtra.Domingo == null ? 0 : HoraExtra.Domingo));


            }
            else
            {
                ddlLunes.ClearSelection();
                ddlMartes.ClearSelection();
                ddlMiercoles.ClearSelection();
                ddlJueves.ClearSelection();
                ddlViernes.ClearSelection();
                ddlSabado.ClearSelection();
                ddlDomingo.ClearSelection();
                txtTotal.Text = "0";
            }



            if (Entrada != null)
            {
                txtLunesE.Text = Entrada.Lunes == null ? "" : Convert.ToString(Entrada.Lunes);
                txtMartesE.Text = Entrada.Martes == null ? "" : Convert.ToString(Entrada.Martes);
                txtMiercolesE.Text = Entrada.Miercoles == null ? "" : Convert.ToString(Entrada.Miercoles);
                txtJuevesE.Text = Entrada.Jueves == null ? "" : Convert.ToString(Entrada.Jueves);
                txtViernesE.Text = Entrada.Viernes == null ? "" : Convert.ToString(Entrada.Viernes);
                txtSabadoE.Text = Entrada.Sabado == null ? "" : Convert.ToString(Entrada.Sabado);
                txtDomingoE.Text = Entrada.Domingo == null ? "" : Convert.ToString(Entrada.Domingo);

            }
            else
            {
                txtLunesE.Text = "";
                txtMartesE.Text = "";
                txtMiercolesE.Text = "";
                txtJuevesE.Text = "";
                txtViernesE.Text = "";
                txtSabadoE.Text = "";
                txtDomingoE.Text = "";
            }

            if (Salida != null)
            {
                txtLunesS.Text = Salida.Lunes == null ? "" : Convert.ToString(Salida.Lunes);
                txtMartesS.Text = Salida.Martes == null ? "" : Convert.ToString(Salida.Martes);
                txtMiercolesS.Text = Salida.Miercoles == null ? "" : Convert.ToString(Salida.Miercoles);
                txtJuevesS.Text = Salida.Jueves == null ? "" : Convert.ToString(Salida.Jueves);
                txtViernesS.Text = Salida.Viernes == null ? "" : Convert.ToString(Salida.Viernes);
                txtSabadoS.Text = Salida.Sabado == null ? "" : Convert.ToString(Salida.Sabado);
                txtDomingoS.Text = Salida.Domingo == null ? "" : Convert.ToString(Salida.Domingo);
            }
            else
            {
                txtLunesS.Text = "";
                txtMartesS.Text = "";
                txtMiercolesS.Text = "";
                txtJuevesS.Text = "";
                txtViernesS.Text = "";
                txtSabadoS.Text = "";
                txtDomingoS.Text = "";
            }

            if (Entrada.Lunes == null && Entrada.Martes == null && Entrada.Miercoles == null && Entrada.Jueves == null && Entrada.Viernes == null && Entrada.Sabado == null && Entrada.Domingo == null && Salida.Lunes == null && Salida.Martes == null && Salida.Miercoles == null && Salida.Jueves == null && Salida.Viernes == null && Salida.Sabado == null && Salida.Domingo == null)
            {
                lblErrror.Text = "No Hay Horas Registradas";
                btnGrabar.Enabled = false;
                btnImprimir.Enabled = false;
            }
            else
            {
                lblErrror.Text = "";
                btnGrabar.Enabled = true;
                btnImprimir.Enabled = true;
            }
        }
    }

    protected void btnGrabar_Click(object sender, EventArgs e)
    {
        string Mensaje = "";
        if (drpSemana.SelectedIndex != 0 && drpTrabajador.SelectedIndex != 0)
        {
            HoraExtraBL InsertarHE = new HoraExtraBL();
            HoraExtraBE HoraExtra = new HoraExtraBE();

            HoraExtra.idTrabajador = int.Parse((drpTrabajador.SelectedValue));
            HoraExtra.idSemana = int.Parse((drpSemana.SelectedValue));
            if (!(string.IsNullOrEmpty(ddlLunes.SelectedItem.Text))) HoraExtra.Lunes = int.Parse(ddlLunes.SelectedItem.Value);
            if (!(string.IsNullOrEmpty(ddlMartes.SelectedItem.Text))) HoraExtra.Martes = int.Parse(ddlMartes.SelectedItem.Value);
            if (!(string.IsNullOrEmpty(ddlMiercoles.SelectedItem.Text))) HoraExtra.Miercoles = int.Parse(ddlMiercoles.SelectedItem.Value);
            if (!(string.IsNullOrEmpty(ddlJueves.SelectedItem.Text))) HoraExtra.Jueves = int.Parse(ddlJueves.SelectedItem.Value);
            if (!(string.IsNullOrEmpty(ddlViernes.SelectedItem.Text))) HoraExtra.Viernes = int.Parse(ddlViernes.SelectedItem.Value);
            if (!(string.IsNullOrEmpty(ddlSabado.SelectedItem.Text))) HoraExtra.Sabado = int.Parse(ddlSabado.SelectedItem.Value);
            if (!(string.IsNullOrEmpty(ddlDomingo.SelectedItem.Text))) HoraExtra.Domingo = int.Parse(ddlDomingo.SelectedItem.Value);

            Mensaje=InsertarHE.InsertarHoraExtra(HoraExtra,int.Parse(drpTipo.SelectedValue),decimal.Parse(txtTotal.Text.ToString()));
            CargarHorario();
            lblErrror.Text = Mensaje;
        }
        else
        {

            lblErrror.Text = "Seleccione la semana y el trabajador antes de registrar";
        }
    }


}