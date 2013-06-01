using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ALM.ExceptionManagement;
using AjaxControlToolkit;
using ALM.BL.BusinessLogic.Almacen;
using AppAlmacen.Almacen;

namespace AppAlmacen.Interfaces.Registros
{
    public partial class frmRegistroNotaIO : System.Web.UI.Page
    {
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

        protected void Page_Load(Object sender, EventArgs e)
        {
            this.ucwBuscarLimpiar.OnBuscar += new EventHandler(ucwBuscarLimpiar_OnBuscar);
          //  this.gdvListado.RowEditing += new GridViewEditEventHandler(gdvListado_RowEditing);
            this.imbAgregar.Click += new ImageClickEventHandler(imbAgregar_Click);

            ucwTituloBandeja.Texto="Nota de Ingreso/Salida";
        }

        protected void imbAgregar_Click(object sender, ImageClickEventArgs e)
        {


            if (gdvListado.Rows.Count == 0)
            {
                MessageBox(this, "No hay items para agregar");
            }
            else
            {

                ListaENotaISDetalle = new List<ENotaIngresoSalidaDetalle>();

                int count = 0;

                foreach (GridViewRow row in gdvListado.Rows)
                {
                    ENotaIngresoSalidaDetalle objENotaDetalle = new ENotaIngresoSalidaDetalle();

                    count = count + 1;
                    CheckBox check = row.FindControl("chckSeleccionar") as CheckBox;

                    if (check.Checked)
                    {
                        var codigo = row.FindControl("lblCodEdit") as Label;
                        var codigo2 = row.FindControl("lblcodigo2") as Label;
                        var item = row.FindControl("lblItem") as Label;
                        var lblMedida = row.FindControl("lblMedida") as Label;
                        var lblCantActual = row.FindControl("lblCantActual") as Label;
                        var lblPrecioUnit = row.FindControl("lblPrecioUnit") as Label;
                        var lblPrecioTotal = row.FindControl("lblPrecioTotal") as Label;
                        var lblDescripcion = row.FindControl("lblDescripcion") as Label;


                        string strCodigo = codigo.Text;
                        string strCodigo2 = codigo2.Text;
                        codDetalle.Value = strCodigo;
                        codDetalle2.Value = strCodigo2;
                        string strItem = item.Text;
                        string strMedida = lblMedida.Text;
                        string strCantActual = lblCantActual.Text;
                        string strPrecioUnit = lblPrecioUnit.Text;
                        string strPrecioTotal = lblPrecioTotal.Text;



                        objENotaDetalle.CodItem = Convert.ToInt32(strItem);
                        objENotaDetalle.medida = strMedida;
                        objENotaDetalle.cantActual = Convert.ToInt32(strCantActual);
                        objENotaDetalle.precioUnitario = Convert.ToDecimal(strPrecioUnit);
                        objENotaDetalle.precioTotal = Convert.ToDecimal(strPrecioTotal);
                        objENotaDetalle.CodigoDetIS = count;
                        objENotaDetalle.fechaElaboracion = Convert.ToDateTime("12/12/2012");
                        objENotaDetalle.fechaCaducidad = Convert.ToDateTime("12/04/2013");
                        objENotaDetalle.descripcion = lblDescripcion.Text;

                        ListaENotaISDetalle.Add(objENotaDetalle);

                    }


                }

                // ListaENotaISDetalle = Lista_ENotaDetalle;

                Response.Redirect(String.Format("~/Interfaces/Registros/frmRegistroNotaIODetalle.aspx?Operacion={0}&Codigo={1}&codigo3={2}",
                Enumeraciones.TipoOperacion.Consulta.ToString(), codDetalle.Value, codDetalle2.Value), false);

            }

                  
        
        }




        protected void OnNuevo(Object sender, EventArgs e)
        {
            Response.Redirect(String.Format("~/Interfaces/Registros/frmRegistroNotaIODetalle.aspx?Operacion={0}&Correlativo=0&BusquedaEstado={1}",
          Enumeraciones.TipoOperacion.Creacion.ToString(), 1), false);

           // Response.Redirect("frmRegistroNotaPedidoDetalle.aspx");

        }

        protected void ddlTipoOperacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            string seleccion = ddlTipoOperacion.SelectedValue;

            if (seleccion == "NS")
            {
                trNumPedido.Visible = true;
                ucwBuscarLimpiar.Visible = true;
                ucwEdicion.Visible = false;
                divGrillaNotaPedido.Visible = true; 
            }
            else {
                ucwBuscarLimpiar.Visible = false;
                ucwEdicion.Visible = true;
                trNumPedido.Visible = false;
                divGrillaNotaPedido.Visible = false; 
            
            }
        }

        void ucwBuscarLimpiar_OnBuscar(object sender, EventArgs e)
        {
            try
            {

                if (txtCodNumPedido.Text != "")
                {
                    

                    BLNotaPedido objBNotaPedido = new BLNotaPedido();
                    gdvListado.DataSource = objBNotaPedido.ListarPorNotaPedido(Convert.ToInt32(txtCodNumPedido.Text));
                    gdvListado.DataBind();

                }
                else {
                    MessageBox(this,"Ingrese el Código de Pedido para la búsqueda");
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

      
    }
}