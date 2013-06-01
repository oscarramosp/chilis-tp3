using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ALM.BL.BusinessLogic.Almacen;
using ALM.BE.Entities.Almacen;
using ALM.ExceptionManagement;
using AjaxControlToolkit;
using AppAlmacen.Almacen;


namespace AppAlmacen.Interfaces.Registros
{
    public partial class frmConsultaProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.gdvListado.RowEditing += new GridViewEditEventHandler(gdvListado_RowEditing);

            if (!Page.IsPostBack)
            {
                ucwTituloBandeja.Texto = "Consulta de Productos";
                
                LlenarComboUN(cboUN);
                
            }
        }

        public void MessageBox(Page pPage, String strMensaje)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), String.Empty,
                String.Format("setTimeout(\"alert('{0}');\", 0);", strMensaje), true);
        }

        public void LlenarComboUN(DropDownList ddl)
        {

            BLNotaPedido objUN = new BLNotaPedido();

            Bind(objUN.ListarUnidadNegocio(), "Codigo", "Nombre", ddl);
            ddl.Items.Insert(0, new ListItem("--TODOS--", "-1"));

        }
        public void Bind(Object values, string valuefield, string textfield, DropDownList ddl)
        {
            ddl.DataSource = values;
            ddl.DataValueField = valuefield.Trim();
            ddl.DataTextField = textfield;
            ddl.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (cboUN.SelectedValue == "-10")
            {
                MessageBox(this, "Seleccione por lo menos la unidad de negocio");
            }
            else
            {

                BLProductos objProducto = new BLProductos();
                gdvListado.DataSource = objProducto.BuscarProductosUN(txtCodProducto.Text, txtNomProducto.Text, Convert.ToInt32(cboUN.SelectedValue));
                gdvListado.DataBind();

                if (gdvListado.Rows.Count == 0)
                {
                    MessageBox(this.Page, "No hay coincidencias");
                   
                }

                lblProductoSel.Text = "";
                gdvFichas.DataSource = null;
                gdvFichas.DataBind();


            }
        }


        void gdvListado_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var codigo = gdvListado.Rows[e.NewEditIndex].FindControl("lblcodigoPr") as Label;
            var nom = gdvListado.Rows[e.NewEditIndex].FindControl("lblNombre") as Label;
            var CodUN = gdvListado.Rows[e.NewEditIndex].FindControl("lblCodUN") as Label;
            string strCodigo = codigo.Text;

           //se carga la grilla de ficha producto
            BLProductos objProducto = new BLProductos();

            gdvFichas.DataSource = objProducto.ListarFichas(strCodigo, Convert.ToInt32(CodUN.Text));
            gdvFichas.DataBind();

            if (gdvFichas.Rows.Count == 0)
            {
                lblProductoSel.Text = "";
                MessageBox(this.Page, "No hay coincidencias de fichas para el producto seleccionado");
                
            }
            else {
                lblProductoSel.Text = "Producto seleccionado : " + nom.Text;
            }


        }


        protected void btnSalirTodo_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

    }
}