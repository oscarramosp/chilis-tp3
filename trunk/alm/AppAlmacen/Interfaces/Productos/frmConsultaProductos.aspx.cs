using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ALM.BL.BusinessLogic.Almacen;

namespace AppAlmacen.Interfaces.Productos
{
    public partial class frmConsultaProductos : System.Web.UI.Page
    {
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
            this.ucwBuscarLimpiar.OnBuscar += new EventHandler(OnOnBuscar);
            this.ucwBuscarLimpiar.OnLimpiar += new EventHandler(OnOnLimpiar);


        }
        protected void OnOnBuscar(Object sender, EventArgs e)
        {
            CargarProductos();
            txtNombre.Focus();
        }


        protected void OnOnLimpiar(Object sender, EventArgs e)
        {
            LimpiarProd();
        }
        void LimpiarProd()
        {
            txtCodigo.Text = "";
            txtNombre.Text = "";
            txtNombre.Focus();
            CargarProductos();
        }
        void CargarProductos()
        {
            BLProductos objBL = new BLProductos();
            String nombre = txtNombre.Text;
            String codigo = txtCodigo.Text;
            gdvListado.DataSource = objBL.ListarProductos(nombre, codigo);
            gdvListado.DataBind();
        }
    }
    
    
}