<%@ Page Title="Ficha Producto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmFichaRegistroProducto.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmFichaRegistroProducto" %>
<%@ Register Src="~/Controles/ucwNuevoEditarEliminar.ascx" TagName="ucwNuevoEditarEliminar"
    TagPrefix="uc1" %>
    <%@ Register Src="~/Controles/ucwBuscarLimpiar.ascx" TagName="ucwBuscarLimpiar"
    TagPrefix="uc3" %>
    <%@ Register Src="~/Controles/ucwTituloBandeja.ascx" TagName="ucwTituloBandeja"
    TagPrefix="uc2" %>
    <%@ Register Src="../../Controles/ucwGrabarCerrar.ascx" TagName="ucwGrabarCerrar"
    TagPrefix="uc7" %>
    <%@ Register Src="~/Controles/ucwAsterisco.ascx" TagName="ucwAsterisco" TagPrefix="uc7" %>
    <%@ Register Src="~/Controles/ucwFecha.ascx" TagName="ucwFecha" TagPrefix="uc6" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script language="javascript" type="text/javascript">

     function ValidaDDL(source, arguments) {
         if (arguments.Value < 1) {
             arguments.IsValid = false;
         } else {
             arguments.IsValid = true;

         }

     }


     function MensajeRegistroExito(mensaje) {
         alert(mensaje);
         window.location = "frmFichaRegistroProducto.aspx";
     }

    </script>

 <asp:UpdatePanel runat="server">
        <ContentTemplate>
   
    <div>
        
      <table cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td style="height: 14px; width: 100%">
                                        <div class="EstiloTitulo">
                                            <div class="EstiloTituloBandeja" style="width: 100%">
                                                <uc2:ucwTituloBandeja ID="ucwTituloBandeja" runat="server" />
                                            </div>
                                            <div class="ContenedorBotones">
    
                                 </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>

  <div style="text-align: right">
                </div>
<div class="cajaFormulario">
                 <br />
            <table class="TablaRegistros">
           <tr>
           <td>
           Código Producto:
           </td>
           <td>
           <asp:TextBox ID="txtCodProducto" runat="server"></asp:TextBox>
           </td>
           </tr>
            
            <tr>
                <td>
                    Nombre Producto:</td>
                <td>
                
                <asp:TextBox ID="txtNomProducto" runat="server"></asp:TextBox>
                    <asp:HiddenField ID="btnOculto" runat="server" />
                              <asp:HiddenField ID="btnOculto2" runat="server" />
                    </td>
               
            </tr>
          
                <tr>
                    <td>
                        Unidad Negocio:</td>
                    <td>
                        <asp:DropDownList ID="cboUNCab" runat="server">
                        </asp:DropDownList>
                        <asp:Button ID="btnBuscar3" runat="server" onclick="btnBuscar_Click" 
                            Text="Buscar" />
                    </td>
                </tr>
          
        </table>

   <table class="TablaRegistros">
           <tr>
           <td>
           Producto Seleccionado :
           </td>
           <td>
               <asp:Label ID="lblSeleccionado" runat="server" Text=""></asp:Label>
               <asp:HiddenField ID="CodSeleccionado" runat="server" />
               <asp:HiddenField ID="IdSeleccionado" runat="server" />
                <asp:Button ID="btnNuevaFicha" runat="server" Text="Nuevo Registro" 
                   onclick="btnNuevaFicha_Click"/>
                                                
           </td>
           </tr>
            
            <tr>
                <td colspan="2">
                    &nbsp;</td>
               
            </tr>
          
        </table>

        </div>
      <div style="text-align: right">
                </div>

                        <div style="text-align: right">
                </div>


            

    </div>

        <cc1:ModalPopupExtender ID="mpeBuscarProducto" runat="server" PopupControlID="pnlBuscarProducto"
        TargetControlID="btnOculto" CancelControlID="btnCerrar" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>
     <asp:Panel ID="pnlBuscarProducto" runat="server" Width="800px">

     <div style="background-color: #FFF8E9; width: 100%;">
            <table style="width: 900px" border="0" cellpadding="0" cellspacing="0">
                <tr style="height: 2px">
                    <td class="emg_header">
                    </td>
                </tr>
                <tr>
                    <td height="20" class="emg_header">
                        <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="18" class="emg_tittle">
                                    Seleccionar Item</td>
                                <td width="24" valign="top">
                                    <asp:ImageButton ID="btnCerrar" runat="server" 
                                        ImageUrl="~/Imagenes/Popup/emg_cerrar.png" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="emg_box">
                        <div class="emg_text">
                            <table class="style1">
                                <tr>
                                    <td>
                                        <table cellpadding="0" cellspacing="1" class="style1">
                                            <tr>
                                                <td>
                                                    Codigo:</td>
                                                <td>
                                                    <asp:TextBox ID="txtItem" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Familia:</td>
                                                <td>
                                                    <asp:TextBox ID="txtFamilia" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Marca:</td>
                                                <td>
                                                    <asp:DropDownList ID="cboMarca" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Nombre:</td>
                                                <td>
                                                    <asp:TextBox ID="txtDescripcion" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Sub-Familia:</td>
                                                <td>
                                                    <asp:TextBox ID="txtSubFamilia" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnBuscar2" runat="server" Text="Buscar" 
                                                        onclick="btnBuscar2_Click" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnCancel" runat="server" Text="Cancelar" 
                                                        onclick="btnCancel_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                       
                                       <div class="container" id="divGrillaProductos" runat="server" visible="true">

                      <asp:GridView ID="gdvListado" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/ico_aprobado.png" ToolTip="Seleccionar" />
                                    <asp:Label visible="false" ID="lblcodigoPr" runat="server" Text='<%# Bind("codigoPr") %>' />
                                    <asp:Label visible="false" ID="lblID" runat="server" Text='<%# Bind("Codigo") %>' />
                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="Código">
                       <ItemTemplate>
                                 <asp:Label ID="lblCod2" runat="server" Text='<%# Bind("Codigo") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nombre">
                        <ItemTemplate>
                         <asp:Label ID="lblNombre" runat="server" Text='<%# Bind("nombre") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Familia">
                        <ItemTemplate>
                         <asp:Label ID="lblFamilia" runat="server" Text='<%# Bind("familia") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="SubFamilia">
                        <ItemTemplate>
                         <asp:Label ID="lblsubfamilia" runat="server" Text='<%# Bind("subfamilia") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>


                    </Columns>
                </asp:GridView>

                    </div>
                                       
                                       </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
     </asp:Panel>

   <cc1:ModalPopupExtender ID="mpeDatosFicha" runat="server" PopupControlID="pnlDatosFicha"
        TargetControlID="btnOculto2" CancelControlID="btnCerrarFicha" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>

    <asp:Panel ID="pnlDatosFicha" runat="server" Width="800px">

     <div style="background-color: #FFF8E9; width: 100%;">
            <table style="width: 900px" border="0" cellpadding="0" cellspacing="0">
                <tr style="height: 2px">
                    <td class="emg_header">
                    </td>
                </tr>
                <tr>
                    <td height="20" class="emg_header">
                        <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="18" class="emg_tittle">
                                    Ingresar Datos de la Ficha</td>
                                <td width="24" valign="top">
                                    <asp:ImageButton ID="btnCerrarFicha" runat="server" 
                                        ImageUrl="~/Imagenes/Popup/emg_cerrar.png" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="emg_box">
                        <div class="emg_text">
                            <table class="style1">
                                <tr>
                                    <td>
                                        
                                        <table cellpadding="0" cellspacing="1" class="style1">
                                            <tr>
                                                <td>
                                                    Item:</td>
                                                <td>
                                                    <asp:TextBox ID="txtItemFicha" runat="server" ReadOnly="True"></asp:TextBox>
                                                    <asp:HiddenField ID="txtItemVerdadero" runat="server" />
                                                    <asp:HiddenField ID="txtCodNotaIS" runat="server" />
                                                </td>
                                                <td>
                                                    Lote:</td>
                                                <td>
                                                    <asp:TextBox ID="txtLoteFicha" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Serie:</td>
                                                <td>
                                                    <asp:TextBox ID="txtSerieFicha" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Descripción:</td>
                                                <td>
                                                    <asp:TextBox ID="txtDescripcionFicha" runat="server" ReadOnly="True"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Cantidad:</td>
                                                <td>
                                                    <asp:TextBox ID="txtCantidadFicha" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Precio:</td>
                                                <td>
                                                    <asp:TextBox ID="txtPrecioFicha" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Medida:</td>
                                                <td>
                                                    <asp:TextBox ID="txtMedidaFicha" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    F. Elaboración:</td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaElabora" runat="server" Width="70px" CssClass="textbox" MaxLength="10"></asp:TextBox><cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFechaElabora"></cc1:CalendarExtender> </td>
                                                <td>
                                                    F.Recepción:</td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaRecep" runat="server" Width="70px" CssClass="textbox" MaxLength="10"></asp:TextBox><cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFechaRecep"></cc1:CalendarExtender> </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    F. Vencimiento:</td>
                                                <td>
                                                        <asp:TextBox ID="txtFechaVenci" runat="server" Width="70px" CssClass="textbox" MaxLength="10"></asp:TextBox><cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtFechaVenci"></cc1:CalendarExtender> </td>
                                                <td>
                                                    Tipo:</td>
                                                <td>
                                                      <asp:TextBox ID="txtTipoFicha" runat="server"></asp:TextBox>
                                                      </td>
                                                                    </td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                      
                                                                    </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    <asp:Button ID="btnOK" runat="server" Text="OK" onclick="btnOK_Click" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnCancelarFicha" runat="server" Text="Cancelar" 
                                                        onclick="btnCancelarFicha_Click" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="cboUN" runat="server" Visible="False">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                        
                                    </td>
                                </tr>
                                </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
     </asp:Panel>

      <div class="container" id="divGrillaFichas" runat="server" visible="true">

                      <asp:GridView ID="gdvFichas" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/ico_eliminar.gif" ToolTip="Eliminar" />
                                    <asp:Label visible="false" ID="lblcodigo" runat="server" Text='<%# Bind("Codigo") %>' />
                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="Cod.Ficha">
                       <ItemTemplate>
                                 <asp:Label ID="lblItem" runat="server" Text='<%# Bind("Item") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Descripcion">
                        <ItemTemplate>
                         <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Lote">
                        <ItemTemplate>
                         <asp:Label ID="lblLote" runat="server" Text='<%# Bind("Lote") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Serie">
                        <ItemTemplate>
                         <asp:Label ID="lblSerie" runat="server" Text='<%# Bind("Serie") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                          <asp:TemplateField HeaderText="Tipo">
                        <ItemTemplate>
                         <asp:Label ID="lblTipo" runat="server" Text='<%# Bind("Tipo") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                           <asp:TemplateField HeaderText="Cantidad">
                        <ItemTemplate>
                         <asp:Label ID="lblCantidad" runat="server" Text='<%# Bind("Cantidad") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                         <asp:TemplateField HeaderText="Medida">
                        <ItemTemplate>
                         <asp:Label ID="lblMedida" runat="server" Text='<%# Bind("Medida") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>


                            <asp:TemplateField HeaderText="F.Recepcion">
                        <ItemTemplate>
                         <asp:Label ID="lblRecepcion" runat="server" Text='<%# Bind("Fecha_Recepcion", "{0:d}") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                            <asp:TemplateField HeaderText="F.Elaboracion">
                        <ItemTemplate>
                         <asp:Label ID="lblElaboracion" runat="server" Text='<%# Bind("Fecha_Elaboracion", "{0:d}") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                            <asp:TemplateField HeaderText="F.Vencimiento">
                        <ItemTemplate>
                         <asp:Label ID="lblVencimiento" runat="server" Text='<%# Bind("Fecha_Vencimiento", "{0:d}") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                    </div>
                                       

<div>
    <asp:Button ID="btnGrabarTodo" runat="server" Text="Grabar" 
        onclick="btnGrabarTodo_Click" />
    <asp:Button ID="btnSalirTodo" runat="server" Text="Salir" 
        onclick="btnSalirTodo_Click" />

</div>

    </ContentTemplate>
    </asp:UpdatePanel>

   
</asp:Content>
