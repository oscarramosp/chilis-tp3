using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BEHorario;
using BLHorario;
using BLSemana;
using BLTrabajador;
using BLCargo;
using BLTipoTrabajador;

public partial class Pages_Horario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //Cargar Horarios

            cargarHR(drpLunesE);
            cargarHR(drpMartesE);
            cargarHR(drpMiercolesE);
            cargarHR(drpJuevesE);
            cargarHR(drpViernesE);
            cargarHR(drpSabadoE);
            cargarHR(drpDomingoE);

            cargarHR(drpLunesS);
            cargarHR(drpMartesS);
            cargarHR(drpMiercolesS);
            cargarHR(drpJuevesS);
            cargarHR(drpViernesS);
            cargarHR(drpSabadoS);
            cargarHR(drpDomingoS);

          

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
            ListItem liTipoTrab = new ListItem("", "");
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
                string lSemana = "Del " + DateTime.Parse(row["Inicio"].ToString()).ToShortDateString() + " al " + DateTime.Parse(row["Fin"].ToString()).ToShortDateString();
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

    protected void ddlHoras_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (drpLunesE.SelectedIndex != 0 || drpMartesE.SelectedIndex != 0 || drpMiercolesE.SelectedIndex != 0 || drpJuevesE.SelectedIndex != 0 || drpViernesE.SelectedIndex != 0 || drpSabadoE.SelectedIndex != 0 || drpDomingoE.SelectedIndex != 0)
        {
            if (drpLunesS.SelectedIndex != 0 || drpMartesS.SelectedIndex != 0 || drpMiercolesS.SelectedIndex != 0 || drpJuevesS.SelectedIndex != 0 || drpViernesS.SelectedIndex != 0 || drpSabadoS.SelectedIndex != 0 || drpDomingoS.SelectedIndex != 0)
            {
                SumarHoras();
            }
        }

       

    }

    void SumarHoras()
    {
        txtLunes.Text = (int.Parse(drpLunesS.SelectedValue.Replace(":00:00", "")) - int.Parse(drpLunesE.SelectedValue.Replace(":00:00", ""))).ToString("N2");
        txtMartes.Text = (int.Parse(drpMartesS.SelectedValue.Replace(":00:00", "")) - int.Parse(drpMartesE.SelectedValue.Replace(":00:00", ""))).ToString("N2");
        txtMiercoles.Text = (int.Parse(drpMiercolesS.SelectedValue.Replace(":00:00", "")) - int.Parse(drpMiercolesE.SelectedValue.Replace(":00:00", ""))).ToString("N2");
        txtJueves.Text = (int.Parse(drpJuevesS.SelectedValue.Replace(":00:00", "")) - int.Parse(drpJuevesE.SelectedValue.Replace(":00:00", ""))).ToString("N2");
        txtViernes.Text = (int.Parse(drpViernesS.SelectedValue.Replace(":00:00", "")) - int.Parse(drpViernesE.SelectedValue.Replace(":00:00", ""))).ToString("N2");
        txtSabado.Text = (int.Parse(drpSabadoS.SelectedValue.Replace(":00:00", "")) - int.Parse(drpSabadoE.SelectedValue.Replace(":00:00", ""))).ToString("N2");
        txtDomingo.Text = (int.Parse(drpDomingoS.SelectedValue.Replace(":00:00", "")) - int.Parse(drpDomingoE.SelectedValue.Replace(":00:00", ""))).ToString("N2");
        txtTotal.Text = (decimal.Parse(txtLunes.Text) + decimal.Parse(txtMartes.Text) + decimal.Parse(txtMiercoles.Text) + decimal.Parse(txtJueves.Text) + decimal.Parse(txtViernes.Text) + decimal.Parse(txtSabado.Text) + decimal.Parse(txtDomingo.Text)).ToString("N2");
            

    }
    protected void ddlSemana_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            CargarHorario();
        }
        catch (Exception ee)
        {
            lblErrror.Text = ee.Message;
        }


    }

    protected void ddlTrabajadores_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
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
        catch (Exception ee)
        {
            lblErrror.Text = ee.Message;
        }


    }

    protected void btnGrabar_Click(object sender, EventArgs e)
    {
        try
        {
            HorarioBE HorarioE = new HorarioBE();
            HorarioBE HorarioS = new HorarioBE();
            if (drpSemana.SelectedIndex != 0 && drpTrabajador.SelectedIndex != 0)
            {
                if (decimal.Parse(txtLunes.Text) < 0 || decimal.Parse(txtMartes.Text) < 0 || decimal.Parse(txtMiercoles.Text) < 0 || decimal.Parse(txtJueves.Text) < 0 || decimal.Parse(txtViernes.Text) < 0 || decimal.Parse(txtSabado.Text) < 0 || decimal.Parse(txtDomingo.Text) < 0)
                {
                    CargarHorario();
                    lblErrror.Text = "No Puede haber valores negativos";
                }
                else
                {
                    //Ingresar Entrada
                    HorarioE.idTrabajador = int.Parse((drpTrabajador.SelectedValue));
                    HorarioE.idSemana = int.Parse((drpSemana.SelectedValue));
                    HorarioE.IdTipoRegistroHora = 1;
                    if (!(string.IsNullOrEmpty(drpLunesE.SelectedValue))) HorarioE.Lunes = drpLunesE.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpMartesE.SelectedValue))) HorarioE.Martes = drpMartesE.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpMiercolesE.SelectedValue))) HorarioE.Miercoles = drpMiercolesE.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpJuevesE.SelectedValue))) HorarioE.Jueves = drpJuevesE.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpViernesE.SelectedValue))) HorarioE.Viernes = drpViernesE.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpSabadoE.SelectedValue))) HorarioE.Sabado = drpSabadoE.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpDomingoE.SelectedValue))) HorarioE.Domingo = drpDomingoE.SelectedValue;


                    //Horario = null;
                    //Ingresar Salida

                    HorarioS.idTrabajador = int.Parse((drpTrabajador.SelectedValue));
                    HorarioS.idSemana = int.Parse((drpSemana.SelectedValue));
                    HorarioS.IdTipoRegistroHora = 2;
                    if (!(string.IsNullOrEmpty(drpLunesS.SelectedValue))) HorarioS.Lunes = drpLunesS.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpMartesS.SelectedValue))) HorarioS.Martes = drpMartesS.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpMiercolesS.SelectedValue))) HorarioS.Miercoles = drpMiercolesS.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpJuevesS.SelectedValue))) HorarioS.Jueves = drpJuevesS.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpViernesS.SelectedValue))) HorarioS.Viernes = drpViernesS.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpSabadoS.SelectedValue))) HorarioS.Sabado = drpSabadoS.SelectedValue;
                    if (!(string.IsNullOrEmpty(drpDomingoS.SelectedValue))) HorarioS.Domingo = drpDomingoS.SelectedValue;


                    //Horario = null;
                    HorarioBL InsertarHorario = new HorarioBL();
                    string Mensaje = "";
                    Mensaje = InsertarHorario.InsertarHorario(HorarioE, int.Parse(drpTipo.SelectedValue.ToString()), decimal.Parse(txtTotal.Text.ToString()));
                    Mensaje = InsertarHorario.InsertarHorario(HorarioS, int.Parse(drpTipo.SelectedValue.ToString()), decimal.Parse(txtTotal.Text.ToString()));
                    CargarHorario();
                    lblErrror.Text = Mensaje;
                }
            }
            else
            {
                lblErrror.Text = "Seleccione la semana y el trabajador antes de registrar";
            }
            
        }
        catch (Exception ee)
        {
            lblErrror.Text = ee.Message;
        }
    }

    void cargarHR(DropDownList ddl)
    {
        for (int i = 0; i <= 24; i++)
        {
            if (i == 0)
            {
                ddl.Items.Add(new ListItem("", "0" + i.ToString() + ":00:00"));

            }
            else
            {
                if(i>1 && i<10)
                    ddl.Items.Add(new ListItem(i.ToString() + ":00:00","0" + i.ToString() + ":00:00"));
                else
                    ddl.Items.Add(new ListItem(i.ToString() + ":00:00", i.ToString() + ":00:00"));
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

            if (Entrada != null)
            {
                
                drpLunesE.SelectedValue = Entrada.Lunes == null ? "00:00:00": Convert.ToString(Entrada.Lunes);
                drpMartesE.SelectedValue = Entrada.Martes == null ? "00:00:00" : Convert.ToString(Entrada.Martes);
                drpMiercolesE.SelectedValue = Entrada.Miercoles == null ? "00:00:00" : Convert.ToString(Entrada.Miercoles);
                drpJuevesE.SelectedValue = Entrada.Jueves == null ? "00:00:00" : Convert.ToString(Entrada.Jueves);
                drpViernesE.SelectedValue = Entrada.Viernes == null ? "00:00:00" : Convert.ToString(Entrada.Viernes);
                drpSabadoE.SelectedValue = Entrada.Sabado == null ? "00:00:00" : Convert.ToString(Entrada.Sabado);
                drpDomingoE.SelectedValue = Entrada.Domingo == null ? "00:00:00" : Convert.ToString(Entrada.Domingo);

            }
      

            if (Salida != null)
            {
                drpLunesS.SelectedValue = Salida.Lunes == null ? "00:00:00" : Convert.ToString(Salida.Lunes);
                drpMartesS.SelectedValue = Salida.Martes == null ? "00:00:00" : Convert.ToString(Salida.Martes);
                drpMiercolesS.SelectedValue = Salida.Miercoles == null ? "00:00:00" : Convert.ToString(Salida.Miercoles);
                drpJuevesS.SelectedValue = Salida.Jueves == null ? "00:00:00" : Convert.ToString(Salida.Jueves);
                drpViernesS.SelectedValue = Salida.Viernes == null ? "00:00:00" : Convert.ToString(Salida.Viernes);
                drpSabadoS.SelectedValue = Salida.Sabado == null ? "00:00:00" : Convert.ToString(Salida.Sabado);
                drpDomingoS.SelectedValue = Salida.Domingo == null ? "00:00:00" : Convert.ToString(Salida.Domingo);
            }
                    

            if (Entrada.Lunes == null && Entrada.Martes == null && Entrada.Miercoles == null && Entrada.Jueves == null && Entrada.Viernes == null && Entrada.Sabado == null && Entrada.Domingo == null && Salida.Lunes == null && Salida.Martes == null && Salida.Miercoles == null && Salida.Jueves == null && Salida.Viernes == null && Salida.Sabado == null && Salida.Domingo == null)
            {
                lblErrror.Text = "No Hay Horas Registradas";
                //btnGrabar.Enabled = false;
                //btnImprimir.Enabled = false;
            }
            else
            {
                lblErrror.Text = "";
                btnGrabar.Enabled = true;
                btnImprimir.Enabled = true;
                SumarHoras();
            }
            Entrada = null;
            Salida = null;
        }
    }
}