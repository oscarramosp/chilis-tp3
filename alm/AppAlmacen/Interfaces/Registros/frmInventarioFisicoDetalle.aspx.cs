using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ALM.BE.Entities.Almacen;
using ALM.BL.BusinessLogic.Almacen;
using AjaxControlToolkit;
using AppAlmacen.Almacen;

namespace AppAlmacen.Interfaces.Registros
{
    public partial class frmInventarioFisicoDetalle : System.Web.UI.Page
    {
        public List<EInventarioDetalle> listDetalle
        {
            get
            {
                if (ViewState["listDetalle"] != null)
                    return (List<EInventarioDetalle>)ViewState["listDetalle"];
                else
                    return null;
            }

            set
            {
                ViewState["listDetalle"] = value;
            }
        }

       List<EInventarioDetalle> cargarListaDetalle()
        {
           List<EInventarioDetalle> ltabla = new List<EInventarioDetalle>();
           if (this.listDetalle == null || listDetalle.Count == 0)
            {
                ltabla = new List<EInventarioDetalle>();
            }
            else
            {
                ltabla = this.listDetalle;
                Int32 contador=1;
                foreach (EInventarioDetalle objBE in ltabla)
                {
                    objBE.Item = contador;
                    contador++;
                }
                                       
            }
            return ltabla;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack){
            
                String Operacion = Request.QueryString["Operacion"].ToString();
                String codigoCabecera = Request.QueryString["Codigo"].ToString();
                if (Operacion == "1")
                {
                    FillItemsInGrid();
                }
                else
                {
                    CargarData(Int32.Parse(codigoCabecera));
                    FillItemsInGrid();
                }
            }
        }
        void CargarData(Int32 codigo)
        {
            BLInventario objBL = new BLInventario();
            EInventarioCabecera objBE= new EInventarioCabecera();
            objBE = objBL.ListarHojaInventarioxCod(codigo);
            List<EInventarioDetalle> objList = new List<EInventarioDetalle>();
            objList = objBL.ListarHojaInventarioDetxCod(codigo);
            this.listDetalle = objList;
            FillItemsInGrid();
            txtReferencia.Text = objBE.Referencia;
            txtFecha.Text = objBE.Fecha.ToShortDateString();
            txtResponsable.Text = objBE.Responsable;
            txtCodigo.Text = objBE.Codigo.ToString();
            chkTerminado.Checked = (objBE.Estado == 2);
        }
        protected void OnCerrar(Object sender, EventArgs e)
        {
            Response.Redirect("frmInventarioFisico.aspx");
        }
        public void MessageBox(Page pPage, String strMensaje)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), String.Empty,
                String.Format("setTimeout(\"alert('{0}');\", 0);", strMensaje), true);
        }

        protected void OnGrabar(Object sender, EventArgs e)
        {
            if (txtReferencia.Text == "")
            {
                MessageBox(this.Page, "Ingresar Referencia");
            }
            else if (txtResponsable.Text == "")
            {
                MessageBox(this.Page, "Ingresar Responsable");
            }
            else if (txtFecha.Text == "")
            {
                MessageBox(this.Page, "Ingresar Fecha :" + Convert.ToString(txtFecha.Text));
            }
            else
            {
                
                EInventarioCabecera objBE = new EInventarioCabecera();
                objBE.Referencia = txtReferencia.Text;
                objBE.Fecha = Convert.ToDateTime(txtFecha.Text);
                //objBE.Fecha = Convert.ToDateTime(String.Format("{0:MM/dd/yyyy}", txtFecha.Text));
                objBE.FechaRegistro = DateTime.Today;
                objBE.Responsable = txtResponsable.Text;
                objBE.Estado = (chkTerminado.Checked?2:1);
                objBE.ListadDetalle = cargarListaDetalle();
                BLInventario OBJbl = new BLInventario();
                EInventarioCabecera objResult = new EInventarioCabecera();
                if (txtCodigo.Text == "" || txtCodigo.Text == "0")
                {
                    objResult = OBJbl.Insertar(objBE);
                }
                else
                {
                    objBE.Codigo = Int32.Parse(txtCodigo.Text);
                    objResult = OBJbl.Actualizar(objBE);
                }

                if (objResult != null && objResult.Codigo > 0)
                {
                    Response.Redirect("frmInventarioFisico.aspx");
                }

            }

        }
        private void FillItemsInGrid()
        {
            List<EInventarioDetalle> dtCustomer = cargarListaDetalle();

            if (dtCustomer.Count == 0)
            {
                EInventarioDetalle objBE = new EInventarioDetalle();
                dtCustomer.Add(objBE);
                gvDetalle.DataSource = dtCustomer;
                gvDetalle.DataBind();
                gvDetalle.Rows[0].Cells.Clear();
                //int TotalColumns = gvDetalle.Rows[0].Cells.Count;
                //gvDetalle.Rows[0].Cells.Clear();
                //gvDetalle.Rows[0].Cells.Add(new TableCell());
                //gvDetalle.Rows[0].Cells[0].ColumnSpan = TotalColumns;
                //gvDetalle.Rows[0].Cells[0].Text = "No Record Found";
            }
            else
            {
                gvDetalle.DataSource = dtCustomer;
                gvDetalle.DataBind();
            }

        }
        protected void gvDetalle_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {

                TextBox txtNewProducto = (TextBox)gvDetalle.FooterRow.FindControl("txtcodProducto");
                TextBox txtCantidad = (TextBox)gvDetalle.FooterRow.FindControl("txtCantidad");
                TextBox txtDescripcion = (TextBox)gvDetalle.FooterRow.FindControl("txtDescripcion");
                TextBox txtMedida = (TextBox)gvDetalle.FooterRow.FindControl("txtMedida");

                           
            BLProductos objBL = new BLProductos();
            List<EProductos> objList = new List<EProductos>();

            objList = objBL.ListarProductos("", txtNewProducto.Text);
            if (objList.Count == 0)
            {
                MessageBox(this.Page, "Codigo no existe");
            }
            else
            {


                Insert(objList[0].Codigo, Decimal.Parse(txtCantidad.Text), txtDescripcion.Text,  objList[0].Medida, objList[0].Nombre, objList[0].CodigoPr);
                FillItemsInGrid();
            }
                
            }
        }

        public void Insert(Int32 Producto, Decimal Cantidad, String Descripcion, String Medida, String nombreProducto, String codigoPr)
        {

                List<EInventarioDetalle> ltabla = cargarListaDetalle();

                EInventarioDetalle objBE = new EInventarioDetalle();
                objBE.Item = ltabla.Count + 1;
                objBE.codProducto = Producto;
                objBE.codigoPr = codigoPr;
                objBE.nombreProducto = nombreProducto;
                objBE.CantidadActual = Cantidad;
                objBE.Descripcion = Descripcion;
                objBE.Medida = Medida;
                ltabla.Add(objBE);
                this.listDetalle = ltabla;
   
        }

        protected void gvDetalle_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDetalle.EditIndex = -1;
            FillItemsInGrid();
        }

        protected void gvDetalle_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label lblItem = (Label)gvDetalle.Rows[e.RowIndex].FindControl("lblItem");

            Delete(Int32.Parse(lblItem.Text));
            FillItemsInGrid();
        }
        public void Delete(int codigo)
        {
            List<EInventarioDetalle> ltabla = cargarListaDetalle();

            ltabla.RemoveAt(ltabla.FindIndex(f => f.Item == codigo));

            this.listDetalle = ltabla;

        }
        protected void gvDetalle_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDetalle.EditIndex = e.NewEditIndex;
            FillItemsInGrid();
         
        }

        protected void gvDetalle_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            TextBox txtNewProducto = (TextBox)gvDetalle.Rows[e.RowIndex].FindControl("txtcodProductoE");
            TextBox txtCantidad = (TextBox)gvDetalle.Rows[e.RowIndex].FindControl("txtCantidad");
            TextBox txtDescripcion = (TextBox)gvDetalle.Rows[e.RowIndex].FindControl("txtDescripcion");
            TextBox txtMedida = (TextBox)gvDetalle.Rows[e.RowIndex].FindControl("txtMedida");
            Label lblItem = (Label)gvDetalle.Rows[e.RowIndex].FindControl("lblItem");

              BLProductos objBL = new BLProductos();
            List<EProductos> objList = new List<EProductos>();

            objList = objBL.ListarProductos("", txtNewProducto.Text);
            if (objList.Count == 0)
            {
                MessageBox(this.Page, "Codigo no existe");
            }
            else
            {
                Update(Int32.Parse(lblItem.Text), objList[0].Codigo, Decimal.Parse(txtCantidad.Text), txtDescripcion.Text, objList[0].Medida, objList[0].Nombre, objList[0].CodigoPr);
                gvDetalle.EditIndex = -1;
                FillItemsInGrid();
            }
        }
        public void Update(Int32 codigo, Int32 Producto, Decimal Cantidad, String Descripcion, String Medida, String nombreProducto, String codigoPr)
        {
            
          
          
                List<EInventarioDetalle> ltabla = cargarListaDetalle();

                Int32 contador = ltabla.FindIndex(f => f.Item == codigo);
                ltabla[contador].codProducto = Producto;
                ltabla[contador].nombreProducto = nombreProducto;
                ltabla[contador].codigoPr = codigoPr;
                ltabla[contador].CantidadActual = Cantidad;
                ltabla[contador].Descripcion = Descripcion;
                ltabla[contador].Medida = Medida;

                this.listDetalle = ltabla;
            
              

        }
        protected void gvDetalle_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<EInventarioDetalle> ltabla = cargarListaDetalle();

            gvDetalle.PageIndex = e.NewPageIndex;
            gvDetalle.DataSource = ltabla;
            gvDetalle.DataBind();
      
        }

      
    }
}