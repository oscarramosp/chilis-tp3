using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLCargo;
using BLTipoTrabajador;
using BLTrabajador;
using BLCese;
using BECese;

public partial class Pages_CeseTrabajador : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack) {

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
            //Cargar Trabajadores Activos

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

            //Cargar Motivos
            
            ListItem liMotivo = new ListItem();
            liMotivo = new ListItem("Renuncia", "1");
            //if (idTipoOrden == 1) liTipo.Selected = true;
            drpMotivo.Items.Add(liMotivo);
            liMotivo = new ListItem("Despido", "2");
            //if (idTipoOrden == 2) liTipo.S
            drpMotivo.Items.Add(liMotivo);
            liMotivo = new ListItem("Abandono de Trabajo", "3");
            //if (idTipoOrden == 2) liTipo.S
            drpMotivo.Items.Add(liMotivo);
            liMotivo = new ListItem("Termino de Contrato", "2");
            //if (idTipoOrden == 2) liTipo.S
            drpMotivo.Items.Add(liMotivo);
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

            if (drpTrabajador.SelectedIndex != 0)
            {
                CeseBE Cese = new CeseBE();
                CeseBL oInsertarCese = new CeseBL();

                Cese.idtrabajador =int.Parse(drpTrabajador.SelectedValue);
                Cese.FechaCese=DateTime.Parse(txtFechaCese.Text);
                Cese.idMotivo = drpMotivo.SelectedValue;
                Cese.Observacion = txtMotivo.Text;
                Cese.FechaCreacion = DateTime.Today;

                if (oInsertarCese.InsertarCese(Cese) == true)
                {
                    Response.Redirect("CeseTrabajador.aspx");
                }
                else {
                    lblErrror.Text = "No se pudo completar Cese de Trabajador";
                }

            }
            else {

                lblErrror.Text = "Seleccionar Trabajador";
            }

        }

        catch(Exception ee) {

            lblErrror.Text = ee.Message;
        }
    
    }
}