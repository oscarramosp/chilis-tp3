<%@ Page Title="Reporte de Stock" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmReporteStock.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmReporteStock" %>
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
        window.location = "../Registros/frmFichaRegistroProducto.aspx";
    }

    </script>

     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
   
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

   <div class="cajaFormulario">
                 <br />
            <table class="TablaRegistros">
           <tr>
           <td>
           Item:
           </td>
           <td>
           <asp:TextBox ID="txtCodItem" runat="server"></asp:TextBox>
           </td>
               <td>
                   Almacen:</td>
               
               <td>
               <asp:DropDownList ID="cboAlmacen" runat="server">
               </asp:DropDownList></td>
               <td>
                   <asp:Button ID="btnItem" runat="server" Text="Sel. Item" 
                       onclick="btnItem_Click" /> </td>
               <td>
                   <asp:Button ID="btnGenerar" runat="server" Text="Generar" /> </td>
           </tr>
            
            <tr>
                <td>
                    Estado:</td>
                <td>
                
                 <asp:DropDownList ID="cboEstado" runat="server">
                                                    </asp:DropDownList>
                
                    </td>
               
                <td>
                   Factura :
                    </td>
                <td>
                    <asp:TextBox ID="txtFactura" runat="server"></asp:TextBox>
                </td>
               
                <td>
                    <asp:Button ID="btnFamilia" runat="server" Text="Sel.Fam-SubFamilia" 
                        Width="143px" /></td>
               
                <td>
                    <asp:Button ID="btnSalir" runat="server" Text="Salir" Width="61px" />  
                    <asp:HiddenField ID="btnOculto" runat="server" />
                </td>
               
            </tr>
          
        </table>
        <br />
   <div class="container" id="divGrillaProductos" runat="server" visible="true">

                      <asp:GridView ID="gdvReporte" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/ico_aprobado.png" ToolTip="Seleccionar" />
                                    <asp:Label visible="false" ID="lblcodigoPr" runat="server" Text='<%# Bind("codigoPr") %>' />
                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="Código">
                       <ItemTemplate>
                                 <asp:Label ID="lblCod2" runat="server" Text='<%# Bind("codigoPr") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="U.Negocio">
                        <ItemTemplate>
                         <asp:Label ID="lblUN" runat="server" Text='<%# Bind("UN") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Nombre">
                        <ItemTemplate>
                         <asp:Label ID="lblNombre" runat="server" Text='<%# Bind("nombre") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descripcion">
                        <ItemTemplate>
                         <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("descripcion") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Familia">
                        <ItemTemplate>
                         <asp:Label ID="lblFamilia" runat="server" Text='<%# Bind("familia") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                           <asp:TemplateField HeaderText="Marca">
                        <ItemTemplate>
                         <asp:Label ID="lblMarca" runat="server" Text='<%# Bind("marca") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                    </Columns>
                </asp:GridView>

                    </div>


<br />



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
                                       
                                       <div class="container" id="div1" runat="server" visible="true">

                      <asp:GridView ID="gdvListado" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/ico_aprobado.png" ToolTip="Seleccionar" />
                                    <asp:Label visible="false" ID="lblcodigoPr" runat="server" Text='<%# Bind("codigoPr") %>' />
                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="Código">
                       <ItemTemplate>
                                 <asp:Label ID="lblCod2" runat="server" Text='<%# Bind("codigoPr") %>' Visible="true"/>                                
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
        </div>

        

                                </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

