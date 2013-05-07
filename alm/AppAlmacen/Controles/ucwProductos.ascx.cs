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

public partial class ucwProductos : System.Web.UI.UserControl
{

    public string Texto
    {
        get { return this.hndCodigoProd.Value; }
        set { this.hndCodigoProd.Value = value.ToString().ToUpper(); }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.ucwTituloBandeja.Texto = "Consulta de Productos";

        }
        CargarProductos();
        AsignarEventoControles();
    }

    private void AsignarEventoControles()
    {
        this.imbAgregar.Click += new ImageClickEventHandler(imbAgregarAscensor_Click);
        this.ucwBuscarLimpiar.OnBuscar += new EventHandler(OnOnBuscar);
        this.ucwBuscarLimpiar.OnLimpiar += new EventHandler(OnOnLimpiar);
   

    }
    #region Metodos

  
    
    protected void OnOnBuscar(Object sender, EventArgs e)
    {
        CargarProductos();
        txtNombre.Focus();
        mpeActualizarNotaIS.Show();
    }


    protected void OnOnLimpiar(Object sender, EventArgs e)
    {
        LimpiarProd();
        mpeActualizarNotaIS.Show();
    }
    void LimpiarProd()
    {
        txtNombre.Text = "";
        txtNombre.Focus();
        CargarProductos();
    }
    void CargarProductos()
    {
        BLProductos objBL = new BLProductos();
        String nombre = txtNombre.Text;
        gdvListado.DataSource = objBL.ListarProductos(nombre,"");
        gdvListado.DataBind();
    }
    
  
    
 
    #endregion

   
  
    protected void imbAgregarAscensor_Click(object sender, ImageClickEventArgs e)
    {
        LimpiarProd();
           mpeActualizarNotaIS.Show();
    }

    protected void gdvListado_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        LimpiarProd();

        Int32 index = Int32.Parse(e.CommandArgument.ToString());

        var codigo = gdvListado.Rows[index].FindControl("lblCodigo") as Label;
        String nombre = gdvListado.Rows[index].Cells[0].Text;

        hndCodigoProd.Value = codigo.Text;
        txtProducto.Text = nombre;

               
        mpeActualizarNotaIS.Hide();
    }

   
 


}
