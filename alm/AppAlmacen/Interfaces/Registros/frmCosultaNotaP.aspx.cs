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
            this.gdvPedidos.RowCommand += new GridViewCommandEventHandler(gdvPedidos_RowCommand);

            if (!Page.IsPostBack)
            {
                ucwTituloBandeja.Texto = "Actualizar Nota de Pedido";

                LlenarComboUN(cboUN);

                txtPrecioPedido.Visible = false;
                lblPrecioTotal.Visible = false;
                
            }
        }

       
        public void LlenarComboUN(DropDownList ddl)
        {

            BLNotaPedido objUN = new BLNotaPedido();

            Bind(objUN.ListarUnidadNegocio(), "Codigo", "Nombre", ddl);
            ddl.Items.Insert(0, new ListItem("--Seleccionar--", "-1"));

        }
        public void Bind(Object values, string valuefield, string textfield, DropDownList ddl)
        {
            ddl.DataSource = values;
            ddl.DataValueField = valuefield.Trim();
            ddl.DataTextField = textfield;
            ddl.DataBind();
        }

        public void Listar()
        {
            if (cboUN.SelectedValue == "-1")
            {
                MessageBox(this.Page, "Seleccione una Unidad de Negocio");
            }
            else
            {
                BLNotaPedido objProducto = new BLNotaPedido();
                gdvPedidos.DataSource = objProducto.ListarPorNotaPedidoP(Convert.ToInt32(cboUN.SelectedValue));
                gdvPedidos.DataBind();


                txtPrecioPedido.Visible = false;
                lblPrecioTotal.Visible = false;

                this.lblPedidoSel.Text = "";
                txtPrecioPedido.Text = "";
                gdvDetalle.DataSource = null;
                gdvDetalle.DataBind();
            }
        }


        void gdvPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {

         


            if (e.CommandName=="Aprobar"){

                var codigo = gdvPedidos.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblcodigo") as Label;

                BLNotaPedido objBLNota = new BLNotaPedido();
                objBLNota.ActualizarNotaPedidoP(Convert.ToInt32(codigo.Text), "1");


                MessageBox(this.Page, "Nota de Pedido Aprobada" );
                Listar();
            }
            if (e.CommandName == "Rechazar")
            {
                var codigo = gdvPedidos.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblcodigo") as Label;
                
                BLNotaPedido objBLNota = new BLNotaPedido();
                objBLNota.ActualizarNotaPedidoP(Convert.ToInt32(codigo.Text), "2");

                MessageBox(this.Page, "Nota de Pedido Rechazada");
                Listar();
            }
            
        }

        void gdvPedidos_RowEditing(object sender, GridViewEditEventArgs e)
        {
            
            var codigo = gdvPedidos.Rows[e.NewEditIndex].FindControl("lblcodigo") as Label;
            var correlativo = gdvPedidos.Rows[e.NewEditIndex].FindControl("lblCorrelativo") as Label;
            var preciopedido = gdvPedidos.Rows[e.NewEditIndex].FindControl("lblPrecioPedido") as Label;
            string strCodigo = codigo.Text;

            //se carga la grilla de ficha producto
            BLNotaPedidoDetalle objProducto = new BLNotaPedidoDetalle();

            gdvDetalle.DataSource = objProducto.ListarPorNotaP(Convert.ToInt32(strCodigo));
            gdvDetalle.DataBind();

            if (gdvDetalle.Rows.Count == 0)
            {
                lblPedidoSel.Text = "";
                txtPrecioPedido.Text = "";
                txtPrecioPedido.Visible = false;
                lblPrecioTotal.Visible = false;
                MessageBox(this.Page, "No hay detalle para el pedido seleccionado");

            }
            else
            {
                txtPrecioPedido.Visible = true;
                lblPrecioTotal.Visible = true;
                lblPedidoSel.Text = "Nota de Pedido seleccionada : " + correlativo.Text;
                txtPrecioPedido.Text = preciopedido.Text;
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            Listar();
        }

    }
}