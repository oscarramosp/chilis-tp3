<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"  EnableEventValidation=false AutoEventWireup="true" CodeBehind="frmInventarioFisico.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmInventarioFisico" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<script language="javascript" type="text/javascript">
   
    function ValidarNroActividades(btn) {

        return confirm('¿Está seguro de eliminar el Registro seleccionado?');
    }



</script>
<%@ Register Src="~/Controles/ucwNuevoEditarEliminar.ascx" TagName="ucwNuevoEditarEliminar"
    TagPrefix="uc1" %>
    <%@ Register Src="~/Controles/ucwBuscarLimpiar.ascx" TagName="ucwBuscarLimpiar"
    TagPrefix="uc3" %>
    <%@ Register Src="~/Controles/ucwTituloBandeja.ascx" TagName="ucwTituloBandeja"
    TagPrefix="uc2" %>
    <%@ Register Src="~/Controles/ucwFecha.ascx" TagName="ucwFecha" TagPrefix="uc4" %>

    <script src="../../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="../../Scripts/JScript.js">    
    </script>
    <link href="../../App_Themes/Principal/estilos.css" rel="stylesheet" type="text/css" />
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


    <div>
      <table cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td style="height: 14px; width: 100%">
                                        <div class="EstiloTitulo">
                                            <div class="EstiloTituloBandeja" style="width: 100%">
                                                <uc2:ucwTituloBandeja ID="ucwTituloBandeja" runat="server" />
                                            </div>
                                            <div class="ContenedorBotones">
                                                
                                              
   
 <uc1:ucwNuevoEditarEliminar ID="ucwEdicion" runat="server" OnOnNuevo="OnNuevo" EditarVisible=false EliminarVisible=false />
    <uc3:ucwbuscarlimpiar ID="ucwBuscarLimpiar" runat="server" OnOnBuscar="OnOnBuscar" OnOnExportar="OnOnExportar"  OnOnLimpiar="OnOnLimpiar"  CausesValidationBuscar="false"  CausesValidationExportar="false"  CausesValidationLimpiar="false" />
                             </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>

  <div style="text-align: right">
                </div>
<div class="cajaFormulario">
    
 
        <table class="TablaRegistros">
           
            
            <tr>
                  <td>Fecha Inicio</td>
                    <td>
        <uc4:ucwFecha ID="txtFechaInicio" runat="server" />   </td>
         <td style="width:5px"></td>
                  <td>Fecha Fin</td>
                    <td>
        <uc4:ucwFecha ID="txtFechaFin" runat="server" />    </td>
           <td style="width:5px"></td>
                  <td>Estado</td>

                  <td><asp:DropDownList ID="cboEstado" runat="server" Width="100px">
                </asp:DropDownList></td>
                
                  
            </tr>
          
        </table>
      <div style="text-align: right">
                </div>

     <div class="container">

                      <asp:GridView ID="gdvListado" runat="server" AutoGenerateColumns="False"  
                          DataKeyNames="codigo" onrowediting="gdvListado_RowEditing" 
                          onrowdeleting="gdvListado_RowDeleting"  >
                    <Columns>
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" ImageUrl="~/Imagenes/Iconos/ico_editadetalleregistro.png"
                                    CausesValidation="false" ToolTip="Modificar" />
                                    <asp:Label visible="false" ID="lblCodEdit" runat="server" Text='<%# Bind("codigo") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbDeleteRow" runat="server" CommandName="Delete" CausesValidation="false" ImageUrl="~/Imagenes/Iconos/ico_eliminaregistro.png"
                                    OnClientClick="return ValidarNroActividades(this);" ToolTip="Eliminar" /></ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>

                       
                        <asp:BoundField DataField="codigoPr" HeaderText="Codigo">
                            <HeaderStyle HorizontalAlign="Center" Width="100px"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha">
                            <HeaderStyle HorizontalAlign="Center" Width="100px"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="Referencia" HeaderText="Referencia">
                            <HeaderStyle HorizontalAlign="Center" Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreEstado" HeaderText="Estado">
                            <HeaderStyle HorizontalAlign="Center" Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Responsable" HeaderText="Responsable">
                            <HeaderStyle HorizontalAlign="Center" Width="200px" />
                        </asp:BoundField>
                        
                        
                    </Columns>
                </asp:GridView>

                    </div>

    </div>
    </div>

</asp:Content>
