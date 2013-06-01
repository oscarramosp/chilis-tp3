<%@ Page Title="Consulta Nota Pedido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmCosultaNotaP.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmCosultaNotaP" %>
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
   <table class="TablaRegistros">
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                
                    &nbsp;</td>
               
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
               
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
            </tr>
            <tr>
                <td>
                    Usuario Autorizador:</td>
                <td>
                    <asp:TextBox ID="txtAutorizador" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
          
                <tr>
                    <td>
                        Unidad de Negocio:</td>
                    <td>
                        <asp:DropDownList ID="cboUN" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Button ID="btnBuscar" runat="server" onclick="btnBuscar_Click" 
                            Text="Buscar" />
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
          
        </table>
                 <br />
            
   <div class="container" id="divGrillaPedido" runat="server" visible="true">

                      <asp:GridView ID="gdvPedidos" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/ico_aprobado.png" ToolTip="Seleccionar" />
                                    <asp:Label visible="false" ID="lblcodigo" runat="server" Text='<%# Bind("Codigo") %>' />
                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>

                        
                        <asp:TemplateField HeaderText="Cod.Nota">
                       <ItemTemplate>
                                 <asp:Label ID="lblCorrelativo" runat="server" Text='<%# Bind("Codigo") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center"/>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Fecha Emisión">
                        <ItemTemplate>
                         <asp:Label ID="lblUN" runat="server" Text='<%# Bind("fechaEmision", "{0:d}") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Alm. Origen">
                        <ItemTemplate>
                         <asp:Label ID="lblAlmacenOrigen" runat="server" Text='<%# Bind("desalmacenOrigen") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Alm. Destino (Solicitante)">
                        <ItemTemplate>
                         <asp:Label ID="lblAlmacenDestino" runat="server" Text='<%# Bind("desalmacenDestino") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Area Solicitante">
                        <ItemTemplate>
                         <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("areaSoliciante") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="P.Pedido">
                        <ItemTemplate>
                         <asp:Label ID="lblPrecioPedido" runat="server" Text='<%# Bind("precioPedido") %>'  />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="BtnAprobar" runat="server" CommandName="Aprobar" OnClientClick="return confirm('Seguro desea aprobar esta Nota de Pedido?')"  
                                    ImageUrl="~/Imagenes/Iconos/ico_aprobar.png" ToolTip="Aprobar" CommandArgument='<%# Container.DataItemIndex %>'/>
                             </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>

                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="BtnRechazar" runat="server" CommandName="Rechazar" OnClientClick="return confirm('Seguro desea rechazar esta Nota de Pedido?')" 
                                    ImageUrl="~/Imagenes/Iconos/ico_cancelar.png" ToolTip="Rechazar" CommandArgument='<%# Container.DataItemIndex %>' />
                             </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                       
                        
                    </Columns>
                </asp:GridView>

                    </div>


<br />
<div>
    <asp:Label ID="lblPedidoSel" runat="server" Text=""></asp:Label>
</div>

<br />

<div class="container" id="divGrillaDetalle" runat="server" visible="true">

                      <asp:GridView ID="gdvDetalle" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                        <asp:TemplateField HeaderText="Cod.Ficha">
                       <ItemTemplate>
                                 <asp:Label ID="lblItem" runat="server" Text='<%# Bind("CodItem") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Codigo">
                        <ItemTemplate>
                         <asp:Label ID="lblCodProdCorto" runat="server" Text='<%# Bind("CodigoProducto") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        
                        <asp:TemplateField HeaderText="Descripcion">
                        <ItemTemplate>
                         <asp:Label ID="lblMarca" runat="server" Text='<%# Bind("descripcion") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Medida">
                        <ItemTemplate>
                         <asp:Label ID="lblMedida" runat="server" Text='<%# Bind("medida") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Marca">
                        <ItemTemplate>
                         <asp:Label ID="lblMarca" runat="server" Text='<%# Bind("DesMarca") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="F.Caducidad">
                        <ItemTemplate>
                         <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("fechaCaducidad", "{0:d}") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                          <asp:TemplateField HeaderText="Cantidad">
                        <ItemTemplate>
                         <asp:Label ID="lblCantidad" runat="server" Text='<%# Bind("cantActual") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                           <asp:TemplateField HeaderText="P.Unitario">
                        <ItemTemplate>
                         <asp:Label ID="lblPrecio" runat="server" Text='<%# Bind("precioUnitario") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                         <asp:TemplateField HeaderText="Total">
                        <ItemTemplate>
                         <asp:Label ID="lblTotal" runat="server" Text='<%# Bind("precioTotal") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>


                    </Columns>
                </asp:GridView>

                      <br />
                      <table cellpadding="0" cellspacing="0" class="style1">
                          <tr>
                              <td>
                                  &nbsp;</td>
                              <td style="text-align: right">
                                  <asp:Label ID="lblPrecioTotal" runat="server" Text="Precio Pedido"></asp:Label>
                                  <asp:TextBox ID="txtPrecioPedido" runat="server" 
                                      ReadOnly="True" Width="60px" ></asp:TextBox> </td>
                          </tr>
                      </table>

                    </div>
        <br />
        
         <asp:Button ID="btnSalirTodo" runat="server" Text="Salir" 
        onclick="btnSalirTodo_Click" />

        </div>

        

                                </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

