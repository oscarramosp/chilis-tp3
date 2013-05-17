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
    public partial class frmCosultaNotaP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.gdvPedidos.RowEditing += new GridViewEditEventHandler(gdvPedidos_RowEditing);

            if (!Page.IsPostBack)
            {
                ucwTituloBandeja.Texto = "Consulta de Notas de Pedido";

                //LlenarComboUN(cboUN);
                Listar();
            }
        }

        public void Listar()
        {
            BLNotaPedido objProducto = new BLNotaPedido();
            gdvPedidos.DataSource = objProducto.ListarPorNotaPedidoP();
            gdvPedidos.DataBind();

           
            this.lblPedidoSel.Text = "";
            gdvDetalle.DataSource = null;
            gdvDetalle.DataBind();

        }


        void gdvPedidos_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var codigo = gdvPedidos.Rows[e.NewEditIndex].FindControl("lblcodigo") as Label;
            string strCodigo = codigo.Text;

            //se carga la grilla de ficha producto
            BLNotaPedidoDetalle objProducto = new BLNotaPedidoDetalle();

            gdvDetalle.DataSource = objProducto.ListarPorNotaP(Convert.ToInt32(strCodigo));
            gdvDetalle.DataBind();

            if (gdvDetalle.Rows.Count == 0)
            {
                lblPedidoSel.Text = "";
                MessageBox(this.Page, "No hay detalle para el pedido seleccionado");

            }
            else
            {
                lblPedidoSel.Text = "Nota de Pedido seleccionada : " + strCodigo;
            }


        }

        public void MessageBox(Page pPage, String strMensaje)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), String.Empty,
                String.Format("setTimeout(\"alert('{0}');\", 0);", strMensaje), true);
        }

        protected void btnSalirTodo_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

    }
}