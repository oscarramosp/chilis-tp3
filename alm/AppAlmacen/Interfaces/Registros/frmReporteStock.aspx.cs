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
    public partial class frmReporteStock : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
        {
                ucwTituloBandeja.Texto = "Reporte de Stock";
                LlenarComboUN(cboAlmacen);
                LlenarComboEstadosINV(cboEstado);
                LlenarComboMarca(cboMarca);

            }
        }

        public void LlenarComboMarca(DropDownList ddl)
        {

            BLProductos objProducto = new BLProductos();

            Bind(objProducto.ListarMarcas(), "codMarca", "Descripcion", ddl);
            ddl.Items.Insert(0, new ListItem("--Seleccione--", "-1"));


        }


        public void LlenarComboUN(DropDownList ddl)
        {

            BLNotaPedido objUN = new BLNotaPedido();

            Bind(objUN.ListarUnidadNegocio(), "Codigo", "Nombre", ddl);
            ddl.Items.Insert(0, new ListItem("--Seleccione--", "-1"));

        }

        public void LlenarComboEstadosINV(DropDownList ddl)
        {

            BLInventario OBJbl = new BLInventario();

            Bind(OBJbl.ListarEstadoINV(), "codigo", "Nombre", ddl);
            ddl.Items.Insert(0, new ListItem("--Seleccione--", "-1"));


        }

        public void Bind(Object values, string valuefield, string textfield, DropDownList ddl)
        {
            ddl.DataSource = values;
            ddl.DataValueField = valuefield.Trim();
            ddl.DataTextField = textfield;
            ddl.DataBind();
        }

        protected void btnItem_Click(object sender, EventArgs e)
        {
            //BLProductos objProducto = new BLProductos();
            //gdvListado.DataSource = objProducto.BuscarProductos(txtItem.Text, txtDescripcion.Text, txtFamilia.Text, txtSubFamilia.Text, Convert.ToInt32(cboMarca.SelectedValue));
            //gdvListado.DataBind();

            //if (gdvListado.Rows.Count == 0)
            //{
            //    MessageBox(this.Page, "El código o nombre del producto no existe");
            //}


            mpeBuscarProducto.Show();
            
        }


        public void MessageBox(Page pPage, String strMensaje)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), String.Empty,
                String.Format("setTimeout(\"alert('{0}');\", 0);", strMensaje), true);
        }

        protected void btnBuscar2_Click(object sender, EventArgs e)
        {
            BLProductos objProducto = new BLProductos();
            gdvListado.DataSource = objProducto.BuscarProductos(txtItem.Text, txtDescripcion.Text, txtFamilia.Text, txtSubFamilia.Text, Convert.ToInt32(cboMarca.SelectedValue));
            gdvListado.DataBind();

            if (gdvListado.Rows.Count == 0)
            {
                MessageBox(this.Page, "El código o nombre del producto no existe");
            }


            mpeBuscarProducto.Show();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            mpeBuscarProducto.Hide();
        }

    }
}