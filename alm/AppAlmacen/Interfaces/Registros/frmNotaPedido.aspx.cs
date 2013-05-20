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
    public partial class frmNotaPedido : System.Web.UI.Page
    {

        public List<ENotaPedidoDetalle> ListaENotaPedidoDetalle
        {
            get
            {
                return (List<ENotaPedidoDetalle>)HttpContext.Current.Session["ListaENotaPedidoDetalle"];
            }
            set
            {
                HttpContext.Current.Session["ListaENotaPedidoDetalle"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.gdvListado.RowEditing += new GridViewEditEventHandler(gdvListado_RowEditing);
            this.gdvFichas.RowEditing += new GridViewEditEventHandler(gdvFichas_RowEditing);
            this.gdvDetalle.RowEditing += new GridViewEditEventHandler(gdvDetalle_RowEditing);


           
            if (!Page.IsPostBack)
            {
                ucwTituloBandeja.Texto = "Registrar Nota de Pedido";
                LlenarComboUN(cboUN);
                txtFechaElabora2.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtFechaElabora3.Value = DateTime.Now.ToShortDateString();
                ListaENotaPedidoDetalle = null;
                txtCodUNOculto.Value = "0";
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
            ddl.Items.Insert(0, new ListItem("--Todos--", "-1"));

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
            BLProductos objProducto = new BLProductos();
            gdvListado.DataSource = objProducto.BuscarProductosUN("", txtNomProducto.Text, Convert.ToInt32(cboUN.SelectedValue));
            gdvListado.DataBind();

            if (gdvListado.Rows.Count == 0)
            {
                MessageBox(this.Page, "No hay coincidencias");

            }

            lblProductoSel.Text = "";
            gdvFichas.DataSource = null;
            gdvFichas.DataBind();
        }

        void gdvListado_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var codigo = gdvListado.Rows[e.NewEditIndex].FindControl("lblcodigoPr") as Label;
            var UN = gdvListado.Rows[e.NewEditIndex].FindControl("lblCodUN") as Label;
            var descripcion = gdvListado.Rows[e.NewEditIndex].FindControl("lblDescripcion") as Label;
            
            string strCodigo = codigo.Text;

            //se carga la grilla de ficha producto
            BLProductos objProducto = new BLProductos();

            gdvFichas.DataSource = objProducto.ListarFichas(strCodigo, Convert.ToInt32(UN.Text));
            gdvFichas.DataBind();

            if (gdvFichas.Rows.Count == 0)
            {
                lblProductoSel.Text = "";
                txtProductoSel.Value = "";
                txtProductoSelDes.Value = "";
                MessageBox(this.Page, "No hay coincidencias de fichas para el producto seleccionado");

            }
            else
            {
                lblProductoSel.Text = "Producto seleccionado : " + strCodigo;
                txtProductoSel.Value = strCodigo;
                txtProductoSelDes.Value = descripcion.Text;
            }


        }


        void gdvFichas_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int contOtroAlmacen= 0;
            int cont = 0;
            
            var item = gdvFichas.Rows[e.NewEditIndex].FindControl("lblItem") as Label;
            var medida = gdvFichas.Rows[e.NewEditIndex].FindControl("lblMedida") as Label;
            var marca = gdvFichas.Rows[e.NewEditIndex].FindControl("lblMarca") as Label;
            var Codmarca = gdvFichas.Rows[e.NewEditIndex].FindControl("lblCodMarca") as Label;
            var fechaCaducidad = gdvFichas.Rows[e.NewEditIndex].FindControl("lblFecha") as Label;
            var cantActual = gdvFichas.Rows[e.NewEditIndex].FindControl("lblCantidad") as Label;
            var precioUnitario = gdvFichas.Rows[e.NewEditIndex].FindControl("lblPrecio") as Label;
            var precioTotal = gdvFichas.Rows[e.NewEditIndex].FindControl("lblTotal") as Label;
            var CodUN = gdvFichas.Rows[e.NewEditIndex].FindControl("lblCodUN") as Label;

            ENotaPedidoDetalle objBE = new ENotaPedidoDetalle();
            objBE.CodProducto = txtProductoSel.Value;
            objBE.CodItem = Convert.ToInt32(item.Text);
            objBE.medida = medida.Text;
            objBE.descripcion = txtProductoSelDes.Value;
            objBE.DesMarca = marca.Text;
            objBE.marca = Convert.ToInt32(Codmarca.Text);
            objBE.fechaCaducidad = Convert.ToDateTime(fechaCaducidad.Text);
            objBE.cantActual = Convert.ToDecimal(cantActual.Text);
            objBE.cantModif = Convert.ToDecimal(cantActual.Text);
            objBE.precioUnitario = Convert.ToDecimal(precioUnitario.Text);
            objBE.precioTotal = Convert.ToDecimal(precioTotal.Text);

            

            EFichaProducto objResult = new EFichaProducto();

            if (ListaENotaPedidoDetalle == null)
            {
                ListaENotaPedidoDetalle = new List<ENotaPedidoDetalle>();
            }

            //verifico si ya existe el registro en la lista
            ListaENotaPedidoDetalle.ForEach(delegate(ENotaPedidoDetalle objENotaPedidoDetalle)
            {
                if (objENotaPedidoDetalle.CodItem == objBE.CodItem)
                {
                    cont = cont + 1;
                }


            });


            contOtroAlmacen = 0;

            if (txtCodUNOculto.Value != "0" && gdvDetalle.Rows.Count > 0)
            {
                if (txtCodUNOculto.Value != CodUN.Text)
                {
                    contOtroAlmacen = 1;
                }
            }


            if (CodUN.Text != "2")
            {
                if (contOtroAlmacen == 0)
                {
                    //agrego el registro a la lista
                    if (cont == 0)
                    {
                        ListaENotaPedidoDetalle.Add(objBE);
                        gdvDetalle.DataSource = ListaENotaPedidoDetalle;
                        gdvDetalle.DataBind();


                        txtCodUNOculto.Value = CodUN.Text;

                        foreach (GridViewRow row in gdvDetalle.Rows)
                        {

                            TextBox txtPrueba = row.FindControl("txtCantidad") as TextBox;

                            txtPrueba.Attributes.Add("onblur", "javascript:ValidarGrilla();");
                            txtPrueba.Attributes.Add("onkeypress", "return FP_SoloNumeros(event);");


                        }
                    }
                    else
                    {
                        MessageBox(this.Page, "El registro seleccionado ya fue agregado a la nota de pedido");
                    }
                }
                else
                {
                    MessageBox(this.Page, "No se puede agregar Items de distintos almacenes");
                }

            }
            else
            {
                MessageBox(this.Page, "No se puede realizar pedido a tu mismo almacén (San Isidro)");
            }
            


        }


        void gdvDetalle_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var codigo = gdvDetalle.Rows[e.NewEditIndex].FindControl("lblItem") as Label;

            int strCodigo = Convert.ToInt32(codigo.Text);

            Delete(strCodigo);

        }

        public void Delete(int codigo)
        {
            List<ENotaPedidoDetalle> ltabla = ListaENotaPedidoDetalle;

            ltabla.RemoveAt(ltabla.FindIndex(f => f.CodItem == codigo));
            
            gdvDetalle.DataSource = ListaENotaPedidoDetalle;
            gdvDetalle.DataBind();

        }

        public void FunctionScript(Control pPage, String funcion)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), DateTime.Now.Ticks.ToString(), String.Format("setTimeout(\"{0}\", 0);", funcion), true);
        }

        protected void btnGrabarTodo_Click(object sender, EventArgs e)
        {
            if (txtFechaElabora2.Text =="")
            {
                MessageBox(this.Page, "Ingrese la fecha de elaboracion de la nota de pedido");
            }
            else if (txtAreaSolicitante.Text =="") {
                MessageBox(this.Page, "Ingrese el área solicitante");
            }
            else if (gdvDetalle.Rows.Count == 0)
            {
                MessageBox(this.Page, "Ingrese por lo menos un detalle en la nota de pedido");
            }
            else
            {
                 List<ENotaPedidoDetalle> ltabla = ListaENotaPedidoDetalle;
                int count = 0;
                int countCero = 0;
                decimal suma = 0;

                foreach (GridViewRow row in gdvDetalle.Rows)
                {
                    
                    
                    Label codigo = row.FindControl("lblItem") as Label;
                    Label cantidad = row.FindControl("lblCantidad") as Label;
                    Label precioUni = row.FindControl("lblPrecio") as Label;
                    TextBox cantidadmodif = row.FindControl("txtCantidad") as TextBox;

                    suma = suma + Convert.ToDecimal(precioUni.Text) * Convert.ToDecimal(cantidadmodif.Text);

                    ltabla.ElementAt(ltabla.FindIndex(f => f.CodItem == Convert.ToDecimal(codigo.Text))).cantModif = Convert.ToDecimal(cantidadmodif.Text);
                    //ltabla.ElementAt(ltabla.FindIndex(f => f.CodItem == Convert.ToDecimal(codigo.Text))).precioTotal = Convert.ToDecimal(precioUni.Text) * Convert.ToDecimal(cantidadmodif.Text);
                                        
                    if (Convert.ToDecimal(cantidad.Text) < Convert.ToDecimal(cantidadmodif.Text))
                    {
                        count = count + 1;
                    }

                    if (Convert.ToDecimal(cantidadmodif.Text) < 1)
                    {
                        countCero = countCero + 1;
                    }


                }


                if (countCero > 0)
                {
                    MessageBox(this.Page, "Las cantidades a pedir deben ser mayores a cero");
                }
                else
                {
                    if (count > 0)
                    {
                        MessageBox(this.Page, "Las cantidades a pedir no pueden ser mayores a las almacenadas!");
                    }
                    else
                    {


                        ENotaPedido objENota = new ENotaPedido()
                        {
                            NotaPedido = ListaENotaPedidoDetalle,
                            almacenOrigen = Convert.ToInt32(txtCodUNOculto.Value),
                            almacenDestino = 0,//Convert.ToInt32(cboUN.SelectedValue),//aqui
                            fechaEmision = Convert.ToDateTime(txtFechaElabora3.Value),
                            areaSoliciante = txtAreaSolicitante.Text,
                            precioPedido = suma,
                        };

                        BLNotaPedido objBLNota = new BLNotaPedido();

                        objBLNota.InsertarP(objENota);

                        ListaENotaPedidoDetalle = null;

                        FunctionScript(this, string.Format("MensajeRegistroExito('{0}');", "Se registro Correctamente la nota de Pedido."));


                    }
                }
                
            }
        }

        protected void btnNuevoPedido_Click(object sender, EventArgs e)
        {
            ListaENotaPedidoDetalle = null;
            Response.Redirect("frmNotaPedido.aspx");
        }

        protected void btnActualiza_Click(object sender, EventArgs e)
        {

            List<ENotaPedidoDetalle> ltabla = ListaENotaPedidoDetalle;
            int count = 0;

            foreach (GridViewRow row in gdvDetalle.Rows)
            {


                Label codigo = row.FindControl("lblItem") as Label;
                Label cantidad = row.FindControl("lblCantidad") as Label;
                Label precioUni = row.FindControl("lblPrecio") as Label;
                TextBox cantidadmodif = row.FindControl("txtCantidad") as TextBox;

                ltabla.ElementAt(ltabla.FindIndex(f => f.CodItem == Convert.ToDecimal(codigo.Text))).cantModif = Convert.ToDecimal(cantidadmodif.Text);
                ltabla.ElementAt(ltabla.FindIndex(f => f.CodItem == Convert.ToDecimal(codigo.Text))).precioTotal = Convert.ToDecimal(precioUni.Text) * Convert.ToDecimal(cantidadmodif.Text);

                if (Convert.ToDecimal(cantidad.Text) < Convert.ToDecimal(cantidadmodif.Text))
                {
                    count = count + 1;
                }


            }


            gdvDetalle.DataSource = ListaENotaPedidoDetalle;
            gdvDetalle.DataBind();

            foreach (GridViewRow row in gdvDetalle.Rows)
            {

                TextBox txtPrueba = row.FindControl("txtCantidad") as TextBox;

                txtPrueba.Attributes.Add("onblur", "javascript:ValidarGrilla();");
                txtPrueba.Attributes.Add("onkeypress", "return FP_SoloNumeros(event);");

            }

            if (count > 0)
            {
                MessageBox(this.Page, "Las cantidades a pedir no pueden ser mayores a las almacenadas!");
            }
        }

        protected void btnSalirTodo_Click(object sender, EventArgs e)
        {
            ListaENotaPedidoDetalle = null;
            Response.Redirect("~/Default.aspx");
        }

       
    }
}