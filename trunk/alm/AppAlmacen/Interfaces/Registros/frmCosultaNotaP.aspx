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
                       
                        <asp:TemplateField HeaderText="Código">
                       <ItemTemplate>
                                 <asp:Label ID="lblCod2" runat="server" Text='<%# Bind("Codigo") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Fecha Emisión">
                        <ItemTemplate>
                         <asp:Label ID="lblUN" runat="server" Text='<%# Bind("fechaEmision", "{0:d}") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        
                        <asp:TemplateField HeaderText="Area Solicitante">
                        <ItemTemplate>
                         <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("areaSoliciante") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
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
                        <asp:TemplateField HeaderText="Item">
                       <ItemTemplate>
                                 <asp:Label ID="lblItem" runat="server" Text='<%# Bind("CodItem") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Medida">
                        <ItemTemplate>
                         <asp:Label ID="lblMedida" runat="server" Text='<%# Bind("medida") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descripcion">
                        <ItemTemplate>
                         <asp:Label ID="lblMarca" runat="server" Text='<%# Bind("descripcion") %>' />
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

                    </div>
        <br />

         <asp:Button ID="btnSalirTodo" runat="server" Text="Salir" 
        onclick="btnSalirTodo_Click" />

        </div>

        

                                </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

