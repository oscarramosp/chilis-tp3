using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BETrabajador;
using BETrabajadorPuesto;
using BLCargo;
using BLTipoTrabajador;
using BLTrabajador;
using BLTrabajadorPuesto;

using System.Data;

public partial class Pages_IngresarTrabajador : System.Web.UI.Page
{
    int MidTrabajador = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["idTrabajador"] != null)
        {
            MidTrabajador = int.Parse(Request.QueryString["idTrabajador"]);
        }

        if (!IsPostBack)
        {

            //Cargar Sexo
            ListItem liSexo = new ListItem();
            liSexo = new ListItem("M", "M");
            //if (idTipoOrden == 1) liTipo.Selected = true;
            drpSexo.Items.Add(liSexo);
            liSexo = new ListItem("F", "F");
            //if (idTipoOrden == 2) liTipo.Selected = true;
            drpSexo.Items.Add(liSexo);

            //Cargar Tipo Documento

            ListItem liTipoDoc = new ListItem();
            liTipoDoc = new ListItem("DNI", "1");
            //if (idTipoOrden == 1) liTipo.Selected = true;
            drpDocumento.Items.Add(liTipoDoc);
            liTipoDoc = new ListItem("Carnet de Extranjeria", "2");
            //if (idTipoOrden == 2) liTipo.S
            drpDocumento.Items.Add(liTipoDoc);
        
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

            foreach (DataRow row in oTipoTrabajador.getTipoTrabajador().Rows)
            {
                int lidTipoTrab = int.Parse(row["id"].ToString());
                string lTipoTrab = row["Descripcin"].ToString();
                ListItem liTipoTrab = new ListItem();
                liTipoTrab.Value = lidTipoTrab.ToString();
                liTipoTrab.Text = lTipoTrab;

                drpTipoTrabajador.Items.Add(liTipoTrab);
            }

            //Listar Trabajador si hace Postback
            if (MidTrabajador > 0)
            {

                TrabajadorBL oTrab = new TrabajadorBL();

                foreach (DataRow row in oTrab.getTrabajador(MidTrabajador).Rows)
                {

                    txtNombre.Text = row["Nombre"].ToString();
                    txtPaterno.Text = row["ApellidoPaterno"].ToString();
                    txtMaterno.Text = row["ApellidoMaterno"].ToString();
                    txtCorreo.Text = row["Correo"].ToString();
                    txtDir.Text = row["Direccion"].ToString();
                    txtNumero.Text = row["NumeroDocumento"].ToString();
                    txtFecNac.Text = (DateTime.Parse(row["FechaNacimiento"].ToString())).ToShortDateString();
                    txtTelefono.Text = row["Telefono"].ToString();
                    drpSexo.SelectedValue = row["Sexo"].ToString();
                    drpCargo.SelectedValue = row["IdCargo"].ToString();
                    drpTipoTrabajador.SelectedValue = row["IdTipoTrabjador"].ToString();
                    drpDocumento.SelectedValue = row["TipoDocumento"].ToString();
                    txtInicio.Text = DateTime.Parse(row["FechaInicio"].ToString()).ToShortDateString();
                    txtFin.Text = DateTime.Parse(row["FechaFin"].ToString()).ToShortDateString();
                }
                oTrab = null;

                TrabajadorPuestoBL oPuestos = new TrabajadorPuestoBL();
                gvResultado.DataSource= oPuestos.getTrabajadoresPuestos(MidTrabajador);
                gvResultado.DataBind();
            }
        }

    }

    public void btnGrabar_Click(object sender, EventArgs e)
    {
        try {
            if (MidTrabajador == 0)
            {
                int idTrabajador = 0;
                TrabajadorBE Trabajador = new TrabajadorBE();

                Trabajador.Nombre = txtNombre.Text;
                Trabajador.Paterno = txtPaterno.Text;
                Trabajador.Materno = txtMaterno.Text;
                Trabajador.FechaNacimiento = DateTime.Parse(txtFecNac.Text);
                Trabajador.TipoDocumento = drpDocumento.SelectedValue;
                Trabajador.NumeroDocumento = txtNumero.Text;
                Trabajador.Correo = txtCorreo.Text;
                Trabajador.Direccion = txtDir.Text;
                Trabajador.Telefono = txtTelefono.Text;
                Trabajador.Sexo = drpSexo.SelectedValue;
                Trabajador.Activo = "0";
                Trabajador.IdCargo = int.Parse(drpCargo.SelectedValue);
                Trabajador.IdTipoTrabjador = int.Parse(drpTipoTrabajador.SelectedValue.ToString());

                TrabajadorBL oLog = new TrabajadorBL();
                idTrabajador = oLog.InsertarTrabajador(Trabajador);
                oLog = null;
                Trabajador = null;


                TrabajadorPuestoBE Puestos = new TrabajadorPuestoBE();
                Puestos.idTrabajador = idTrabajador;
                Puestos.idCargo = int.Parse(drpCargo.SelectedValue);
                Puestos.idTipoTrabajador = int.Parse(drpTipoTrabajador.SelectedValue);
                Puestos.FechaInicio = DateTime.Parse(txtInicio.Text);
                Puestos.FechaFin = DateTime.Parse(txtFin.Text);
                Puestos.Activo = "0";

                TrabajadorPuestoBL oPuesto = new TrabajadorPuestoBL();
                oPuesto.InsertarTrabajador(Puestos);
                oPuesto = null;
                Puestos = null;

                Response.Redirect("IngresarTrabajador.aspx?idTrabajador=" + idTrabajador);
            }
            else if (MidTrabajador > 0) {
                TrabajadorBE Trabajador = new TrabajadorBE();
                Trabajador.idTrabajador = MidTrabajador;
                Trabajador.Nombre = txtNombre.Text;
                Trabajador.Paterno = txtPaterno.Text;
                Trabajador.Materno = txtMaterno.Text;
                Trabajador.FechaNacimiento = DateTime.Parse(txtFecNac.Text);
                Trabajador.TipoDocumento = drpDocumento.SelectedValue;
                Trabajador.NumeroDocumento = txtNumero.Text;
                Trabajador.Correo = txtCorreo.Text;
                Trabajador.Direccion = txtDir.Text;
                Trabajador.Telefono = txtTelefono.Text;
                Trabajador.Sexo = drpSexo.SelectedValue;
                Trabajador.Activo = "0";
                Trabajador.IdCargo = int.Parse(drpCargo.SelectedValue);
                Trabajador.IdTipoTrabjador = int.Parse(drpTipoTrabajador.SelectedValue.ToString());

                TrabajadorBL oLog = new TrabajadorBL();
                oLog.ActualizarTrabajador(Trabajador);
                oLog = null;
                Trabajador = null;

                TrabajadorPuestoBE Puestos = new TrabajadorPuestoBE();
                Puestos.idTrabajador = MidTrabajador;
                Puestos.idCargo = int.Parse(drpCargo.SelectedValue);
                Puestos.idTipoTrabajador = int.Parse(drpTipoTrabajador.SelectedValue);
                Puestos.FechaInicio = DateTime.Parse(txtInicio.Text);
                Puestos.FechaFin = DateTime.Parse(txtFin.Text);
                Puestos.Activo = "0";

                TrabajadorPuestoBL oPuesto = new TrabajadorPuestoBL();
                oPuesto.InsertarTrabajador(Puestos);
                oPuesto = null;
                Puestos = null;

                Response.Redirect("IngresarTrabajador.aspx?idTrabajador=" + MidTrabajador);
            
            
            }
        
        }

        catch (Exception ee){

            lblErrror.Text = ee.Message;
        
        }
    }

    protected void gvResultado_RowEditing(object sender, GridViewEditEventArgs e)
    {
        this.gvResultado.EditIndex = e.NewEditIndex;
        TrabajadorPuestoBL oPuestos = new TrabajadorPuestoBL();
        gvResultado.DataSource = oPuestos.getTrabajadoresPuestos(MidTrabajador);
        gvResultado.DataBind();
    }
    protected void gvResultado_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        this.gvResultado.EditIndex = -1;
        TrabajadorPuestoBL oPuestos = new TrabajadorPuestoBL();
        gvResultado.DataSource = oPuestos.getTrabajadoresPuestos(MidTrabajador);
        gvResultado.DataBind();
    }
    protected void gvResultado_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TrabajadorPuestoBE Puesto = new TrabajadorPuestoBE();

        Label txtNumero = (Label)gvResultado.Rows[e.RowIndex].FindControl("lblCodigo");
        TextBox txtInicio = (TextBox)gvResultado.Rows[e.RowIndex].FindControl("txtFechaInicio");
        TextBox txtFin = (TextBox)gvResultado.Rows[e.RowIndex].FindControl("txtFechaFin");
        
        Puesto.codigo=int.Parse(txtNumero.Text);
        Puesto.FechaInicio= DateTime.Parse(txtInicio.Text);
        Puesto.FechaFin= DateTime.Parse(txtFin.Text);
        
        TrabajadorPuestoBL oPuestos = new TrabajadorPuestoBL();
        oPuestos.ActualizarFechasTrabajadorPuesto(Puesto);

        Response.Redirect("IngresarTrabajador.aspx?idTrabajador=" + MidTrabajador);
        
        //this.ActualizarListaItems(txtNumero.Text.ToString(), long.Parse(txtCantidad.Text), txtUnidad.Text, txtParte.Text, txtDescripcion.Text, decimal.Parse(txtPrecio.Text));//chkAlquiler.Checked);

        //this.gvElementos.EditIndex = -1;
        //this.gvElementos.DataSource = this.ObtenerListaItem();
        //this.gvElementos.DataBind();

     
      
      
    }


    
}