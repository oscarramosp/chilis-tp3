<%@ Page Title="Consulta de Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmConsultaProducto.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmConsultaProducto" %>
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
           Código Producto:
           </td>
           <td>
           <asp:TextBox ID="txtCodProducto" runat="server"></asp:TextBox>
           </td>
               <td>
                   Nombre Producto:</td>
               <td>
                   <asp:TextBox ID="txtNomProducto" runat="server"></asp:TextBox></td>
           </tr>
            
            <tr>
                <td>
                    Unidad de Negocio:</td>
                <td>
                
                 <asp:DropDownList ID="cboUN" runat="server">
                                                    </asp:DropDownList>
                
                    </td>
               
                <td>
                   <asp:Button ID="btnBuscar" runat="server" Text="Buscar" onclick="btnBuscar_Click" />
                    </td>
                <td>
                    <asp:HiddenField ID="btnOculto" runat="server" /></td>
               
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
                                 <asp:Label ID="lblCod2" runat="server" Text='<%# Bind("codigo") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="U.Negocio">
                        <ItemTemplate>
                           <asp:Label ID="lblCodUN" runat="server" Text='<%# Bind("CodUN") %>' visible="false"/>
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
<div>
    <asp:Label ID="lblProductoSel" runat="server" Text=""></asp:Label>
</div>

<br />

<div class="container" id="divGrillaFichas" runat="server" visible="true">

                      <asp:GridView ID="gdvFichas" runat="server" AutoGenerateColumns="False" >
                    <Columns>
                        <asp:TemplateField HeaderText="Cod.Ficha">
                       <ItemTemplate>
                                 <asp:Label ID="lblItem" runat="server" Text='<%# Bind("Item") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                        
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descripcion">
                        <ItemTemplate>
                         <asp:Label ID="lblDes" runat="server" Text='<%# Bind("Descripcion") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="U.Negocio">
                        <ItemTemplate>
                         <asp:Label ID="lblUNe" runat="server" Text='<%# Bind("UN") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Left" />
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

         <asp:Button ID="btnSalirTodo" runat="server" Text="Salir" 
        onclick="btnSalirTodo_Click" />

        </div>

        

                                </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
