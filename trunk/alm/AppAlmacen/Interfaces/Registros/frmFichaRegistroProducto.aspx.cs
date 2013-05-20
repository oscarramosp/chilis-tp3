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
    public partial class frmFichaRegistroProducto : System.Web.UI.Page
    {

        public List<EFichaProducto> ListaEFichaProducto
        {
            get
            {
                return (List<EFichaProducto>)HttpContext.Current.Session["ListaEFichaProducto"];
            }
            set
            {
                HttpContext.Current.Session["ListaEFichaProducto"] = value;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {

            this.gdvListado.RowEditing += new GridViewEditEventHandler(gdvListado_RowEditing);
            this.gdvFichas.RowEditing += new GridViewEditEventHandler(gdvFichas_RowEditing);

            this.txtPrecioFicha.Attributes.Add("onkeypress", "return FP_SoloNumerosyPuntos(event);");
            this.txtCantidadFicha.Attributes.Add("onkeypress", "return FP_SoloNumeros(event);");

            if (!Page.IsPostBack)
            {
                ucwTituloBandeja.Texto = "Ficha Registro de Producto";
                LlenarComboMarca(cboMarca);
                LlenarComboUN(cboUNCab);
                cboUNCab.SelectedValue = "2"; //por defecto san isidro
                CodSeleccionado.Value = "";
                btnNuevaFicha.Visible = false;
                
            }

        }

        public void MessageBox(Page pPage, String strMensaje)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), String.Empty,
                String.Format("setTimeout(\"alert('{0}');\", 0);", strMensaje), true);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtCodProducto.Text.Trim() == "" && txtNomProducto.Text.Trim() == "")
            {
                MessageBox(this, "Ingrese por lo menos el código o nombre del producto");
            }
            else
            {
                mpeBuscarProducto.Show();
                txtItem.Text = txtCodProducto.Text;
                txtDescripcion.Text = txtNomProducto.Text;
                btnBuscar2_Click(null,null);
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
            //ddl.Items.Insert(0, new ListItem("--Seleccione--", "-1"));


        }        

        public void Bind(Object values, string valuefield, string textfield, DropDownList ddl)
        {
            ddl.DataSource = values;
            ddl.DataValueField = valuefield.Trim();
            ddl.DataTextField = textfield;
            ddl.DataBind();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            mpeBuscarProducto.Hide();
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

        
        void gdvListado_RowEditing(object sender, GridViewEditEventArgs e)
        { 
         var codigo = gdvListado.Rows[e.NewEditIndex].FindControl("lblcodigoPr") as Label;
         var id = gdvListado.Rows[e.NewEditIndex].FindControl("lblID") as Label;
         var nombre = gdvListado.Rows[e.NewEditIndex].FindControl("lblNombre") as Label;

            string strCodigo = codigo.Text;
            string strNombre = nombre.Text;
            string strid = id.Text;

            lblSeleccionado.Text = strNombre;
            CodSeleccionado.Value = strCodigo;
            IdSeleccionado.Value = strid;
            txtNomProducto.Text = "";
            txtCodProducto.Text = "";
            btnNuevaFicha.Visible = true;
        }


        void gdvFichas_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var codigo = gdvFichas.Rows[e.NewEditIndex].FindControl("lblItem") as Label;
            
            int  strCodigo = Convert.ToInt32(codigo.Text);

            Delete(strCodigo);
            
        }

        public void Delete(int codigo)
        {
            List<EFichaProducto> ltabla = ListaEFichaProducto;

            ltabla.RemoveAt(ltabla.FindIndex(f => f.Item == codigo));

            gdvFichas.DataSource = ListaEFichaProducto;
            gdvFichas.DataBind();

        }

        protected void btnNuevaFicha_Click(object sender, EventArgs e)
        {
            if (CodSeleccionado.Value == "")
            {
                MessageBox(this.Page, "Primero Seleccione un Producto");
            }
            else
            {

                //limpiamos las txt

                txtItemFicha.Text = "";
                txtItemVerdadero.Value = "";
                txtLoteFicha.Text = "";
                txtSerieFicha.Text = "";
                txtTipoFicha.Text = "";
                txtCantidadFicha.Text ="";
                txtPrecioFicha.Text= "";
                txtMedidaFicha.Text ="";
                txtFechaElabora.Text ="";
                txtFechaRecep.Text="";
                txtFechaVenci.Text = "";
                txtDescripcionFicha.Text = "";
                txtCodNotaIS.Value = "";

                if (gdvFichas.Rows.Count == 0)
                {
                    //se obtiene el ultimo de la BD
                    BLProductos objBL = new BLProductos();
                    EUltimoItem objBE = new EUltimoItem();
                    objBE = objBL.GetUltimo();
                    txtItemVerdadero.Value = Convert.ToString(objBE.UltimoItem);
                    txtItemFicha.Text = IdSeleccionado.Value;
                    txtDescripcionFicha.Text = lblSeleccionado.Text;

                    
                }
                else
                {
                    //se obtiene el ultimo en base a la grilla
                    var ultCod = gdvFichas.Rows[gdvFichas.Rows.Count - 1].FindControl("lblItem") as Label;
                    txtItemVerdadero.Value = Convert.ToString(Convert.ToInt32(ultCod.Text) + 1);
                    txtItemFicha.Text = IdSeleccionado.Value;
                    txtDescripcionFicha.Text = lblSeleccionado.Text;
                }

                //extraemos la data de los ultimos ingreso de Notas de Ingresos segun el almacen seleccionado
                BLNotaPedidoDetalle objBLFicha = new BLNotaPedidoDetalle();
                ENotaIngresoSalidaDetalle objBEFicha = new ENotaIngresoSalidaDetalle();
                objBEFicha = objBLFicha.ListarPorNotaFicha(Convert.ToInt32(IdSeleccionado.Value), Convert.ToInt32(cboUNCab.SelectedValue));

                if (objBEFicha != null)
                {
                    txtMedidaFicha.Text = objBEFicha.medida;
                    txtPrecioFicha.Text = Convert.ToString(objBEFicha.precioUnitario);
                    txtCodNotaIS.Value = Convert.ToString(objBEFicha.CodigoDetIS);
                    txtCantidadFicha.Text = Convert.ToString(objBEFicha.cantActual);
                    txtLoteFicha.Text = Convert.ToString(objBEFicha.lote);
                    txtSerieFicha.Text = Convert.ToString(objBEFicha.serie);
                    txtFechaElabora.Text = objBEFicha.fechaElaboracion.ToShortDateString();
                    txtFechaVenci.Text = objBEFicha.fechaCaducidad.ToShortDateString();
                    
                }
                
             

                //mostramos el PopUp
                mpeDatosFicha.Show();

            }
            
        }

        protected void btnCancelarFicha_Click(object sender, EventArgs e)
        {
            mpeDatosFicha.Hide();
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            if (txtLoteFicha.Text == "")
            {
                MessageBox(this.Page, "Ingresar Lote");
                mpeDatosFicha.Show();
            }
            else if (txtCantidadFicha.Text == "")
            {
                MessageBox(this.Page, "Ingresar Cantidad");
                mpeDatosFicha.Show();
            }
            else if (txtFechaElabora.Text == "")
            {
                MessageBox(this.Page, "Ingresar Fecha de Elaboración");
                mpeDatosFicha.Show();
            }
            else if (txtFechaVenci.Text == "")
            {
                MessageBox(this.Page, "Ingresar Fecha Vencimiento");
                mpeDatosFicha.Show();
            }
            else if (DateTime.Parse(txtFechaElabora.Text) > DateTime.Today)
            {
                MessageBox(this.Page, "Ingresar Fecha de Elaboración no puede ser mayor a la fecha actual");
                mpeDatosFicha.Show();
            }
            //else if (cboUN.SelectedValue == "-1")
            //{
            //    MessageBox(this.Page, "Seleccione una Unidad de Negocio");
            //    mpeDatosFicha.Show();
            //}
            else
            {
                EFichaProducto objBE = new EFichaProducto();
                objBE.Item = Convert.ToInt32(txtItemVerdadero.Value);
                objBE.Codigo = 0;
                objBE.codProducto = CodSeleccionado.Value;
                objBE.Descripcion = lblSeleccionado.Text;
                objBE.Lote = txtLoteFicha.Text;
                objBE.Serie = txtSerieFicha.Text;
                objBE.Tipo = txtTipoFicha.Text;
                objBE.Cantidad = Convert.ToDecimal(txtCantidadFicha.Text);
                objBE.Precio = Convert.ToDecimal(txtPrecioFicha.Text);
                objBE.Medida = txtMedidaFicha.Text;
                objBE.Fecha_Recepcion = Convert.ToDateTime(txtFechaElabora.Text);
                objBE.Fecha_Elaboracion = Convert.ToDateTime(txtFechaRecep.Text);
                objBE.Fecha_Vencimiento = Convert.ToDateTime(txtFechaVenci.Text);
                objBE.CodUN = Convert.ToInt32(cboUNCab.SelectedValue);
                objBE.CodNotaIS = Convert.ToInt32(txtCodNotaIS.Value);
           
                EFichaProducto objResult = new EFichaProducto();

                if (ListaEFichaProducto == null)
                {
                    ListaEFichaProducto = new List<EFichaProducto>(); 
                }
                
                ListaEFichaProducto.Add(objBE);

                gdvFichas.DataSource = ListaEFichaProducto;
                gdvFichas.DataBind();

                //objResult = OBJbl.Insertar(objBE);
                

                //if (objResult != null && objResult.Codigo > 0)
                //{
                //    mpeDatosFicha.Hide();
                //}

            }
        }

        public void FunctionScript(Control pPage, String funcion)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), DateTime.Now.Ticks.ToString(), String.Format("setTimeout(\"{0}\", 0);", funcion), true);
        }

        protected void btnSalirTodo_Click(object sender, EventArgs e)
        {
            ListaEFichaProducto = null;
            Response.Redirect("~/Default.aspx");
        }

        protected void btnGrabarTodo_Click(object sender, EventArgs e)
        {
            if (gdvFichas.Rows.Count == 0)
            {
                MessageBox(this.Page, "No existen fichas registros a grabar");
            }
            else
            {

                ListaEFichaProducto.ForEach(delegate(EFichaProducto objEFichaProducto)
                {
                    
                    //inserto la ficha de producto
                    BLProductos OBJbl = new BLProductos();
                    OBJbl.Insertar(objEFichaProducto);

                    //inserto la referencia entre ficha y NI
                    OBJbl.InsertarNI(objEFichaProducto.CodNotaIS);



                });

                ListaEFichaProducto = null;
                FunctionScript(this, string.Format("MensajeRegistroExito('{0}');", "Se registro Correctamente la ficha de producto."));
            }
        }


      
    }

    
}