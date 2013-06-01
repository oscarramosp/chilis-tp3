﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ALM.BL.BusinessLogic.Almacen;
using ALM.BE.Entities.Almacen;

using AjaxControlToolkit;
using AppAlmacen.Almacen;

namespace AppAlmacen.Interfaces.Registros
{
    public partial class frmRegistroNotaIODetalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            this.AsignarEventosValidacion();
            this.AsignarEventoControles();
            this.AddScripts();
            this.AsignarMensajesValidacion(); 

            if (!Page.IsPostBack)
            {
                ucwTituloBandeja.Texto = "Registro de Nota I/S";
                LlenarComboUnidadNegocio(ddlunidadDestino);
                LlenarComboUnidadNegocio(ddlUnidadOrigen);

                this.Inicio();

                this.CargarNota();
            }

        }

        protected Enumeraciones.TipoOperacion TipoOperacionActual
        {
            get
            {
                return (Enumeraciones.TipoOperacion)(ViewState["Tipo_Operacion_Actual"]);
            }
            set
            {
                ViewState["Tipo_Operacion_Actual"] = value;
            }
        }


        private void LimpiarFormulario()
        {

            txtEmpleado.Text = String.Empty;
            txtFecha.Text = String.Empty;
            txtNumRefDoc.Text = String.Empty;
            txtPeriodo.Text = String.Empty;

            //ddlRefencia.SelectedIndex = 0;
            ddlTipoDocumento.SelectedIndex = 0;
            ddlTransferencia.SelectedIndex = 0;
            ddlunidadDestino.SelectedIndex = 0;
            ddlUnidadOrigen.SelectedIndex = 0; 
           

        }


        private void Inicio()
        {
            hddCodigo.Value = Request.QueryString["Correlativo"];
            lblCodigoNotaIS.Text = Request.QueryString["Codigo2"];
            String operacion = Request.QueryString["Operacion"];
            Enumeraciones.TipoOperacion tipoOperacion = (Enumeraciones.TipoOperacion)Enum.Parse(typeof(Enumeraciones.TipoOperacion), operacion, true);

            txtCodigoPedido.ReadOnly = true;
            btnCargarporPedido.Visible = false;

            string codTipDoc = Request.QueryString["codTipDoc"];
            string codUniOri = Request.QueryString["codUniOri"];
            string CodUniDes = Request.QueryString["CodUniDes"];
            string fecha = Request.QueryString["fecha"];
            string periodo = Request.QueryString["periodo"];
            string transTipo = Request.QueryString["transTipo"];
            string refTipo = Request.QueryString["refTipo"];
            string empleado = Request.QueryString["empleado"];
            string CodPedido = Request.QueryString["CodPedido"];

            TipoOperacionActual = tipoOperacion;
            switch (tipoOperacion)
            {
                case Enumeraciones.TipoOperacion.Creacion:

                    ucwGrabarCerrar.HabilitarGrabar = true;
                    ucwGrabarCerrar.VisibleGrabar = true;
                    hddCodigo.Value = "0";
                    LimpiarFormulario();
                    ddlTipoDocumento.SelectedIndex = 1;

                    ddlTransferencia.Items.Clear();
                    ddlTransferencia.Items.Insert(0, new ListItem("Ingreso de Proveedor", "IP"));
                    ddlTransferencia.Items.Insert(0, new ListItem("Ingreso por Terceros", "IT"));
                    ddlTransferencia.Items.Insert(0, new ListItem("--Seleccione--", "-1"));
                    ddlTransferencia.SelectedValue = "-1";

                    LlenarComboUnidadNegocioP(ddlUnidadOrigen);
                    
                    ddlunidadDestino.SelectedValue = "2"; //por defecto siempre es San Isidro 
                    ddlUnidadOrigen.SelectedValue = "-1";
                    if (Convert.ToString(DateTime.Now.Month).Length < 2)
                    {
                        txtPeriodo.Text = Convert.ToString(DateTime.Now.Year) + '0' + Convert.ToString(DateTime.Now.Month);
                    }
                    else
                    {
                        txtPeriodo.Text = Convert.ToString(DateTime.Now.Year) + Convert.ToString(DateTime.Now.Month);
                    }

                    txtFecha.Text = DateTime.Now.ToShortDateString();
                    
                    break;
                case Enumeraciones.TipoOperacion.Modificacion:
                    ucwGrabarCerrar.HabilitarGrabar = true;
                    ucwGrabarCerrar.VisibleGrabar = true;
                    txtCodigoPedido.Text = CodPedido;
                    //lblCodigoNotaIS.Text = "";
                    txtEmpleado.Text = empleado;
                    txtFecha.Text = fecha;
                    txtNumRefDoc.Text = CodPedido;
                    txtPeriodo.Text = periodo;
                    //ddlRefencia.SelectedValue = refTipo;
                    
                    ddlunidadDestino.SelectedValue = CodUniDes;
                    ddlTipoDocumento.SelectedValue = codTipDoc;

                    cargar_tipotransferencia();

                    ddlTransferencia.SelectedValue = transTipo;

                    

                    if (codTipDoc == "NI")
                    {
                        LlenarComboUnidadNegocioP(ddlUnidadOrigen);
                    }
                    else {
                        LlenarComboUnidadNegocio(ddlUnidadOrigen);
                    }

                    ddlUnidadOrigen.SelectedValue = codUniOri;

                    break;

                case Enumeraciones.TipoOperacion.Consulta:
                     string codPedidoCon = Request.QueryString["Codigo"];
                    string codPedidoCon2 = Request.QueryString["Codigo2"];
                    ucwGrabarCerrar.HabilitarGrabar = true;
                    ucwGrabarCerrar.VisibleGrabar = true;
                    hddCodigo.Value = "0";
                    LimpiarFormulario();
                     txtCodigoPedido.Text = codPedidoCon;
                     txtNumRefDoc.Text = codPedidoCon2;
                     ddlTipoDocumento.SelectedIndex = 2;


                    ddlTransferencia.Items.Clear();
                    ddlTransferencia.Items.Insert(0, new ListItem("Salida a Terceros", "ST"));
                    ddlTransferencia.SelectedValue = "ST";
                    //ddlTransferencia.Enabled = false;

                     ddlUnidadOrigen.SelectedValue = "2"; //por defecto siempre es San Isidro 

                     txtFecha.Text = DateTime.Now.ToShortDateString();
                     if (Convert.ToString(DateTime.Now.Month).Length < 2)
                     {
                         txtPeriodo.Text = Convert.ToString(DateTime.Now.Year) + '0' + Convert.ToString(DateTime.Now.Month);
                     }
                     else
                     {
                         txtPeriodo.Text = Convert.ToString(DateTime.Now.Year) + Convert.ToString(DateTime.Now.Month);
                     }


                    //se cargan los datos de la NP seleccionada
                     if (codPedidoCon != ""){
                         try
                         {
                             BLNotaPedido objBL = new BLNotaPedido();
                             ENotaPedido objBE = new ENotaPedido();
                             objBE = objBL.GetNP(Convert.ToInt32(codPedidoCon));
                             ddlUnidadOrigen.SelectedValue = objBE.almacenOrigen.ToString();
                             this.ddlunidadDestino.SelectedValue = objBE.almacenDestino.ToString();
                             ddlUnidadOrigen.Enabled = false;
                             this.ddlunidadDestino.Enabled = false;
                         }
                         catch { 
                         
                         }
                     }

                    
                    break;
                default:
                    break;
            }



        }

        
        //CAMBIO//08//
        private void CargarNota()
        {


            String operacion = Request.QueryString["Operacion"];
            Enumeraciones.TipoOperacion tipoOperacion = (Enumeraciones.TipoOperacion)Enum.Parse(typeof(Enumeraciones.TipoOperacion), operacion, true);

            TipoOperacionActual = tipoOperacion;
            switch (tipoOperacion)
            {
                case Enumeraciones.TipoOperacion.Creacion:
                    ucwDatosDetalle.CargarNotasInicial(Convert.ToInt32(hddCodigo.Value), Enumeraciones.TipoOperacion.Creacion);
                    break;
                case Enumeraciones.TipoOperacion.Modificacion:
                    ucwDatosDetalle.CargarNotasInicial(Convert.ToInt32(hddCodigo.Value), Enumeraciones.TipoOperacion.Creacion);
                    break;
                case Enumeraciones.TipoOperacion.Consulta:
                    //carga el listado enviado.
                    TipoOperacionActual = Enumeraciones.TipoOperacion.Creacion;
                     // List<ENotaIngresoSalidaDetalle> Lista_ENotaDetalle = new List<ENotaIngresoSalidaDetalle>();

                      frmRegistroNotaIO frm = new frmRegistroNotaIO();
                      //frm.ListaENotaISDetalle; 

                      //Lista_ENotaDetalle= (List<ENotaIngresoSalidaDetalle>)Session["listado"];
                    //  var list = (List<ENotaIngresoSalidaDetalle>)Request.QueryString["listado"];

                      ucwDatosDetalle.CargarNotasSeleccionadas(frm.ListaENotaISDetalle, Enumeraciones.TipoOperacion.Consulta);
                    
                    break;

                default:
                    break;

            }

        }
        private void Grabar()
        {
            String MensajeRespuesta = "";

           // String operacion = Request.QueryString["Operacion"];
            //Enumeraciones.TipoOperacion tipoOperacion = (Enumeraciones.TipoOperacion)Enum.Parse(typeof(Enumeraciones.TipoOperacion), operacion, true);

            List<ENotaIngresoSalidaDetalle> objENotaDetalle = ucwDatosDetalle.ObtenerNotaISDetalles();

            int codPedido;

            if (txtCodigoPedido.Text == "")
            {
                codPedido = 0;
            }
            else {
                string codPedidoCon = Request.QueryString["Codigo"];
                codPedido = Convert.ToInt32(txtCodigoPedido.Text); 
            }

            ENotaIngresoSalida objENota = new ENotaIngresoSalida()
            {
                NotaISDetalle= objENotaDetalle,
                CodunidDestino=Convert.ToInt32(ddlunidadDestino.SelectedValue),
                CodunidOrigen= Convert.ToInt32(ddlUnidadOrigen.SelectedValue),
                empleado=txtEmpleado.Text,
                periodo= txtPeriodo.Text,
                tipoDocumento= ddlTipoDocumento.SelectedValue,
                transTipo= ddlTransferencia.SelectedValue,
                referNumDoc= txtNumRefDoc.Text,
                //referTipo= ddlRefencia.SelectedValue,
                fecha= Convert.ToDateTime(txtFecha.Text),
                CodPedido = codPedido,
                
            };

            BLNotaPedido objBLNota = new BLNotaPedido(); 
            

            //TipoOperacionActual = tipoOperacion;
            switch (TipoOperacionActual)
            {
                case Enumeraciones.TipoOperacion.Creacion:

                    if (ucwDatosDetalle.CantidadNotas() == false)
                    {
                        MessageBox(this, "Debe ingresar por lo menos un producto para registrar la Nota de Ingreso/Salida");
                        return; 
                    }
                    else {
                        objBLNota.Insertar(objENota);
                        //this.Inicio();
                        hddCodigo.Value = Request.QueryString["Correlativo"];
                        this.CargarNota();


                        MensajeRespuesta = "Se registro Correctamente.";
                        FunctionScript(this, string.Format("MensajeRegistroExito('{0}');", MensajeRespuesta));
                    }

                    
                    

                    break;

                case Enumeraciones.TipoOperacion.Modificacion:

                    string codNota = Request.QueryString["Correlativo"];
                    objENota.CodigoIS = Convert.ToInt32(codNota);

                    objBLNota.Actualizar(objENota);

                    //this.Inicio();
                    // hddCodigo.Value = Request.QueryString["Correlativo"];
                    this.CargarNota();


                    MensajeRespuesta = "Se modifico correctamente.";
                    FunctionScript(this, string.Format("MensajeRegistroExito('{0}');", MensajeRespuesta));


                    break;
                default:
                    break;
            }



        }

        public void FunctionScript(Control pPage, String funcion)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), DateTime.Now.Ticks.ToString(), String.Format("setTimeout(\"{0}\", 0);", funcion), true);
        }

        private void AsignarMensajesValidacion()
        {
            //cvddlRefencia.ErrorMessage = "Seleccione el Tipo de Referencia";
            cvddlunidadDestino.ErrorMessage = "Seleccione la Unidad Destino";
            cvUnidadOrigen.ErrorMessage = "Seleccione la Unidad Origen";
            cvTranferencia.ErrorMessage = "Seleccione la Tranferencia Tipo";
            cvTipoDocumento.ErrorMessage = "Seleccione el Tipo de Documento"; 
            //cvNumRefDoc.ErrorMessage="Ingrese el N"
            rfvPeriodo.ErrorMessage = "Ingrese el Periodo";
            rvEmpleado.ErrorMessage = "Ingrese el Empleado"; 
            

        }

        public void MessageBox(Page pPage, String strMensaje)
        {
            ToolkitScriptManager.RegisterStartupScript(pPage, pPage.GetType(), String.Empty,
                String.Format("setTimeout(\"alert('{0}');\", 0);", strMensaje), true);
        }

        #region Eventos
        protected void ucwGrabarCerrar_OnGrabar(object sender, EventArgs e)
        {
            try
            {
                this.Grabar();
            }
            catch (Exception arex)
            {
               
                MessageBox(this.Page, arex.Message);
            }
        }

        protected void ucwGrabarCerrar_OnCerrar(object sender, EventArgs e)
        {
            Response.Redirect("~/Interfaces/Registros/frmRegistroNotaIO.aspx");
        }


        #endregion

        private void AddScripts()
        {
            this.txtPeriodo.Attributes.Add("onkeypress", "return FP_SoloNumeros(event);");
           

        }


        #region Cantidad  para validacion
        private void AsignarEventosValidacion()
        {
            ucwDatosDetalle.CantidadChangedNota += new ucwDatosDetalle.CantidadEventHandler(ucwDatosNotaDetalle_Cantidad);
       
        }

        void ucwDatosNotaDetalle_Cantidad(ucwDatosDetalle.CantidadEventArgs Cantidad)
        {
            hddCantidadNotaDetalle.Value = Cantidad.objCantidadNotas.ToString();
        }
       

        #endregion

        private void AsignarEventoControles()
        {
            this.ucwGrabarCerrar.OnGrabar += new EventHandler(ucwGrabarCerrar_OnGrabar);
            this.ucwGrabarCerrar.OnCerrar += new EventHandler(ucwGrabarCerrar_OnCerrar);
            
        }
        public void Bind(Object values, string valuefield, string textfield, DropDownList ddl)
        {
            ddl.DataSource = values;
            ddl.DataValueField = valuefield.Trim();
            ddl.DataTextField = textfield;
            ddl.DataBind();
        }

        public void LlenarComboUnidadNegocio(DropDownList ddl)
        {

            BLNotaPedido objNotaPedido = new BLNotaPedido();

            Bind(objNotaPedido.ListarUnidadNegocio(), "codigo", "Nombre", ddl);
            ddl.Items.Insert(0, new ListItem("--Seleccione--", "-1"));


        }

        public void LlenarComboUnidadNegocioP(DropDownList ddl)
        {

            BLNotaPedido objNotaPedido = new BLNotaPedido();

            Bind(objNotaPedido.ListarUnidadNegocioP(), "codigo", "Nombre", ddl);
            ddl.Items.Insert(0, new ListItem("--Seleccione--", "-1"));


        }

        protected void btnCargarporPedido_Click(object sender, EventArgs e)
        {
            if (this.txtCodigoPedido.Text.Trim() == "")
            {
                MessageBox(this, "Ingrese el numero de pedido");
            }
            else 
            {
                try
                {
                    ucwDatosDetalle.CargarNotasporPedido(Convert.ToInt32(this.txtCodigoPedido.Text));

                    //verifico si hay datos

                            BLNotaPedido objBL = new BLNotaPedido();
                            ENotaPedido objBE = new ENotaPedido();
                            objBE = objBL.GetNP(Convert.ToInt32(this.txtCodigoPedido.Text));
                            ddlUnidadOrigen.SelectedValue = objBE.almacenOrigen.ToString();
                            this.ddlunidadDestino.SelectedValue = objBE.almacenDestino.ToString();
                            ddlUnidadOrigen.Enabled = false;
                            this.ddlunidadDestino.Enabled = false;
                        

                }
                catch
                {
                    MessageBox(this, "No se puede cargar el pedido");
                }

            }

            
        }

        protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
        {


            cargar_tipotransferencia();
        }

        private void cargar_tipotransferencia()
        {
            ddlTransferencia.Items.Clear();

            if (ddlTipoDocumento.SelectedValue == "NI")
            {
                ddlTransferencia.Items.Insert(0, new ListItem("Ingreso de Proveedor", "IP"));
                ddlTransferencia.Items.Insert(0, new ListItem("Ingreso por Terceros", "IT"));
                ddlTransferencia.Items.Insert(0, new ListItem("--Seleccione--", "-1"));
                ddlTransferencia.SelectedValue = "-1";
            }

            if (ddlTipoDocumento.SelectedValue == "NS")
            {
                ddlTransferencia.Items.Insert(0, new ListItem("Salida a Terceros", "ST"));
                ddlTransferencia.SelectedValue = "ST";
            }
        }

        protected void ddlTransferencia_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTransferencia.SelectedValue == "ST" || ddlTransferencia.SelectedValue == "IT")
            {
                txtCodigoPedido.ReadOnly = false;
                btnCargarporPedido.Visible = true;
            }
            else
            {
                txtCodigoPedido.ReadOnly = true;
                btnCargarporPedido.Visible = false;
            }

            if (ddlTransferencia.SelectedValue == "IP")
            {
                if (ddlUnidadOrigen.SelectedIndex >= 0)
                    ddlUnidadOrigen.Items[ddlUnidadOrigen.SelectedIndex].Selected = false;
                ddlUnidadOrigen.Items.FindByText("Proveedor").Selected = true;
                ddlUnidadOrigen.Enabled = false;
            }
            else
            {
                ddlUnidadOrigen.SelectedValue = "-1";
                ddlUnidadOrigen.Enabled = true;
            }

        }
    }
}