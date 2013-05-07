<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="True" CodeBehind="frmInventarioFisicoDetalle.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmInventarioFisicoDetalle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<%@ Register Src="~/Controles/ucwNuevoEditarEliminar.ascx" TagName="ucwNuevoEditarEliminar"
    TagPrefix="uc1" %>
    <%@ Register Src="~/Controles/ucwBuscarLimpiar.ascx" TagName="ucwBuscarLimpiar"
    TagPrefix="uc3" %>
    <%@ Register Src="~/Controles/ucwTituloBandeja.ascx" TagName="ucwTituloBandeja"
    TagPrefix="uc2" %>
    <%@ Register Src="~/Controles/ucwAsterisco.ascx" TagName="ucwAsterisco" TagPrefix="uc7" %>
    <script src="../../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="../../Scripts/JScript.js">    
    </script>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
    <link href="../../App_Themes/Principal/estilos.css" rel="stylesheet" type="text/css" />
    <%@ Register Src="~/Controles/ucwFecha.ascx" TagName="ucwFecha" TagPrefix="uc4" %>
   
   <%@ Register Src="../../Controles/ucwGrabarCerrar.ascx" TagName="ucwGrabarCerrar"
    TagPrefix="uc7" %>

    <script type="text/javascript">


        function ValidarTerminado() {
            if (document.getElementById("MainContent_chkTerminado").checked) {
                if (confirm("Inventario terminado")) {
                    return true;
                } else {
                return false;
                }
            }
            return true;
    }
    </script>


     <uc7:ucwGrabarCerrar ID="ucwGrabarCerrar" runat="server" VisibleModificar="false" OnOnGrabar="OnGrabar" OnOnCerrar="OnCerrar" OnClikScriptGrabar="javascript:return ValidarTerminado()"
        ValidationGroup="GrupoNotaPedido" />

<asp:UpdatePanel runat="server" ID="updContenedor" UpdateMode="Conditional">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <div class="cajaFormulario">
                            <table style="width: 100%">
                                <tr style="display:none">
                                    <td>Codigo </td>
                                    <td>
                                        <asp:TextBox ID="txtCodigo" runat="server" MaxLength="12" Width="200px" BorderStyle="None" ></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td>
                                     </td>
                                     
                                </tr>
                                <tr>
                                    <td>Referencia </td>
                                    <td>
                                        <asp:TextBox ID="txtReferencia" runat="server" MaxLength="150" Width="200px" BorderStyle="None" ></asp:TextBox><uc7:ucwasterisco ID="Ucwasterisco1" runat="server" />
                                    </td>
                                    <td>Fecha</td>
                                    <td>
                                       <uc4:ucwFecha ID="txtFecha" runat="server" /> <uc7:ucwasterisco ID="Ucwasterisco3" runat="server" /></td>
                                     
                                </tr>
                                <tr>
                                    <td>Responsable </td>
                                    <td colspan=3>
                                        <asp:TextBox ID="txtResponsable" runat="server" MaxLength="150" Width="200px" BorderStyle="None" ></asp:TextBox>
                                        <uc7:ucwasterisco ID="Ucwasterisco4" runat="server" />
                                    </td>
                                    <td><asp:CheckBox ID="chkTerminado" Text="Terminado" runat="server" /> </td>
                                     
                                </tr>
             
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                <td>
                <div>
                        <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="False" DataKeyNames="codigo"
                                                    OnRowCancelingEdit="gvDetalle_RowCancelingEdit" OnRowEditing="gvDetalle_RowEditing"
                                                    OnRowUpdating="gvDetalle_RowUpdating" OnPageIndexChanging="gvDetalle_PageIndexChanging"
                                                    OnRowCommand="gvDetalle_RowCommand" 
                            ShowFooter="True" OnRowDeleting="gvDetalle_RowDeleting"
                                                    AllowPaging="True" PageSize="50"
                            Width="850px">
                                                    <Columns>
                                                        
                                                        <asp:TemplateField HeaderText="Item">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblItem" Style="text-align: center"  runat="server" Text='<%# Bind("item") %>'              Width="40"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                 <asp:Label ID="lblItem" Style="text-align: center"  runat="server" Text='<%# Bind("item") %>'              Width="40"></asp:Label>
                                                         
                                                            </EditItemTemplate>
                                                           <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" Width="40px" />
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="40px" />
                                                        </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Producto" SortExpression="Producto">
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtcodProductoE"  runat="server" 
                                                                    Width="50px"   Style="text-align: left" Text='<%# Eval("codigoPr") %>'></asp:TextBox>                                                            
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="txtcodProducto"  runat="server" 
                                                                    Width="50px"   Style="text-align: left" ></asp:TextBox>
                                                            </FooterTemplate>
                                                            <ItemTemplate>
                                                                   <asp:TextBox ID="txtcodProducto"  runat="server" Text='<%# Eval("codProducto") %>'
                                                                    Width="50px"   Style="display:none;text-align: left"></asp:TextBox>
                                                                <asp:label ID="txtProducto"  runat="server" Text='<%# Eval("nombreProducto") %>'
                                                                    Width="150px"   Style="text-align: left"></asp:label>  </ItemTemplate>
                                                            <ControlStyle Width="150PX" />
                                                            <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" Width="150px" />
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="150px" />
                                                        </asp:TemplateField>
                                                        
                                                        <asp:TemplateField HeaderText="Cantidad">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblcantidad" Style="text-align: center"  runat="server" Text='<%# Bind("CantidadActual") %>'   Width="60px"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtCantidad" Style="text-align: center"  runat="server" Text='<%# Bind("CantidadActual") %>' Width="60px" ></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="txtCantidad" Style="text-align: center"  runat="server" Text='<%# Bind("CantidadActual") %>'  Width="60px"></asp:TextBox>
                                                            </FooterTemplate>
                                                            <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" Width="60px" />
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="60px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Observaciones">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDescripcion" Style="text-align: center"  runat="server" Text='<%# Bind("descripcion") %>'              Width="200px"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtDescripcion" Style="text-align: center"  runat="server" Text='<%# Bind("descripcion") %>' Width="200px" ></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="txtDescripcion" Style="text-align: center"  runat="server" Text='<%# Bind("descripcion") %>'  Width="200px"></asp:TextBox>
                                                            </FooterTemplate>
                                                            <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" Width="200px" />
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="200px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="200px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Medida">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMedida" Style="text-align: center"  runat="server" Text='<%# Bind("medida") %>'              Width="140"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                               <asp:Label ID="lblMedida" Style="text-align: center"  runat="server" Text='<%# Bind("medida") %>'              Width="140"></asp:Label>
                                                             <asp:TextBox ID="txtMedida" Style="text-align: center;display:none"  runat="server" Text='<%# Bind("medida") %>' Width="140" ></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:Label ID="lblMedida" Style="text-align: center"  runat="server" Text='<%# Bind("medida") %>'              Width="140"></asp:Label>
                                                            <asp:TextBox ID="txtMedida" Style="text-align: center;display:none"  runat="server" Text='<%# Bind("medida") %>'  Width="140"></asp:TextBox>
                                                            </FooterTemplate>
                                                            <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" Width="140px" />
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="140px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="140px" />
                                                        </asp:TemplateField>
                                                      
                                                        <asp:TemplateField HeaderText="Edit" ShowHeader="False">
                                                            <EditItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="true" CommandName="Update"
                                                                    Text="Update" ValidationGroup="EditIt"></asp:LinkButton>
                                                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" CommandName="Cancel"
                                                                    Text="Cancel"></asp:LinkButton>
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="true" CommandName="AddNew"
                                                                    Text="Add New" ValidationGroup="NewFooter"></asp:LinkButton>
                                                            </FooterTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Edit"
                                                                    Text="Edit"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ControlStyle Width="30px" />
                                                            <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" Width="30px" />
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Width="30px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="30px" Wrap="True" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Del" ShowHeader="False">
                                                           <ItemTemplate>
                                                                <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="false" CommandName="Delete" OnClientClick="return confirm('Seguro desea eliminar?')"
                                                                    Text="Del"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ControlStyle Width="30px" />
                                                            <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" Width="30px" />
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Width="30px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="30px" Wrap="True" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False">
                                                        <itemtemplate >
                                                        <asp:Label ID="lblID" Text ='<%#DataBinder.Eval(Container.DataItem, "item")%>' runat="server" /></itemtemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle Wrap="True" />
                                                    <PagerStyle HorizontalAlign="Left" VerticalAlign="Bottom" />
                                                </asp:GridView>
                </div>
                </td>
                </tr>
            </table>
           
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
