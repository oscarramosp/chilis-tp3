using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ALM.BE.Entities.Almacen;
using ALM.BL.BusinessLogic.Almacen;
using AppAlmacen.Almacen;
using AjaxControlToolkit;

public partial class ucwDatosDetalle : System.Web.UI.UserControl
{
    #region Propiedades
    public Enumeraciones.TipoOperacion TipoOperacionActual
    {
        get
        {
            return (Enumeraciones.TipoOperacion)(Enum.Parse(typeof(Enumeraciones.TipoOperacion), hddTipoOperacion.Value));
        }
        set
        {
            hddTipoOperacion.Value = value.ToString();
        }
    }

  
    public List<ENotaIngresoSalidaDetalle> ListaENotaISDetalle
    {
        get
        {
            return (List<ENotaIngresoSalidaDetalle>)HttpContext.Current.Session["ListaENotaISDetalle"];
        }
        set
        {
            HttpContext.Current.Session["ListaENotaISDetalle"] = value;
        }
    }

 
    #endregion
    
    #region Propiedades para Modo Lectura
    private Boolean modoLectura;
    private int cantidad;


    private Boolean ModoLectura
    {
        set { modoLectura = value; }
        get { return modoLectura; }
    }

    public int Cantidad
    {
        set { cantidad = value; }
        get { return cantidad; }
    }

    private void HabilitarControles()
    {
        Boolean Valor = !ModoLectura;
        imbAgregar.Enabled = Valor;
    }

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.ucwTituloBandeja.Texto = "Registro de Nota Ingreso/Salida detalle";
           
        }
        this.AddScripts(); 
        this.AgregarValidaciones();
        this.AsignarEventosControles();
       
    }

    #region Eventos hacia Form
    public delegate void CantidadEventHandler(CantidadEventArgs Cantidad);
    public delegate void ModNombresEventHandler(ModNombresEventArgs DatosNota); 

    public event CantidadEventHandler CantidadChangedNota;
    public event ModNombresEventHandler NombresChangedNota;

    public class CantidadEventArgs
    {
        public bool objCantidadNotas { get; protected set; }

        public CantidadEventArgs(bool obj_CantidadNotas)
        {
            objCantidadNotas = obj_CantidadNotas;
        }
    }

    public class ModNombresEventArgs
    {
        public String[] objDatosNota { get; protected set; }

        public ModNombresEventArgs(String[] obj_DatosNota)
        {
            objDatosNota = obj_DatosNota;
        }
    }

    public bool CantidadNotas()
    {
        return ListaENotaISDetalle.Count >= 1 ? true : false;
    }
    #endregion

    #region Metodos
        
   
    private void AgregarValidaciones()
    {
        rfvCantActual.ErrorMessage = "Ingrese la cantidad";
        rfvCodItem.ErrorMessage = "Ingrese el código Item";
        rfvDescripcion.ErrorMessage = "Ingrese la descripción";
        rfvLote.ErrorMessage = "Ingrese el Lote";
        rfvMedida.ErrorMessage = "Ingrese la Medida";
        rfvPrecioTotal.ErrorMessage = "Ingrese el precio Total";
        rfvPrecioUnit.ErrorMessage = "Ingrese el precio Unitario";
        rfvSerie.ErrorMessage = "Ingrese la Serie"; 
       
       }
    private void AddScripts()
    {
       this.txtLote.Attributes.Add("onkeypress", "return FP_SoloLetrasyNumeros(event);");
       this.txtCodItem.Attributes.Add("onkeypress", "return FP_SoloNumeros(event);");
       //this.txtPrecioTotal.Attributes.Add("onkeypress", "return FP_SoloLetrasyNumerosLimitadoConGuionyPunto(event);");
       this.txtPrecioUnit.Attributes.Add("onkeypress", "return FP_SoloNumerosyPuntos(event);");
       this.txtCantActual.Attributes.Add("onkeypress", "return FP_SoloNumeros(event);");

       this.txtPrecioUnit.Attributes.Add("onkeyup", "multiplica();");
       this.txtCantActual.Attributes.Add("onkeyup", "multiplica();");
      
        
    }
    
    private void AsignarEventosControles()
    {
        this.gdvListado.RowDeleting += new GridViewDeleteEventHandler(gdvListado_RowDeleting);
        this.gdvListado.RowCommand += new GridViewCommandEventHandler(gdvListado_RowEditing);
        this.imbAgregar.Click += new ImageClickEventHandler(imbAgregarAscensor_Click);
        this.ucwGrabarCerrar.OnCerrar += new EventHandler(ucwGrabarCerrar_OnCerrar);
        this.ucwGrabarCerrar.OnGrabar += new EventHandler(ucwGrabarCerrar_OnGrabar);
       
    }

 
    public void CargarNotasInicial(int codigoNota, Enumeraciones.TipoOperacion tipoOperacion)
    {
        hddCodigo.Value = codigoNota.ToString();

        if (tipoOperacion == Enumeraciones.TipoOperacion.Creacion)
            ModoLectura = false;
        else
            ModoLectura = true;

        imbAgregar.Enabled = !ModoLectura;

        BLNotaPedidoDetalle objNotaISDetalle = new BLNotaPedidoDetalle();
        ListaENotaISDetalle = objNotaISDetalle.ListarPorNotaIS(Convert.ToInt32(hddCodigo.Value));

        gdvListado.DataSource = ListaENotaISDetalle;
        gdvListado.DataBind();
        hddCorrelativoMaximo.Value = ListaENotaISDetalle.Count != 0 ? Convert.ToString(ListaENotaISDetalle.Max(o => o.CodigoDetIS)) : "0";
        ucwTotal.TotalRegistro = ListaENotaISDetalle.Count;
        this.Cantidad = ListaENotaISDetalle.Count;
        if (CantidadChangedNota != null)
            CantidadChangedNota(new CantidadEventArgs(CantidadNotas()));
    }

    public void CargarNotasSeleccionadas(List<ENotaIngresoSalidaDetalle> nota)
    {

        BLNotaPedidoDetalle objNotaISDetalle = new BLNotaPedidoDetalle();
        ListaENotaISDetalle = nota;

        gdvListado.DataSource = ListaENotaISDetalle;
        gdvListado.DataBind();
        hddCorrelativoMaximo.Value = ListaENotaISDetalle.Count != 0 ? Convert.ToString(ListaENotaISDetalle.Max(o => o.CodigoDetIS)) : "0";
        ucwTotal.TotalRegistro = ListaENotaISDetalle.Count;
        this.Cantidad = ListaENotaISDetalle.Count;
        if (CantidadChangedNota != null)
            CantidadChangedNota(new CantidadEventArgs(CantidadNotas()));
    }

    public void CargarNotasModificado(int correlativo)
    {
        gdvListado.DataSource = ListaENotaISDetalle;
        gdvListado.DataBind();
        ucwTotal.TotalRegistro = ListaENotaISDetalle.Count;
        this.Cantidad = ListaENotaISDetalle.Count;
    }

 
    private void CargarNotasDetPorNotaCab(int correlativo)
    {
        ENotaIngresoSalidaDetalle objENotaISDetalle = ListaENotaISDetalle.First<ENotaIngresoSalidaDetalle>(x => x.CodigoDetIS == correlativo);
        MostrarNotasDetPorNotaCab(objENotaISDetalle);
    }

    private void MostrarNotasDetPorNotaCab(ENotaIngresoSalidaDetalle objENotaISDetalle)
    {

        txtCodItem.Text = Convert.ToString(objENotaISDetalle.CodItem);
        txtCantActual.Text = Convert.ToString(objENotaISDetalle.cantActual);
        txtDescripcion.Text = objENotaISDetalle.descripcion;
        txtFechaCaducidad.SetText = Convert.ToString(objENotaISDetalle.fechaCaducidad);
        txtFechaElabora.SetText = Convert.ToString(objENotaISDetalle.fechaElaboracion);
        txtLote.Text = objENotaISDetalle.lote;
        txtMedida.Text = objENotaISDetalle.medida;
        txtPrecioTotal.Text = Convert.ToString(objENotaISDetalle.precioTotal);
        txtPrecioUnit.Text = Convert.ToString(objENotaISDetalle.precioUnitario);
        txtSerie.Text = objENotaISDetalle.serie;

        hddCorrelativo.Value = Convert.ToString(objENotaISDetalle.CodigoDetIS);

    }

    private void LimpiarControles()
    {
        txtCantActual.Text = String.Empty;
        txtCodItem.Text = String.Empty;
        txtDescripcion.Text = String.Empty;
        txtFechaCaducidad.Text = String.Empty;
        txtFechaElabora.Text = String.Empty;
        txtLote.Text = String.Empty;
        txtMedida.Text = String.Empty;
        txtPrecioTotal.Text = String.Empty;
        txtPrecioUnit.Text = String.Empty;
        txtSerie.Text = String.Empty;
  
        hddCorrelativo.Value = "0";
    }

    private ENotaIngresoSalidaDetalle ObtenerNotaISDetalle()
    {
      
        ENotaIngresoSalidaDetalle objENotadetalle = new ENotaIngresoSalidaDetalle();
        objENotadetalle.CodigoIS = Convert.ToInt32(hddCodigo.Value);
        objENotadetalle.cantActual =  Convert.ToInt32(txtCantActual.Text);
        objENotadetalle.CodItem = Convert.ToInt32(txtCodItem.Text);
        objENotadetalle.descripcion= txtDescripcion.Text; 
        objENotadetalle.fechaCaducidad= Convert.ToDateTime(txtFechaCaducidad.Text);
        objENotadetalle.fechaElaboracion = Convert.ToDateTime(txtFechaElabora.Text);
        objENotadetalle.medida = txtMedida.Text;
        objENotadetalle.lote = txtLote.Text;
        objENotadetalle.serie = txtSerie.Text;
        objENotadetalle.precioTotal = Convert.ToDecimal(txtPrecioTotal.Text);
        objENotadetalle.precioUnitario = Convert.ToDecimal(txtPrecioUnit.Text); 

                 
        if (!String.IsNullOrWhiteSpace(hddCorrelativo.Value) && hddCorrelativo.Value != "0")
        {
            objENotadetalle.CodigoDetIS = Convert.ToInt32(hddCorrelativo.Value);
        }
        else
        {
            int NuevoCorrelativo = 0;
            if (ListaENotaISDetalle.Count > 0)
            {
                NuevoCorrelativo = Convert.ToInt32(hddCorrelativoMaximo.Value) + 1;
            }
            else
            {
                NuevoCorrelativo = 1;
            }

            objENotadetalle.CodigoDetIS = NuevoCorrelativo; 
                        
        }

       
        return objENotadetalle;
    }
    private void Grabar()
    {
        String MensajeRespuesta = String.Empty;
        ENotaIngresoSalidaDetalle objENotadetalle = ObtenerNotaISDetalle();

        if (TipoOperacionActual == Enumeraciones.TipoOperacion.Creacion)
        {
            ListaENotaISDetalle.Add(objENotadetalle);
            hddCorrelativoMaximo.Value = Convert.ToString(ListaENotaISDetalle.Max(o => o.CodigoDetIS));
            if (CantidadChangedNota != null)
                CantidadChangedNota(new CantidadEventArgs(CantidadNotas()));
        }
        else if (TipoOperacionActual == Enumeraciones.TipoOperacion.Modificacion)
        {
            this.ModificarNotaDetalle(objENotadetalle);

            String[] DatosNotadetalle = new String[2];
            DatosNotadetalle[0] = Convert.ToString(objENotadetalle.CodigoDetIS);
             if (NombresChangedNota!= null)
                NombresChangedNota(new ModNombresEventArgs(DatosNotadetalle));

        }
        this.CargarNotasModificado(Convert.ToInt32(hddCodigo.Value));

        this.mpeActualizarNotaIS.Hide();

    }

    public List<ENotaIngresoSalidaDetalle> ObtenerNotaISDetalles()
    {
        List<ENotaIngresoSalidaDetalle> Lista_ENotaDetalle = new List<ENotaIngresoSalidaDetalle>();
        ListaENotaISDetalle.ForEach(delegate(ENotaIngresoSalidaDetalle objENotaDetalle)
        {
            Lista_ENotaDetalle.Add(objENotaDetalle);
        });

        ListaENotaISDetalle = Lista_ENotaDetalle;

        if (CantidadChangedNota != null)
            CantidadChangedNota(new CantidadEventArgs(CantidadNotas()));

        List<ENotaIngresoSalidaDetalle> objListaNotaDetalle = new List<ENotaIngresoSalidaDetalle>();
        objListaNotaDetalle = ListaENotaISDetalle;
        return objListaNotaDetalle;
    }
    private void ModificarNotaDetalle(ENotaIngresoSalidaDetalle obj_ENotaDetalle)
    {
        List<ENotaIngresoSalidaDetalle> Lista_ENotaDetalle = new List<ENotaIngresoSalidaDetalle>();
        ListaENotaISDetalle.ForEach(delegate(ENotaIngresoSalidaDetalle objENotaDetalle)
        {
            if (objENotaDetalle.CodigoDetIS == obj_ENotaDetalle.CodigoDetIS)
            {
                objENotaDetalle.CodItem = obj_ENotaDetalle.CodItem;
                objENotaDetalle.descripcion = obj_ENotaDetalle.descripcion;
                objENotaDetalle.cantActual = obj_ENotaDetalle.cantActual;
                objENotaDetalle.medida = obj_ENotaDetalle.medida;
                objENotaDetalle.lote = obj_ENotaDetalle.lote;
                objENotaDetalle.serie = obj_ENotaDetalle.serie;
                objENotaDetalle.fechaElaboracion = obj_ENotaDetalle.fechaElaboracion;
                objENotaDetalle.fechaCaducidad = obj_ENotaDetalle.fechaCaducidad;
                objENotaDetalle.precioUnitario = obj_ENotaDetalle.precioUnitario;
                objENotaDetalle.precioTotal = obj_ENotaDetalle.precioTotal; 

                
            }
            Lista_ENotaDetalle.Add(objENotaDetalle);
        });
        ListaENotaISDetalle = Lista_ENotaDetalle;
        if (CantidadChangedNota != null)
            CantidadChangedNota(new CantidadEventArgs(CantidadNotas()));
    }
    private void Eliminar(int correlativo)
    {
        ENotaIngresoSalidaDetalle objENotaDetalle = ListaENotaISDetalle.First<ENotaIngresoSalidaDetalle>(x => x.CodigoDetIS == correlativo);
        ListaENotaISDetalle.Remove(objENotaDetalle);
        if (CantidadChangedNota != null)
            CantidadChangedNota(new CantidadEventArgs(CantidadNotas()));
    }
    #endregion

    #region Eventos
    void gdvListado_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            String Id = gdvListado.DataKeys[e.RowIndex].Values["CodigoDetIS"].ToString();
            int correlativo = Convert.ToInt32(Id);
            this.Eliminar(correlativo);
            this.CargarNotasModificado(Convert.ToInt32(hddCodigo.Value));
        }
        catch (Exception arex)
        {
           MessageBox(this.Page, arex.Message);
        }
    }

    public void MessageBox(Page pPage, String strMensaje)
    {
        ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), String.Empty,
            String.Format("setTimeout(\"alert('{0}');\", 0);", strMensaje), true);
    }
  

    void gdvListado_RowEditing(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Modificar")
        {
            GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            int rIndex = row.RowIndex;

            int Correlativo = Convert.ToInt32(((Label)gdvListado.Rows[rIndex].FindControl("lblCorrelativo")).Text);
            TipoOperacionActual = Enumeraciones.TipoOperacion.Modificacion;
            this.CargarNotasDetPorNotaCab(Correlativo);
            this.mpeActualizarNotaIS.Show();
        }
    }
    
    protected void gdvListado_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton imbEditRow = null;
            imbEditRow = (ImageButton)e.Row.FindControl("imbEditRow");
            imbEditRow.Enabled = !ModoLectura;

            ImageButton imbDeleteRow = null;
            imbDeleteRow = (ImageButton)e.Row.FindControl("imbDeleteRow");
            imbDeleteRow.Enabled = !ModoLectura;
        }
    }

    protected void ucwGrabarCerrar_OnCerrar(object sender, EventArgs e)
    {
        LimpiarControles();
        mpeActualizarNotaIS.Hide();
    }

    protected void ucwGrabarCerrar_OnGrabar(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToDateTime(txtFechaElabora.Text) > Convert.ToDateTime(txtFechaCaducidad.Text))
            {
                MessageBox(this.Page, "La fecha de Elaboración no puede ser mayor a la fecha de Caducidad");
                mpeActualizarNotaIS.Show(); 
                            }
            else {
                Grabar();
            }

            
        }
        catch (Exception arex)
        {
          MessageBox(this.Page, arex.Message);
        }
    }

    protected void imbAgregarAscensor_Click(object sender, ImageClickEventArgs e)
    {
        TipoOperacionActual = Enumeraciones.TipoOperacion.Creacion;
        this.LimpiarControles();
        mpeActualizarNotaIS.Show();
    }

    
       
    #endregion
}
