<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucwProductos.ascx.cs"    Inherits="ucwProductos" %>
<%@ Register Src="~/Controles/ucwFecha.ascx" TagName="ucwFecha" TagPrefix="uc1" %>
<%@ Register Src="~/Controles/ucwTituloPopup.ascx" TagName="ucwTituloPopup" TagPrefix="uc7" %>
<%@ Register Src="~/Controles/ucwGrabarCerrar.ascx" TagName="ucwGrabarCerrar" TagPrefix="uc8" %>
 <%@ Register Src="~/Controles/ucwBuscarLimpiar.ascx" TagName="ucwBuscarLimpiar"
    TagPrefix="uc3" %>
<%@ Register Src="ucwAsterisco.ascx" TagName="ucwAsterisco" TagPrefix="uc4" %>
<script language="javascript" type="text/javascript">

   
    function ImgCLick() {
        document.getElementById("ucwProductos_imbAgregar").click();
    }
    function DoScroll() {
        try {
            document.getElementById("DataGridCabecera").style.pixelLeft = -(divScroll.scrollLeft);
        } catch (ex) { }
    }
   </script>
<style type="text/css">
    .Hide
    {
        display: none;
    }
    .style1
    {
        background-color: #06446f;
        width: 826px;
    }
    .style2
    {
        background-color: #FFF;
        padding: 6px;
        border: 2px #06446f solid;
        width: 825px;
    }
    .style3
    {
        background-color: #06446f;
        width: 825px;
    }
</style>

    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
            <asp:HiddenField runat="server" ID="hndCodigoProd" />
                <asp:TextBox runat="server" ID="txtProducto" 
                        onCLick="ImgCLick()"  ></asp:TextBox>
                    <asp:ImageButton ID="imbAgregar" runat="server" CausesValidation="false" style="display:none"  ImageUrl="~/Imagenes/Botones/bot_nuevo_on.gif" />
         
            </td>
        </tr>
    </table>

<div>
  
    <asp:Button ID="btnPhantom" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="mpeActualizarNotaIS" runat="server" PopupControlID="pnlProductos"
        TargetControlID="btnPhantom" CancelControlID="imgCerrar" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlProductos" runat="server" Width="603px">
        <div style="background-color: #FFF8E9; width: 77%;">
            <table style="width: 546px" border="0" cellpadding="0" cellspacing="0">
                <tr style="height: 2px">
                    <td class="style3">
                    </td>
                </tr>
                <tr>
                    <td height="20" class="style3">
                        <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="18" class="emg_tittle">
                                    &nbsp;</td>
                                <td width="24" valign="top">
                                    <a href="#">
                                        <asp:Image ID="imgCerrar" ImageUrl="~/Imagenes/Popup/emg_cerrar.png" runat="server"
                                            Width="18" Height="18" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        <div class="emg_text">
                            <table id="Sub_Tabla" style="width: 100%">
                                <tr>
                                    <td style="height: 14px; width: 100%">
                                        <div class="EstiloTitulo">
                                            <div class="EstiloTituloBandeja" style="width: 100%">
                                                <uc7:ucwTituloPopup ID="ucwTituloBandeja" runat="server" />
                                            </div>
                                            <div class="ContenedorBotones" style="vertical-align: middle">
                                                <table>
                                                    <tr>
                                                        <td>
                                                                <uc3:ucwbuscarlimpiar ID="ucwBuscarLimpiar" runat="server"  VisibleExportar="false" CausesValidationBuscar="false" CausesValidationLimpiar="false"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                           
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                         <div>
                                              <table class="TablaRegistros">
           
            
            <tr>
                  <td>Nombre Producto</td>
                    <td>
        <asp:TextBox runat="server" ID="txtNombre"></asp:TextBox>  </td>
        
                  
            
            </tr>
          
        </table>
        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="upFindProyectoFase" runat="server">
                                            <ContentTemplate>
                                              <table border=0 cellpadding=0 cellspacing=0 >
                                    <tr><td>
                                     <div 
                                                  style=" OVERFLOW: hidden; width:600px" >               
						                     <table ID="DataGridCabecera" border="1" cellpadding="0" cellspacing="0" 
                                                 class="cGrid" style="POSITION:relative;z-index:50;table-layout:inherit" 
                                                 width="500px">
                                                 <tr class="cajaFormulario">
                                                     <td align="center" style="width:200px">
                                                         Nombre</td>
                                                     <td align="center" style="width:200px">
                                                         Descripcion</td>
                                                     <td align="center" style="width:100px">
                                                         opcion</td>
                                                 </tr>
                                             </table>
                                                      </div>

                                                            </td></tr><tr><td>
                                             <div style="OVERFLOW: auto; width:523px; height: 175px;" ID="divScroll" 
                                                 onscroll="DoScroll()" >
				                                 <asp:Panel ID="Panel1div" runat="server" BorderWidth="0" ScrollBars="None">
                                                     <table border="0" cellpadding="0" cellspacing="0" style="table-layout:inherit" 
                                                         width="500px">
                                                         <tr>
                                                             <td>
                                                                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                     <ContentTemplate>
                                                                         <div style="width: 100%">
                                                                             <table ID="tblTablaFases" border="0" cellpadding="0" style="width: 100%">
                                                                                 <tr>
                                                                                     <td style="width: 100%">
                                                                                         <asp:GridView ID="gdvListado" runat="server" AutoGenerateColumns="False" 
                                                                                             DataKeyNames="codigo" onrowcommand="gdvListado_RowCommand" ShowHeader="False">
                                                                                             <Columns>
                                                                                                 <asp:BoundField DataField="Nombre" HeaderText="Nombre">
                                                                                                 <HeaderStyle HorizontalAlign="Center" Width="200px" />
                                                                                                 </asp:BoundField>
                                                                                                 <asp:BoundField DataField="Descripcion" HeaderText="Descripcion">
                                                                                                 <HeaderStyle HorizontalAlign="Center" Width="200px" />
                                                                                                 </asp:BoundField>
                                                                                                 <asp:TemplateField ShowHeader="False">
                                                                                                     <ItemTemplate>
                                                                                                         <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                                                                                             CommandArgument="<%# Container.DataItemIndex %>" CommandName="Select" 
                                                                                                             Text="Select"></asp:LinkButton>
                                                                                                             <asp:Label ID="lblCodigo" runat="server" Text='<%# Bind("codigo") %>' style="display:none"></asp:Label>
                                                                                                     </ItemTemplate>
                                                                                                 <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                                                                 </asp:TemplateField>
                                                                                             </Columns>
                                                                                         </asp:GridView>
                                                                                     </td>
                                                                                 </tr>
                                                                             </table>
                                                                         </div>
                                                                     </ContentTemplate>
                                                                 </asp:UpdatePanel>
                                                             </td>
                                                         </tr>
                                                     </table>
                                                 </asp:Panel>
                                             </div>
                                         
									    
									     
									      </td>
								    </tr>
							    </table>
						    	
					            </ContentTemplate>
					            </asp:UpdatePanel>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
</div>

