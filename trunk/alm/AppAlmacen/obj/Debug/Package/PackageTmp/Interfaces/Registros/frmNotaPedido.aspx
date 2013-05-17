<%@ Page Title="Registro Nota Pedido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmNotaPedido.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmNotaPedido" %>
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
        window.location = "../../Default.aspx";
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
           Fecha Solicitud:
           </td>
           <td>
               <asp:TextBox ID="txtFechaElabora2" runat="server" ReadOnly="true"></asp:TextBox>
               <asp:HiddenField ID="txtFechaElabora3" runat="server" />
           </td>
               <td>
                   &nbsp;</td>
               <td>
                   &nbsp;</td>
           </tr>
            
            <tr>
                <td>
                    Area Solicitante:</td>
                <td>
                
                    <asp:TextBox ID="txtAreaSolicitante" runat="server"></asp:TextBox>
                
                    &nbsp;(*)</td>
               
                <td>
                    &nbsp;</td>
                <td>
                    <asp:HiddenField ID="btnOculto" runat="server" /><asp:HiddenField ID="txtProductoSel" runat="server" /><asp:HiddenField ID="txtProductoSelDes" runat="server" /></td>
               
            </tr>
          
                <tr>
                    <td>
                        Unidad de Negocio:</td>
                    <td>
                        <asp:DropDownList ID="cboUN" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Producto :</td>
                    <td>
                        <asp:TextBox ID="txtNomProducto" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnBuscar" runat="server"
                            Text="Buscar" onclick="btnBuscar_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNuevoPedido" runat="server"
                            Text="Nueva Nota de Pedido" onclick="btnNuevoPedido_Click" />
                    </td>
                </tr>
          
        </table>
        <br />
   <div class="container" id="divGrillaProductos" runat="server" visible="true">

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

                        <asp:TemplateField HeaderText="U.Negocio">
                        <ItemTemplate>
                         <asp:Label ID="lblUN" runat="server" Text='<%# Bind("UN") %>' />
                         <asp:Label ID="lblCodUN" runat="server" Text='<%# Bind("CodUN") %>' Visible="false" />
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
                         <asp:Label ID="lblCodMarca" runat="server" Text='<%# Bind("CodMarca") %>' Visible="false" />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                    </Columns>
                </asp:GridView>

                    </div>


<br />
<div>
    <asp:Label ID="lblProductoSel" runat="server" Text=""></asp:Label>
</div>

<br />

<div class="container" id="divGrillaFichas" runat="server" visible="true">

                      <asp:GridView ID="gdvFichas" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/asignar_on.gif" ToolTip="Agregar" />
                                    <asp:Label visible="false" ID="lblItem2" runat="server" Text='<%# Bind("Item") %>' />
                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Item">
                       <ItemTemplate>
                                 <asp:Label ID="lblItem" runat="server" Text='<%# Bind("Item") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Medida">
                        <ItemTemplate>
                         <asp:Label ID="lblMedida" runat="server" Text='<%# Bind("Medida") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Marca">
                        <ItemTemplate>
                         <asp:Label ID="lblMarca" runat="server" Text='<%# Bind("Marca") %>' />
                         <asp:Label ID="lblCodMarca" runat="server" Text='<%# Bind("CodMarca") %>' Visible="true" />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="F.Caducidad">
                        <ItemTemplate>
                         <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("Fecha_Vencimiento", "{0:d}") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                          <asp:TemplateField HeaderText="Cantidad">
                        <ItemTemplate>
                         <asp:Label ID="lblCantidad" runat="server" Text='<%# Bind("Cantidad","{0:0}") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                           <asp:TemplateField HeaderText="P.Unitario">
                        <ItemTemplate>
                         <asp:Label ID="lblPrecio" runat="server" Text='<%# Bind("Precio") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>

                         <asp:TemplateField HeaderText="Total">
                        <ItemTemplate>
                         <asp:Label ID="lblTotal" runat="server" Text='<%# Bind("Total") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                          </asp:TemplateField>


                    </Columns>
                </asp:GridView>

                    </div>
        <br />

         

        <div>
    <asp:Label ID="Label1" runat="server" Text="Detalle de la Nota"></asp:Label>
</div>

<br />
<div class="container" id="divGrillaPedidoDetalle" runat="server" visible="true">

                      <asp:GridView ID="gdvDetalle" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/ico_eliminar.gif" ToolTip="Eliminar" />
                                    <asp:Label visible="false" ID="lblItem2" runat="server" Text='<%# Bind("CodItem") %>' />
                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>


                         <asp:TemplateField HeaderText="Codigo">
                       <ItemTemplate>
                                 <asp:Label ID="lblCodigo" runat="server" Text='<%# Bind("CodProducto") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        
                        </asp:TemplateField>

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
                         <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("descripcion") %>' />
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
                            <asp:TextBox Width="50px" ID="txtCantidad" runat="server" Text='<%# Bind("cantActual","{0:0}") %>'></asp:TextBox>
                            <asp:Label ID="lblCantidadx" runat="server" Text='Max : '/>
                            <asp:Label ID="lblCantidad" runat="server" Text='<%# Bind("cantActual","{0:0}") %>'/>
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
                <asp:Button ID="btnGrabarTodo" runat="server" Text="Grabar" 
                          onclick="btnGrabarTodo_Click"/>
                <asp:Button ID="btnSalirTodo" runat="server" Text="Salir"/>
                    </div>
        </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
