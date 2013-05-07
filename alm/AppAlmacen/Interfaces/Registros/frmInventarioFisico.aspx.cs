using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ALM.BL.BusinessLogic.Almacen;
using SgpTI.BL.Entities;
using AjaxControlToolkit;
using ALM.BE.Entities.Almacen;
using System.Configuration;

namespace AppAlmacen.Interfaces.Registros
{
    public partial class frmInventarioFisico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.gdvListado.RowEditing += new GridViewEditEventHandler(gdvListado_RowEditing);

                ucwTituloBandeja.Texto = "Hoja de Inventario";
                LlenarComboEstadosINV(cboEstado);
                CargarData();
            }

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
        void CargarData(){

            BLInventario OBJbl = new BLInventario();
            gdvListado.DataSource = OBJbl.ListarHojaInventarios(txtFechaInicio.Text, txtFechaFin.Text, Int32.Parse(cboEstado.SelectedValue));
            gdvListado.DataBind();
        }
        protected void OnNuevo(Object sender, EventArgs e)
        {
            Response.Redirect(String.Format("~/Interfaces/Registros/frmInventarioFisicoDetalle.aspx?Operacion={0}&Codigo={1}", 1, 0), false);

        }

        protected void OnOnExportar(Object sender, EventArgs e)
        {
            BLInventario OBJbl = new BLInventario();
            List<EInventarioCabecera> objList = new List<EInventarioCabecera>();
            objList= OBJbl.ListarHojaInventarios(txtFechaInicio.Text, txtFechaFin.Text, Int32.Parse(cboEstado.SelectedValue));

            try
            {
                
                string rutaImagen = null;
                rutaImagen = "../Imagenes/logo1.png";
                String[] aHeaders = { "Codigo", "Fecha", "Referencia", "Responsable", "Estado" };

                string mHeader = null;
                if ((objList.Count>0))
                {

                    mHeader = "<table>";
                    mHeader = mHeader + "<tr>";
                    mHeader = mHeader + "<td colspan=2 style='font-weight:bold;font-size: 12pt;' width=82 height=35><img src=" + rutaImagen + "</td>";
                    mHeader = mHeader + "<td style='font-size: 8pt;'></td>";
                    mHeader = mHeader + "</tr>";
                    mHeader = mHeader + "<tr>";
                    mHeader = mHeader + "<td colspan=5 style='font-weight:bold;font-size: 14pt;' align='center'>Hoja de Inventarios</td>";
                    mHeader = mHeader + "</tr>";
                    mHeader = mHeader + "<tr>";
                    mHeader = mHeader + "<td style='font-weight:bold;font-size: 10pt;'></td>";
                    mHeader = mHeader + "</tr>";
                    mHeader = mHeader + "</table>";

                    mHeader= mHeader +"<table cellspacing='0' cellpadding='3' rules='all' bordercolor='#999999' border='1' id='dgExport' style='background-color:White;border-color:#999999;border-width:1px;border-style:None;font-family:Arial;font-size:12px;border-collapse:collapse;'>";
                    mHeader= mHeader +"<tr align='Center' style='color:Black;border-color:Black;font-weight:bold;'>";
                    for (int mIdx = 0; mIdx <= aHeaders.Length - 1; mIdx++)
                    {
                        mHeader = mHeader + "<td style='background-color:Silver'>" + aHeaders[mIdx] + "</td>";
                    }
                    mHeader = mHeader + "</tr>";
                    foreach (EInventarioCabecera obj in objList)
                    {
                        mHeader = mHeader + "<tr>";
                        mHeader = mHeader + "<td>"+ obj.codigoPr + "</td>";
                        mHeader = mHeader + "<td>" + obj.Fecha + "</td>";
                        mHeader = mHeader + "<td>" + obj.Referencia + "</td>";
                        mHeader = mHeader + "<td>" + obj.Responsable + "</td>";
                        mHeader = mHeader + "<td>" + obj.NombreEstado + "</td>";

                       mHeader = mHeader + "</tr>";
                    }



                    
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.ms-excel";
                    Response.AddHeader("Content-Disposition", "attachment; filename=Inventario.xls;");
                    Response.Charset = "UTF-8";
                    Response.ContentEncoding = System.Text.Encoding.Default;
                    Response.Write(mHeader);

                    Response.End();

                    Response.Clear();
                }
            }
            catch (Exception ex)
            {

                if (!(ClientScript.IsClientScriptBlockRegistered("Mensaje")))
                {
                    string sScript = "<script>alert('Too much data')</script>";
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "Mensaje", sScript);
                }
            }
        }
        protected void OnOnBuscar(Object sender, EventArgs e)
        {
            CargarData();
        }
        protected void OnOnLimpiar(Object sender, EventArgs e)
        {
            txtFechaFin.Text = "";
            txtFechaInicio.Text = "";
            cboEstado.SelectedIndex = 0;
            CargarData();
        }
        
        protected void gdvListado_RowEditing(object sender, GridViewEditEventArgs e)
        {
           
            try
            {
                var codigo = gdvListado.Rows[e.NewEditIndex].FindControl("lblCodEdit") as Label;

                string strCodigo = codigo.Text;

                Response.Redirect(String.Format("~/Interfaces/Registros/frmInventarioFisicoDetalle.aspx?Operacion={0}&Codigo={1}", 2,strCodigo), false);
              
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

        protected void gdvListado_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                String Id = gdvListado.DataKeys[e.RowIndex].Values["codigo"].ToString();
                int correlativo = Convert.ToInt32(Id);
                this.Eliminar(correlativo);
                CargarData();
            }
            catch (Exception arex)
            {
                MessageBox(this.Page, arex.Message);
            }
        }

        private void Eliminar(int correlativo)
        {
            BLInventario objBL = new BLInventario();
            objBL.eliminar(correlativo);

        }

    }
}