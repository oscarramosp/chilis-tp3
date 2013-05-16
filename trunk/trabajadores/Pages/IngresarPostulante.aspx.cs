using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BEPostulante;
using BEFormacion;
using BEHabilidad;
using BEExperiencia;
using BLPostulante;
using BLNacionalidad;
using BLCargo;
using BLDisponibilidad;
using BLNivel;
using BLIdioma;
using BLSituacion;
using BLFormacion;
using BLHabilidad;
using BLExperiencia;

using System.Data;



public partial class Pages_IngresarPostulante : System.Web.UI.Page
{
    private const string FORMACION = "Formacion";
    private const string HABILIDAD = "Habilidad";
    private const string EXPERIENCIA = "Experiencia";
    int MidPostulante = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["idPostulante"] != null)
        {
            MidPostulante = int.Parse(Request.QueryString["idPostulante"]);

        }

       

        if (!IsPostBack)
        {
            CrearTablaFormacion();
            CrearTablaExperiencia();
            CrearTablaHabilidad();

            //Cargar Sexo
            ListItem liSexo = new ListItem();
            liSexo = new ListItem("M", "M");
            //if (idTipoOrden == 1) liTipo.Selected = true;
            drpSexo.Items.Add(liSexo);
            liSexo = new ListItem("F", "F");
            //if (idTipoOrden == 2) liTipo.Selected = true;
            drpSexo.Items.Add(liSexo);

            NacionalidadBL oNac = new NacionalidadBL();
         
              foreach (DataRow row in oNac.GetNacionalidad().Rows)
              {
                int lidNac = int.Parse(row["idNacionalidad"].ToString());
                string lNac = row["Descripcion"].ToString();
                ListItem liNac = new ListItem();
                liNac.Value = lidNac.ToString();
                liNac.Text = lNac;

                drpNac.Items.Add(liNac);
              }

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

              DisponibilidadBL oDispo = new DisponibilidadBL();

              foreach (DataRow row in oDispo.getDisponibilidad().Rows)
              {
                  int lidDis = int.Parse(row["idDisponibilidad"].ToString());
                  string lDis = row["Descripcion"].ToString();
                  ListItem liDis = new ListItem();
                  liDis.Value = lidDis.ToString();
                  liDis.Text = lDis;

                  drpDisponibilidad.Items.Add(liDis);
              }

        }


        if (MidPostulante > 0 && !IsPostBack)
        {

            tpFormacion.Visible = true;
            PostulanteBL oPos = new PostulanteBL();

            foreach (DataRow row in oPos.getPostulante(MidPostulante).Rows)
            {

                txtNombre.Text = row["Nombre"].ToString();
                txtPaterno.Text = row["ApellidoPaterno"].ToString();
                txtMaterno.Text = row["ApellidoMaterno"].ToString();
                txtCorreo.Text = row["Correo"].ToString();
                txtDir.Text = row["Direccion"].ToString();
                txtDNI.Text = row["DNI"].ToString();
                txtFecNac.Text = (DateTime.Parse(row["FechaNacimiento"].ToString())).ToShortDateString();
                txtTelefono.Text = row["Telefono"].ToString();
                drpSexo.SelectedValue = row["Sexo"].ToString();
                drpCargo.SelectedValue = row["IdCargo"].ToString();
                drpDisponibilidad.SelectedValue = row["IdDisponibilidad"].ToString();
                drpNac.SelectedValue = row["IdNacionalidad"].ToString();
            }
            oPos = null;

            ExperienciaBL oExp = new ExperienciaBL();
            gvExperiencia.DataSource = oExp.getExperiencia(MidPostulante);
            gvExperiencia.DataBind();
            Session[EXPERIENCIA] = oExp.getExperiencia(MidPostulante);

            HabilidadBL oHab = new HabilidadBL();
            gvHabilidad.DataSource = oHab.getHabilidad(MidPostulante);
            gvHabilidad.DataBind();
            Session[HABILIDAD] = oHab.getHabilidad(MidPostulante);

            FormacionBL oFor = new FormacionBL();
            gvFormacion.DataSource = oFor.getFormacion(MidPostulante);
            gvFormacion.DataBind();
            Session[FORMACION] = oFor.getFormacion(MidPostulante);
        }


    }


    public void btnSiguiente_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime FechaNac;
            FechaNac = DateTime.Parse(txtFecNac.Text.ToString());
            int AnioActual = int.Parse(DateTime.Now.Year.ToString());
            int AnioFechaNac = int.Parse(FechaNac.Year.ToString());

            if ((AnioActual - AnioFechaNac) > 25)
            {
                lblErrror.Text = "No puede tener mas de 25 años";
            }

            else if (FechaNac > DateTime.Now)
            {
                lblErrror.Text = "La fecha no puede ser mayor a la actual";
            }
            else
            {
                tpFormacion.Visible = true;
                tbcPostulante.ActiveTabIndex = 1;
            }
        }
        catch (Exception ee) {

            lblErrror.Text = ee.Message;
        }
        
        
    }
    public void btnGrabar_Click(object sender, EventArgs e)
    {

        try
        {

            if (gvFormacion.Rows.Count == 0)
            {
                lblErrror.Text = "Debe Ingresar al menos un registro de Formacion";
            }

            else
            {
                if (MidPostulante == 0)
                {

                    int idPostulante = 0;
                    PostulanteBL oLog = new PostulanteBL();
                    PostulanteBE Postulante = new PostulanteBE();

                    Postulante.Nombre = txtNombre.Text.ToUpper();
                    Postulante.Paterno = txtPaterno.Text.ToUpper();
                    Postulante.Materno = txtMaterno.Text.ToUpper();
                    Postulante.DNI = txtDNI.Text;
                    Postulante.FechaNacimiento = DateTime.Parse(txtFecNac.Text);
                    Postulante.Sexo = drpSexo.SelectedValue;
                    Postulante.IdNacionalidad = int.Parse(drpNac.SelectedValue);
                    Postulante.Direccion = txtDir.Text;
                    Postulante.Telefono = txtTelefono.Text;
                    Postulante.Correo = txtCorreo.Text;
                    Postulante.IdCargo = int.Parse(drpCargo.SelectedValue);
                    Postulante.IdDisponibilidad = int.Parse(drpDisponibilidad.SelectedValue);

                    idPostulante = oLog.InsertarPostulante(Postulante);

                    //Añado formacion profesional
                    foreach (GridViewRow item in this.gvFormacion.Rows)
                    {

                        int idNivelFormacion = 0;
                        int idSituacion = 0;

                        DropDownList ddlNivel = (DropDownList)item.FindControl("ddlNivel");
                        if (ddlNivel != null)
                        {
                            idNivelFormacion = int.Parse(ddlNivel.SelectedValue);
                        }

                        DropDownList ddlSituacion = (DropDownList)item.FindControl("ddlSituacion");
                        if (ddlSituacion != null)
                        {
                            idSituacion = int.Parse(ddlSituacion.SelectedValue);
                        }

                        TextBox txtTitulo = (TextBox)item.FindControl("txtTitulo");
                        TextBox txtAnioFormado = (TextBox)item.FindControl("txtAnioFormado");
                        TextBox txtFechaTitulacion = (TextBox)item.FindControl("txtFechaTitulacion");

                        //Ahi llegó muy tarde
                        FormacionBE formacion = new FormacionBE();
                        formacion.IdPostulante = idPostulante;
                        formacion.IdNivelFormacion = idNivelFormacion;
                        formacion.Titulo = txtTitulo.Text.Trim();
                        formacion.FechaTitulacion = DateTime.Parse(txtFechaTitulacion.Text);
                        formacion.IdSituacionFormacion = idSituacion;
                        formacion.AnioFormado = int.Parse(txtAnioFormado.Text);

                        FormacionBL oFormacion = new FormacionBL();
                        oFormacion.InsertarFormacion(formacion);
                        oFormacion = null;
                    }

                    //Añado habilidad linguistica
                    foreach (GridViewRow item in this.gvHabilidad.Rows)
                    {
                        DropDownList ddlIdioma = (DropDownList)item.FindControl("ddlIdioma");
                        DropDownList ddlLectura = (DropDownList)item.FindControl("ddlLectura");
                        DropDownList ddlEscritura = (DropDownList)item.FindControl("ddlEscritura");
                        DropDownList ddlHablado = (DropDownList)item.FindControl("ddlHablado");

                        int idIdioma = int.Parse(ddlIdioma.SelectedValue);

                        TextBox txtTitulo = (TextBox)item.FindControl("txtTitulo");
                        TextBox txtAnioFormado = (TextBox)item.FindControl("txtAnioFormado");
                        TextBox txtFechaTitulacion = (TextBox)item.FindControl("txtFechaTitulacion");

                        HabilidadBE habilidad = new HabilidadBE();
                        habilidad.IdPostulante = idPostulante;
                        habilidad.IdIdioma = int.Parse(ddlIdioma.SelectedValue);
                        habilidad.Lectura = ddlLectura.SelectedValue;
                        habilidad.Escritura = ddlEscritura.SelectedValue;
                        habilidad.Hablado = ddlHablado.SelectedValue;

                        HabilidadBL oHabilidad = new HabilidadBL();
                        oHabilidad.InsertarHabilidad(habilidad);
                        oHabilidad = null;
                    }

                    //Añado Experiencia profesional
                    foreach (GridViewRow item in this.gvExperiencia.Rows)
                    {
                        DropDownList ddlCargo = (DropDownList)item.FindControl("ddlCargo");

                        TextBox txtNombreEmpresa = (TextBox)item.FindControl("txtNombreEmpresa");
                        TextBox txtFechaInicio = (TextBox)item.FindControl("txtFechaInicio");
                        TextBox txtFechaFinal = (TextBox)item.FindControl("txtFechaFinal");
                        TextBox txtResponsabilidad = (TextBox)item.FindControl("txtResponsabilidad");

                        ExperienciaBE experiencia = new ExperienciaBE();
                        experiencia.IdPostulante = idPostulante;
                        experiencia.NombreEmpresa = txtNombreEmpresa.Text;
                        experiencia.FechaInicio = DateTime.Parse(txtFechaInicio.Text);
                        experiencia.FechaFinal = DateTime.Parse(txtFechaFinal.Text);
                        experiencia.IdCargo = int.Parse(ddlCargo.SelectedValue);
                        experiencia.Responsabilidad = txtResponsabilidad.Text;

                        ExperienciaBL oExperiencia = new ExperienciaBL();
                        oExperiencia.InsertarExperiencia(experiencia);
                        experiencia = null;
                    }

                    Response.Redirect("IngresarPostulante.aspx?idPostulante=" + idPostulante);
                }
                else if (MidPostulante > 0)
                {
                    
                    PostulanteBL oLog = new PostulanteBL();
                    PostulanteBE Postulante = new PostulanteBE();

                    Postulante.idPostulante = MidPostulante;
                    Postulante.Nombre = txtNombre.Text.ToUpper();
                    Postulante.Paterno = txtPaterno.Text.ToUpper();
                    Postulante.Materno = txtMaterno.Text.ToUpper();
                    Postulante.DNI = txtDNI.Text;
                    Postulante.FechaNacimiento = DateTime.Parse(txtFecNac.Text);
                    Postulante.Sexo = drpSexo.SelectedValue;
                    Postulante.IdNacionalidad = int.Parse(drpNac.SelectedValue); 
                    Postulante.Direccion = txtDir.Text;
                    Postulante.Telefono = txtTelefono.Text;
                    Postulante.Correo = txtCorreo.Text;
                    Postulante.IdCargo = int.Parse(drpCargo.SelectedValue);
                    Postulante.IdDisponibilidad = int.Parse(drpDisponibilidad.SelectedValue);

                    oLog.ActualizarPostulante(Postulante);

                    FormacionBL oEliminarFormacion = new FormacionBL();
                    oEliminarFormacion.EliminarFormacion(MidPostulante, 0);
                    HabilidadBL oEliminarHabilidad = new HabilidadBL();
                    oEliminarHabilidad.EliminarHabilidad(MidPostulante, 0);
                    ExperienciaBL oEliminarExperiencia = new ExperienciaBL();
                    oEliminarExperiencia.EliminarExperiencia(MidPostulante, 0);

                    foreach (GridViewRow item in this.gvFormacion.Rows)
                    {
                        DropDownList ddlNivel = (DropDownList)item.FindControl("ddlNivel");
                        DropDownList ddlSituacion = (DropDownList)item.FindControl("ddlSituacion");
                        TextBox txtTitulo = (TextBox)item.FindControl("txtTitulo");
                        TextBox txtAnioFormado = (TextBox)item.FindControl("txtAnioFormado");
                        TextBox txtFechaTitulacion = (TextBox)item.FindControl("txtFechaTitulacion");

                        int idNivelFormacion = 0;
                        int idSituacion = 0;

                        if (ddlNivel != null) idNivelFormacion = int.Parse(ddlNivel.SelectedValue);
                        if (ddlSituacion != null) idSituacion = int.Parse(ddlSituacion.SelectedValue);

                        FormacionBE oFormacion = new FormacionBE();
                        oFormacion.IdPostulante = MidPostulante;
                        oFormacion.IdNivelFormacion = idNivelFormacion;
                        oFormacion.Titulo = txtTitulo.Text;
                        oFormacion.FechaTitulacion = DateTime.Parse(txtFechaTitulacion.Text);
                        oFormacion.IdSituacionFormacion = idSituacion;
                        oFormacion.AnioFormado = int.Parse(txtAnioFormado.Text);

                        FormacionBL oActFormacion = new FormacionBL();
                        oActFormacion.ActualizarFormacion(oFormacion);

                    }

                    foreach (GridViewRow item in this.gvHabilidad.Rows)
                    {
                        DropDownList ddlIdioma = (DropDownList)item.FindControl("ddlIdioma");
                        DropDownList ddlLectura = (DropDownList)item.FindControl("ddlLectura");
                        DropDownList ddlEscritura = (DropDownList)item.FindControl("ddlEscritura");
                        DropDownList ddlHablado = (DropDownList)item.FindControl("ddlHablado");

                        int idIdioma = int.Parse(ddlIdioma.SelectedValue);

                        HabilidadBE oHab = new HabilidadBE();
                        oHab.IdPostulante=MidPostulante;
                        oHab.IdIdioma = idIdioma;
                        oHab.Lectura = ddlLectura.SelectedValue;
                        oHab.Escritura = ddlEscritura.SelectedValue;
                        oHab.Hablado = ddlHablado.SelectedValue;

                        HabilidadBL oActHabilidad = new HabilidadBL();
                        oActHabilidad.ActualizarHabilidad(oHab);
                        
                    }

                    foreach (GridViewRow item in this.gvExperiencia.Rows)
                    {
                        DropDownList ddlCargo1 = (DropDownList)item.FindControl("ddlCargo");
                        TextBox txtNombreEmpresa = (TextBox)item.FindControl("txtNombreEmpresa");
                        TextBox txtFechaInicio = (TextBox)item.FindControl("txtFechaInicio");
                        TextBox txtFechaFinal = (TextBox)item.FindControl("txtFechaFinal");
                        TextBox txtResponsabilidad = (TextBox)item.FindControl("txtResponsabilidad");

                        ExperienciaBE oExp = new ExperienciaBE();
                        oExp.IdPostulante = MidPostulante;
                        oExp.NombreEmpresa = txtNombreEmpresa.Text;
                        oExp.FechaInicio=DateTime.Parse(txtFechaInicio.Text);
                        oExp.FechaFinal=DateTime.Parse(txtFechaFinal.Text);
                        oExp.IdCargo=int.Parse(ddlCargo1.SelectedValue);
                        oExp.Responsabilidad=txtResponsabilidad.Text;

                        ExperienciaBL oActExp = new ExperienciaBL();
                        oActExp.ActualizarExperiencia(oExp);
                        
                    }

                    Response.Redirect("IngresarPostulante.aspx?idPostulante=" + MidPostulante);
                
                }
            }

        }
        catch (Exception ex)
        {
            lblErrror.Text = ex.Message;
        }



    }

    protected void gvHabilidad_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlIdioma = (DropDownList)e.Row.FindControl("ddlIdioma");
                DropDownList ddlLectura = (DropDownList)e.Row.FindControl("ddlLectura");
                DropDownList ddlEscritura = (DropDownList)e.Row.FindControl("ddlEscritura");
                DropDownList ddlHablado = (DropDownList)e.Row.FindControl("ddlHablado");


                IdiomaBL ocargo = new IdiomaBL();

                foreach (DataRow row in ocargo.getIdioma().Rows)
                {
                    int lidCargo = int.Parse(row["idIdioma"].ToString());
                    string lCargo = row["Descripcion"].ToString();
                    ListItem liCargo = new ListItem();
                    liCargo.Value = lidCargo.ToString();
                    liCargo.Text = lCargo;

                    ddlIdioma.Items.Add(liCargo);
                }

                ddlLectura.Items.Add(new ListItem("Seleccionar", "0"));
                ddlLectura.Items.Add(new ListItem("Básico", "B"));
                ddlLectura.Items.Add(new ListItem("Intermedio", "I"));
                ddlLectura.Items.Add(new ListItem("Avanzado", "A"));

                ddlEscritura.Items.Add(new ListItem("Seleccionar", "0"));
                ddlEscritura.Items.Add(new ListItem("Básico", "B"));
                ddlEscritura.Items.Add(new ListItem("Intermedio", "I"));
                ddlEscritura.Items.Add(new ListItem("Avanzado", "A"));

                ddlHablado.Items.Add(new ListItem("Seleccionar", "0"));
                ddlHablado.Items.Add(new ListItem("Básico", "B"));
                ddlHablado.Items.Add(new ListItem("Intermedio", "I"));
                ddlHablado.Items.Add(new ListItem("Avanzado", "A"));

                DataRowView row1 = (DataRowView)e.Row.DataItem;
                if (row1["IdIdioma"].ToString().CompareTo("0") != 0) ddlIdioma.SelectedValue = row1["IdIdioma"].ToString();
                if (row1["Lectura"].ToString().CompareTo("0") != 0) ddlLectura.SelectedValue = row1["Lectura"].ToString();
                if (row1["Escritura"].ToString().CompareTo("0") != 0) ddlEscritura.SelectedValue = row1["Escritura"].ToString();
                if (row1["Hablado"].ToString().CompareTo("0") != 0) ddlHablado.SelectedValue = row1["Hablado"].ToString();


            }
        }
        catch (Exception)
        {

            throw;
        }
    }
    protected void gvExperiencia_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlCargo = (DropDownList)e.Row.FindControl("ddlCargo");

                CargoBL ocargo = new CargoBL();

                foreach (DataRow row in ocargo.getCargo().Rows)
                {
                    int lidCargo = int.Parse(row["idCargo"].ToString());
                    string lCargo = row["Descripcion"].ToString();
                    ListItem liCargo = new ListItem();
                    liCargo.Value = lidCargo.ToString();
                    liCargo.Text = lCargo;

                    ddlCargo.Items.Add(liCargo);
                }
            }
        }
        catch (Exception)
        {

            throw;
        }
    }
    protected void gvFormacion_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlNivel = (DropDownList)e.Row.FindControl("ddlNivel");
                DropDownList ddlSituacion = (DropDownList)e.Row.FindControl("ddlSituacion");
                
                NivelBL oNivel = new NivelBL();

                foreach (DataRow row in oNivel.getNivel().Rows)
                {
                    int lidCargo = int.Parse(row["idNivelFormacion"].ToString());
                    string lCargo = row["Descripcion"].ToString();
                    ListItem liCargo = new ListItem();
                    liCargo.Value = lidCargo.ToString();
                    liCargo.Text = lCargo;

                    ddlNivel.Items.Add(liCargo);
                }

                SituacionBL oSitu = new SituacionBL();

                foreach (DataRow row in oSitu.getSituacion().Rows)
                {
                    int lidCargo = int.Parse(row["idSituacionFormacion"].ToString());
                    string lCargo = row["Descripcion"].ToString();
                    ListItem liCargo = new ListItem();
                    liCargo.Value = lidCargo.ToString();
                    liCargo.Text = lCargo;

                    ddlSituacion.Items.Add(liCargo);
                }
  
            }

        }
        catch (Exception ex)
        {

            lblErrror.Text=ex.Message;
        }
    }
    private void CrearTablaHabilidad()
    {
    
        try
        {
            DataTable data = new DataTable();
            data.Columns.Add("IdHabilidadLinguistica", typeof(int));
            data.Columns["IdHabilidadLinguistica"].AutoIncrement = true;

            data.Columns.Add("IdIdioma", typeof(int));
            data.Columns.Add("Lectura", typeof(string));
            data.Columns.Add("Escritura", typeof(string));
            data.Columns.Add("Hablado", typeof(string));

            DataColumn[] columns = new DataColumn[1];
            columns[0] = data.Columns["IdHabilidadLinguistica"];
            data.PrimaryKey = columns;

            Session[HABILIDAD] = data;
            this.gvHabilidad.DataSource = data;
            this.gvHabilidad.DataBind();

            //Crear Primera Fila

            data = (DataTable)Session[HABILIDAD];


            if (this.gvHabilidad.Rows.Count > 0)
            {
                data.Clear();

                foreach (GridViewRow item in this.gvHabilidad.Rows)
                {
                    DropDownList ddlIdioma = (DropDownList)item.FindControl("ddlIdioma");
                    DropDownList ddlLectura = (DropDownList)item.FindControl("ddlLectura");
                    DropDownList ddlEscritura = (DropDownList)item.FindControl("ddlEscritura");
                    DropDownList ddlHablado = (DropDownList)item.FindControl("ddlHablado");

                    DataRow dataRow = data.NewRow();
                    dataRow["IdIdioma"] = int.Parse(ddlIdioma.SelectedValue);
                    dataRow["Lectura"] = ddlLectura.SelectedValue;
                    dataRow["Escritura"] = ddlEscritura.SelectedValue;
                    dataRow["Hablado"] = ddlHablado.SelectedValue;

                    data.Rows.Add(dataRow);
                }
            }

            DataRow row = data.NewRow();
            row["IdIdioma"] = "0";
            row["Lectura"] = "0";
            row["Escritura"] = "0";
            row["Hablado"] = "0";

            data.Rows.Add(row);
            Session[HABILIDAD] = data;

            this.gvHabilidad.DataSource = data;
            this.gvHabilidad.DataBind();




        }
        catch (Exception ee)
        {

            throw ee;
        }

   }

    private void CrearTablaExperiencia()
    {
        try
        {
            DataTable data = new DataTable();
            data.Columns.Add("IdExperiencia", typeof(int));
            data.Columns["IdExperiencia"].AutoIncrement = true;

            data.Columns.Add("NombreEmpresa", typeof(string));
            data.Columns.Add("FechaInicio", typeof(string));
            data.Columns.Add("FechaFinal", typeof(string));
            data.Columns.Add("IdCargo", typeof(int));
            data.Columns.Add("Responsabilidad", typeof(string));

            DataColumn[] columns = new DataColumn[1];
            columns[0] = data.Columns["IdExperiencia"];
            data.PrimaryKey = columns;

            Session[EXPERIENCIA] = data;
            this.gvExperiencia.DataSource = data;
            this.gvExperiencia.DataBind();

            //Crear datagrid con primera fila

            data = (DataTable)Session[EXPERIENCIA];


            if (this.gvExperiencia.Rows.Count > 0)
            {
                data.Clear();

                foreach (GridViewRow item in this.gvExperiencia.Rows)
                {
                    TextBox txtNombreEmpresa = (TextBox)item.FindControl("txtNombreEmpresa");
                    TextBox txtFechaInicio = (TextBox)item.FindControl("txtFechaInicio");
                    TextBox txtFechaFinal = (TextBox)item.FindControl("txtFechaFinal");
                    DropDownList ddlCargo = (DropDownList)item.FindControl("ddlCargo");
                    TextBox txtResponsabilidad = (TextBox)item.FindControl("txtResponsabilidad");

                    DataRow dataRow = data.NewRow();
                    dataRow["NombreEmpresa"] = txtNombreEmpresa.Text;
                    dataRow["FechaInicio"] = txtFechaInicio.Text;
                    dataRow["FechaFinal"] = txtFechaFinal.Text;
                    dataRow["IdCargo"] = ddlCargo.SelectedValue;
                    dataRow["Responsabilidad"] = txtResponsabilidad.Text;

                    data.Rows.Add(dataRow);
                }
            }

            DataRow row = data.NewRow();
            row["NombreEmpresa"] = string.Empty;
            row["IdCargo"] = 0;
            row["Responsabilidad"] = string.Empty;

            data.Rows.Add(row);
            Session[EXPERIENCIA] = data;

            this.gvExperiencia.DataSource = data;
            this.gvExperiencia.DataBind();
        }
        catch (Exception)
        {

            throw;
        }
    }
    private void CrearTablaFormacion()
    {
        try
        {
            DataTable data = new DataTable();
            data.Columns.Add("IdFormacion", typeof(int));
            data.Columns["IdFormacion"].AutoIncrement = true;

            data.Columns.Add("IdNivelFormacion", typeof(int));
            data.Columns.Add("Titulo", typeof(string));
            data.Columns.Add("FechaTitulacion", typeof(string));
            data.Columns.Add("IdSituacionFormacion", typeof(int));
            data.Columns.Add("AnioFormado", typeof(int));

            DataColumn[] columns = new DataColumn[1];
            columns[0] = data.Columns["IdFormacion"];
            data.PrimaryKey = columns;

            Session[FORMACION] = data;
            this.gvFormacion.DataSource = data;
            this.gvFormacion.DataBind();

            //Crear primera fila del GridView

            data = (DataTable)Session[FORMACION];


            if (this.gvFormacion.Rows.Count > 0)
            {
                data.Clear();

                foreach (GridViewRow item in this.gvFormacion.Rows)
                {
                    DropDownList ddlNivel = (DropDownList)item.FindControl("ddlNivel");
                    int idNivelFormacion = 0;
                    int idSituacion = 0;

                    if (ddlNivel != null)
                    {
                        idNivelFormacion = int.Parse(ddlNivel.SelectedValue);
                    }

                    DropDownList ddlSituacion = (DropDownList)item.FindControl("ddlSituacion");
                    if (ddlSituacion != null)
                    {
                        idSituacion = int.Parse(ddlSituacion.SelectedValue);
                    }

                    TextBox txtTitulo = (TextBox)item.FindControl("txtTitulo");
                    TextBox txtAnioFormado = (TextBox)item.FindControl("txtAnioFormado");
                    TextBox txtFechaTitulacion = (TextBox)item.FindControl("txtFechaTitulacion");

                    DataRow dataRow = data.NewRow();
                    dataRow["IdNivelFormacion"] = idNivelFormacion;
                    dataRow["Titulo"] = txtTitulo.Text;
                    dataRow["IdSituacionFormacion"] = idSituacion;

                    if (txtFechaTitulacion.Text.Length > 0)
                    {
                        dataRow["FechaTitulacion"] = txtFechaTitulacion.Text;
                    }

                    if (txtAnioFormado.Text.Length > 0)
                    {
                        dataRow["AnioFormado"] = int.Parse(txtAnioFormado.Text);
                    }

                    data.Rows.Add(dataRow);
                }
            }


            DataRow row = data.NewRow();
            row["IdNivelFormacion"] = 0;
            row["Titulo"] = string.Empty;
            row["IdSituacionFormacion"] = 0;
            row["AnioFormado"] = 0;

            data.Rows.Add(row);
            Session[FORMACION] = data;

            this.gvFormacion.DataSource = data;
            this.gvFormacion.DataBind();

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void btnAddFormacion_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable data = (DataTable)Session[FORMACION];


            if (this.gvFormacion.Rows.Count > 0)
            {
                data.Clear();

                foreach (GridViewRow item in this.gvFormacion.Rows)
                {
                    DropDownList ddlNivel = (DropDownList)item.FindControl("ddlNivel");
                    int idNivelFormacion = 0;
                    int idSituacion = 0;

                    if (ddlNivel != null)
                    {
                        idNivelFormacion = int.Parse(ddlNivel.SelectedValue);
                    }

                    DropDownList ddlSituacion = (DropDownList)item.FindControl("ddlSituacion");
                    if (ddlSituacion != null)
                    {
                        idSituacion = int.Parse(ddlSituacion.SelectedValue);
                    }

                    TextBox txtTitulo = (TextBox)item.FindControl("txtTitulo");
                    TextBox txtAnioFormado = (TextBox)item.FindControl("txtAnioFormado");
                    TextBox txtFechaTitulacion = (TextBox)item.FindControl("txtFechaTitulacion");

                    DataRow dataRow = data.NewRow();
                    dataRow["IdNivelFormacion"] = idNivelFormacion;
                    dataRow["Titulo"] = txtTitulo.Text;
                    dataRow["IdSituacionFormacion"] = idSituacion;

                    if (txtFechaTitulacion.Text.Length > 0)
                    {
                        dataRow["FechaTitulacion"] = txtFechaTitulacion.Text;
                    }

                    if (txtAnioFormado.Text.Length > 0)
                    {
                        dataRow["AnioFormado"] = int.Parse(txtAnioFormado.Text);
                    }

                    data.Rows.Add(dataRow);
                }
            }


            DataRow row = data.NewRow();
            row["IdNivelFormacion"] = 0;
            row["Titulo"] = string.Empty;
            row["IdSituacionFormacion"] = 0;
            row["AnioFormado"] = 0;

            data.Rows.Add(row);
            Session[FORMACION] = data;

            this.gvFormacion.DataSource = data;
            this.gvFormacion.DataBind();

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void btnAddHabilidad_Click(object sender, EventArgs e)
    {
        try
        {

            DataTable data = (DataTable)Session[HABILIDAD];


            if (this.gvHabilidad.Rows.Count > 0)
            {
                data.Clear();

                foreach (GridViewRow item in this.gvHabilidad.Rows)
                {
                    DropDownList ddlIdioma = (DropDownList)item.FindControl("ddlIdioma");
                    DropDownList ddlLectura = (DropDownList)item.FindControl("ddlLectura");
                    DropDownList ddlEscritura = (DropDownList)item.FindControl("ddlEscritura");
                    DropDownList ddlHablado = (DropDownList)item.FindControl("ddlHablado");

                    DataRow dataRow = data.NewRow();
                    dataRow["IdIdioma"] = int.Parse(ddlIdioma.SelectedValue);
                    dataRow["Lectura"] = ddlLectura.SelectedValue;
                    dataRow["Escritura"] = ddlEscritura.SelectedValue;
                    dataRow["Hablado"] = ddlHablado.SelectedValue;

                    data.Rows.Add(dataRow);
                }
            }

            DataRow row = data.NewRow();
            row["IdIdioma"] = "0";
            row["Lectura"] = "0";
            row["Escritura"] = "0";
            row["Hablado"] = "0";

            data.Rows.Add(row);
            Session[HABILIDAD] = data;

            this.gvHabilidad.DataSource = data;
            this.gvHabilidad.DataBind();

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void btnAddExperiencia_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable data = (DataTable)Session[EXPERIENCIA];


            if (this.gvExperiencia.Rows.Count > 0)
            {
                data.Clear();

                foreach (GridViewRow item in this.gvExperiencia.Rows)
                {
                    TextBox txtNombreEmpresa = (TextBox)item.FindControl("txtNombreEmpresa");
                    TextBox txtFechaInicio = (TextBox)item.FindControl("txtFechaInicio");
                    TextBox txtFechaFinal = (TextBox)item.FindControl("txtFechaFinal");
                    DropDownList ddlCargo = (DropDownList)item.FindControl("ddlCargo");
                    TextBox txtResponsabilidad = (TextBox)item.FindControl("txtResponsabilidad");

                    DataRow dataRow = data.NewRow();
                    dataRow["NombreEmpresa"] = txtNombreEmpresa.Text;
                    dataRow["FechaInicio"] = txtFechaInicio.Text;
                    dataRow["FechaFinal"] = txtFechaFinal.Text;
                    dataRow["IdCargo"] = ddlCargo.SelectedValue;
                    dataRow["Responsabilidad"] = txtResponsabilidad.Text;

                    data.Rows.Add(dataRow);
                }
            }

            DataRow row = data.NewRow();
            row["NombreEmpresa"] = string.Empty;
            row["IdCargo"] = 0;
            row["Responsabilidad"] = string.Empty;

            data.Rows.Add(row);
            Session[EXPERIENCIA] = data;

            this.gvExperiencia.DataSource = data;
            this.gvExperiencia.DataBind();
        }
        catch (Exception)
        {

            throw;
        }
    }
    protected void lnkDeleteFormacion_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkDeleteFormacion = (LinkButton)sender;
            int idFormacion = int.Parse(lnkDeleteFormacion.CommandArgument);
            DataTable data = (DataTable)Session[FORMACION];

            if (MidPostulante == 0)
            {

                DataRow row = data.Rows.Find(idFormacion);
                data.Rows.Remove(row);
                Session[FORMACION] = data;
                this.gvFormacion.DataSource = data;
                this.gvFormacion.DataBind();
            }
            else
            {
                FormacionBL oEliminar = new FormacionBL();
                oEliminar.EliminarFormacion(MidPostulante, idFormacion);
                this.gvFormacion.DataSource =oEliminar.getFormacion(MidPostulante);
                this.gvFormacion.DataBind();
                Session[FORMACION] = oEliminar.getFormacion(MidPostulante);
            }




        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void lnkDeleteHabilidad_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkDeleteHabilidad = (LinkButton)sender;
            int idHabilidad = int.Parse(lnkDeleteHabilidad.CommandArgument);

            DataTable data = (DataTable)Session[HABILIDAD];

            if (MidPostulante == 0)
            {
                DataRow row = data.Rows.Find(idHabilidad);
                data.Rows.Remove(row);
                Session[HABILIDAD] = data;
                this.gvHabilidad.DataSource = data;
                this.gvHabilidad.DataBind();
            }
            else
            {
                HabilidadBL oEliminar = new HabilidadBL();
                oEliminar.EliminarHabilidad(MidPostulante, idHabilidad);
                this.gvHabilidad.DataSource = oEliminar.getHabilidad(MidPostulante);
                this.gvHabilidad.DataBind();
                Session[HABILIDAD] = oEliminar.getHabilidad(MidPostulante);
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void lnkDeleteExperiencia_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkDeleteExperiencia = (LinkButton)sender;
            int idExperiencia = int.Parse(lnkDeleteExperiencia.CommandArgument);

            DataTable data = (DataTable)Session[EXPERIENCIA];

            if (MidPostulante == 0)
            {
                DataRow row = data.Rows.Find(idExperiencia);
                data.Rows.Remove(row);

                Session[EXPERIENCIA] = data;
                this.gvExperiencia.DataSource = data;
                this.gvExperiencia.DataBind();
            }
            else
            {
                ExperienciaBL oEliminar = new ExperienciaBL();
                oEliminar.EliminarExperiencia(MidPostulante, idExperiencia);
                this.gvExperiencia.DataSource = oEliminar.getExperiencia(MidPostulante);
                this.gvExperiencia.DataBind();
                Session[EXPERIENCIA] =oEliminar.getExperiencia(MidPostulante);
            }

        }
        catch (Exception)
        {

            throw;
        }
    }

}