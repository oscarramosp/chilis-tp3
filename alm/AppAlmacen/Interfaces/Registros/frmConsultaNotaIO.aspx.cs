using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ALM.ExceptionManagement;
using AjaxControlToolkit;
using ALM.BL.BusinessLogic.Almacen;

namespace AppAlmacen.Interfaces.Registros
{
    public partial class frmConsultaNotaIO : System.Web.UI.Page
    {
        protected void Page_Load(Object sender, EventArgs e)
        {

            AsignarEventosControles();

           
            ucwTituloBandeja.Texto="Modificar Nota I/S";
        }


        private void AsignarEventosControles()
        {
            this.ucwBuscarLimpiar.OnBuscar += new EventHandler(ucwBuscarLimpiar_OnBuscar);
            this.ucwBuscarLimpiar.OnLimpiar += new EventHandler(ucwBuscarLimpiar_OnLimpiar);
            this.gdvListado.RowEditing += new GridViewEditEventHandler(gdvListado_RowEditing);
        }

        void ucwBuscarLimpiar_OnLimpiar(object sender, EventArgs e)
        {
            txtCodNumPedido.Text = string.Empty;

            gdvListado.DataSource = null;
            gdvListado.DataBind();

          
        }


        void gdvListado_RowEditing(object sender, GridViewEditEventArgs e)
        {
            try
            {
                var codigo = gdvListado.Rows[e.NewEditIndex].FindControl("lblCodEdit") as Label;
                var tipodoc = gdvListado.Rows[e.NewEditIndex].FindControl("lblTipDoc") as Label;
                var UniOri = gdvListado.Rows[e.NewEditIndex].FindControl("lblUOriCod") as Label;
                var UniDes = gdvListado.Rows[e.NewEditIndex].FindControl("lblUDestCod") as Label;
                var fecha = gdvListado.Rows[e.NewEditIndex].FindControl("lblFecha") as Label;
                var periodo = gdvListado.Rows[e.NewEditIndex].FindControl("lblPeriodo") as Label;
                var tranTipo = gdvListado.Rows[e.NewEditIndex].FindControl("lblTransCod") as Label;
                var RefTipo = gdvListado.Rows[e.NewEditIndex].FindControl("lblrefCod") as Label;
                var empleado = gdvListado.Rows[e.NewEditIndex].FindControl("lblEmpleado") as Label;
                var codPedido = gdvListado.Rows[e.NewEditIndex].FindControl("lblCodPedido2") as Label;
               
                
               string strCodigo = codigo.Text;
               string strtipodoc = tipodoc.Text;
               string strUniOri = UniOri.Text;
               string strUniDes = UniDes.Text;
               string strfecha = fecha.Text;
               string strperiodo = periodo.Text;
               string strtranTipo = tranTipo.Text;
               string strRefTipo = RefTipo.Text;
               string strempleado = empleado.Text;
               string strcodPedido = codPedido.Text;




               Response.Redirect(String.Format("~/Interfaces/Registros/frmRegistroNotaIODetalle.aspx?Operacion={0}&Correlativo={1}&codTipDoc={2}&codUniOri={3}&CodUniDes={4}&fecha={5}&periodo={6}&transTipo={7}&refTipo={8}&empleado={9}&CodPedido={10}",
                    Enumeraciones.TipoOperacion.Modificacion.ToString(), strCodigo, strtipodoc, strUniOri, strUniDes, strfecha, strperiodo, strtranTipo, strRefTipo, strempleado,strcodPedido), false);
            }
            catch (ApplicationRulesException arex)
            {
                MessageBox(this, arex.Message);
            }
        }


        protected void OnNuevo(Object sender, EventArgs e)
        {
            Response.Redirect("frmRegistroNotaPedidoDetalle.aspx");

        }

       

        void ucwBuscarLimpiar_OnBuscar(object sender, EventArgs e)
        {
            try
            {
                int notaIngreso = ddlTipoOperacion.SelectedIndex;

                if (notaIngreso!= 0)
                {
                    if (notaIngreso == 1)
                    {
                        BLNotaPedido objBNotaPedido = new BLNotaPedido();
                        gdvListado.DataSource = objBNotaPedido.ListarPorNotaPedido_IS(0);
                        gdvListado.DataBind();
                    }
                    else {
                        if (txtCodNumPedido.Text != "")
                        {
                            BLNotaPedido objBNotaPedido = new BLNotaPedido();
                            gdvListado.DataSource = objBNotaPedido.ListarPorNotaPedido_IS(Convert.ToInt32(1));
                            gdvListado.DataBind();
                        }
                        else {
                            MessageBox(this, "Ingrese el número de pedido");
                        }
                        
                    }

                    
                }
                else
                {
                    MessageBox(this, "Seleccione el tipo de operación");
                }


            }
            catch (ApplicationRulesException arex)
            {
                MessageBox(this, arex.Message);
            }
        }

        public void MessageBox(Page pPage, String strMensaje)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), String.Empty,
                String.Format("setTimeout(\"alert('{0}');\", 0);", strMensaje), true);
        }

        protected void ddlTipoOperacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            string seleccion = ddlTipoOperacion.SelectedValue;

            if (seleccion == "NS")
            {
                trNumPedido.Visible = true;
             }
            else
            {
                trNumPedido.Visible = false;
         
            }
        }
  
    }
}