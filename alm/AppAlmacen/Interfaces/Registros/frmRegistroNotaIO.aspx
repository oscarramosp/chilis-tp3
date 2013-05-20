<%@ Page Title="Nota de Pedido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmRegistroNotaIO.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmRegistroNotaIO" %>
<%@ Register Src="~/Controles/ucwNuevoEditarEliminar.ascx" TagName="ucwNuevoEditarEliminar"
    TagPrefix="uc1" %>
    <%@ Register Src="~/Controles/ucwBuscarLimpiar.ascx" TagName="ucwBuscarLimpiar"
    TagPrefix="uc3" %>
    <%@ Register Src="~/Controles/ucwTituloBandeja.ascx" TagName="ucwTituloBandeja"
    TagPrefix="uc2" %>

    <%@ Register Src="~/Controles/ucwGrabarCerrar.ascx" TagName="ucwGrabarCerrar" TagPrefix="uc8" %>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="uppData" runat="server">
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
                                                
                                              
   
 <uc1:ucwNuevoEditarEliminar ID="ucwEdicion" runat="server" OnOnNuevo="OnNuevo" EditarVisible="false" EliminarVisible="false" Visible="false" />
    <uc3:ucwbuscarlimpiar ID="ucwBuscarLimpiar" runat="server"  VisibleExportar="false"  Visible="false" />

                             </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>

  <div style="text-align: right">
                </div>
<div class="cajaFormulario">
    
 
        <table class="TablaRegistros">
            <caption>
                <br />
                <tr>
                    <td>
                        Tipo de Operación
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlTipoOperacion" runat="server" AutoPostBack="true" 
                            onselectedindexchanged="ddlTipoOperacion_SelectedIndexChanged">
                            <asp:ListItem Value="0">--Seleccione--</asp:ListItem>
                            <asp:ListItem Value="NI">Nota Ingreso</asp:ListItem>
                            <asp:ListItem Value="NS">Nota Salida</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr ID="trNumPedido" runat="server" visible="false">
                    <td>
                        Número de Pedido:</td>
                    <td>
                        <asp:TextBox ID="txtCodNumPedido" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </caption>
          
        </table>

        </div>
      <div style="text-align: right">
                </div>

     <div class="container" id="divGrillaNotaPedido" runat="server" visible="false">

                      <asp:GridView ID="gdvListado" runat="server" AutoGenerateColumns="False" DataKeyNames="CodigoDetalle">
                    <Columns>
                    
                         <asp:TemplateField>
                            <ItemTemplate>
                               <!-- <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/ico_aprobado.png" ToolTip="Ver" />-->

                                    <asp:CheckBox id="chckSeleccionar" runat="server" />
                                    <asp:Label visible="false" ID="lblCodEdit" runat="server" Text='<%# Bind("CodigoDetalle") %>' />
                                   <asp:Label visible="false" ID="lblcodigo2" runat="server" Text='<%# Bind("CodigoDetalle2") %>' />
                                   <asp:Label visible="false" ID="lblItem" runat="server" Text='<%# Bind("CodItem2") %>' />
                                   <asp:Label visible="false" ID="lblMedida" runat="server" Text='<%# Bind("medida") %>' />
                                   <asp:Label visible="false" ID="lblCantActual" runat="server" Text='<%# Bind("cantActual") %>' />
                                   <asp:Label visible="false" ID="lblPrecioUnit" runat="server" Text='<%# Bind("precioUnitario") %>' />
                                    <asp:Label visible="false" ID="lblPrecioTotal" runat="server" Text='<%# Bind("precioTotal") %>' />

                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>

                       
                        <asp:BoundField DataField="serie" HeaderText="Código" Visible="true">
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CodItem2" HeaderText="Item">
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="medida" HeaderText="Medida">
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DesMarca" HeaderText="Marca">
                        </asp:BoundField>                      
                        <asp:BoundField DataField="fechaCaducidad" HeaderText="Fecha Caducidad">
                        </asp:BoundField>
                        <asp:BoundField DataField="cantActual" HeaderText="Cantidad">
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="precioUnitario" HeaderText="Precio Unitario">
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="precioTotal" HeaderText="Precio Total">
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                      
                    </Columns>
                </asp:GridView>

                  <div style="text-align: right">
                 <asp:ImageButton ID="imbAgregar" runat="server" CausesValidation="false"  
                          ImageUrl="~/Imagenes/Botones/boton_agregar_.gif" 
                         />
                  

                </div>

                    </div>

                  

                     <asp:HiddenField id="codDetalle" runat="server"/>
                    <asp:HiddenField id="codDetalle2" runat="server"/>


    </div>
 
    </ContentTemplate>
    </asp:UpdatePanel>

   

</asp:Content>
