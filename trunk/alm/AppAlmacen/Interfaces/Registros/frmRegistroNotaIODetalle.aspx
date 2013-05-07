<%@ Page Title="Nota de Pedido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmRegistroNotaIODetalle.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmRegistroNotaIODetalle" %>

<%@ Register Src="~/Controles/ucwNuevoEditarEliminar.ascx" TagName="ucwNuevoEditarEliminar"
    TagPrefix="uc1" %>
    <%@ Register Src="~/Controles/ucwBuscarLimpiar.ascx" TagName="ucwBuscarLimpiar"
    TagPrefix="uc3" %>
    <%@ Register Src="~/Controles/ucwTituloBandeja.ascx" TagName="ucwTituloBandeja"
    TagPrefix="uc2" %>
    <%@ Register Src="../../Controles/ucwGrabarCerrar.ascx" TagName="ucwGrabarCerrar"
    TagPrefix="uc7" %>
    <%@ Register Src="~/Controles/ucwDatosDetalle.ascx" TagName="ucwDatosDetalle"
    TagPrefix="uc14" %>

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
         window.location = "../Registros/frmRegistroNotaIO.aspx";
     }

    </script>

     <div class="EstiloTitulo">
                                            <div class="EstiloTituloBandeja" style="width: 100%">
                                                <uc2:ucwTituloBandeja ID="ucwTituloBandeja" runat="server" />
                                            </div>
 <div class="ContenedorBotones">
 <asp:UpdatePanel runat="server">
 <ContentTemplate>
     <uc7:ucwGrabarCerrar ID="ucwGrabarCerrar" runat="server" VisibleModificar="false"
        ValidationGroup="GrupoNotaPedido" />
        </ContentTemplate></asp:UpdatePanel>
        </div>

        </div>
 <div class="cajaFormulario">

       <table style="width: 100%">
                    <tr>
                        
                        <td style="width: 15%">
                            Código Nota Pedido:
                        </td>
                        <td style="width: 25%">
                            <asp:Label ID="lblCodigoPedido" runat="server" SkinID="SoloLectura"></asp:Label>
                        </td>
                       
                    </tr>
                    <tr>

                     <td style="width: 15%">
                            Tipo de Documento:</td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="ddlTipoDocumento" runat="server" Height="16px" 
                                Width="202px"  CauseValidation="true" AsteriscoError="False" 
                                ValidationGroup="GrupoNotaPedido">
                                <asp:ListItem Value="-1">--Seleccione--</asp:ListItem>
                                <asp:ListItem Value="NI">Nota de Ingreso</asp:ListItem>
                                <asp:ListItem Value="NS">Nota de Salida</asp:ListItem>
                            </asp:DropDownList>
                             <uc7:ucwasterisco ID="UcwasteriscoTPdoc" runat="server" />
                             <asp:CustomValidator ID="cvTipoDocumento" runat="server" ClientValidationFunction="ValidaDDL"
                                            ControlToValidate="ddlTipoDocumento"
                                            ValidationGroup="GrupoNotaPedido" SetFocusOnError="True" Display="None"></asp:CustomValidator>
                        </td>

                      
                       
                    </tr>

                    <tr>                                      
                         <td style="width: 8%">
                            Unidad Origen:
                        </td>
                        <td style="width: 5%" >
                            <asp:DropDownList ID="ddlUnidadOrigen" runat="server" 
                               CauseValidation="true" AsteriscoError="False" 
                                ValidationGroup="GrupoNotaPedido" Height="16px" Width="158px"></asp:DropDownList>
                         <uc7:ucwasterisco ID="Ucwddluniori" runat="server" />
                                   <asp:CustomValidator ID="cvUnidadOrigen" runat="server" ClientValidationFunction="ValidaDDL"
                                            ControlToValidate="ddlUnidadOrigen"
                                            ValidationGroup="GrupoNotaPedido" SetFocusOnError="True" Display="None"></asp:CustomValidator>
                       </td>
                       <td style="width: 8%">
                            Unidad Destino:
                        </td>
                        <td style="width: 5%" >
                            <asp:DropDownList ID="ddlunidadDestino" runat="server" 
                               CauseValidation="true" AsteriscoError="False" 
                                ValidationGroup="GrupoNotaPedido" Height="19px" Width="168px"></asp:DropDownList>
                         <uc7:ucwasterisco ID="Ucwasterisco1" runat="server" />
                                   <asp:CustomValidator ID="cvddlunidadDestino" runat="server" ClientValidationFunction="ValidaDDL"
                                            ControlToValidate="ddlunidadDestino"
                                            ValidationGroup="GrupoNotaPedido" SetFocusOnError="True" Display="None"></asp:CustomValidator>
                       </td>
                    
                    </tr>
                    <tr>
                      <td>
                                                                Fecha:
                                                            </td>
                                                            <td>
                                                                <uc6:ucwFecha ID="txtFecha" runat="server" ValidationGroup="GrupoNotaPedido" ErrorMessage="Ingrese la Fecha de la Nota de I/S"
                                                                    CauseValidation="true" />                                                                
                                                            </td>
<td>
                                                                Periodo:
                                                            </td>
                          
                        <td>
                         <asp:TextBox id="txtPeriodo" runat="server" Width="29%"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvPeriodo" runat="server" Display="None" ValidationGroup="GrupoNotaPedido"
                                            ControlToValidate="txtPeriodo" SetFocusOnError="True" />
                                             <uc7:ucwasterisco ID="ucwAstPeriodo" runat="server" />
                        </td>                 

                    </tr>
                  
                   
                    <tr>

                     <td style="width: 15%">
                            Transferencia Tipo:</td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="ddlTransferencia" runat="server" Height="16px" 
                                Width="147px"  CauseValidation="true" AsteriscoError="False" 
                                ValidationGroup="GrupoNotaPedido">
                                <asp:ListItem Value="-1">--Seleccione--</asp:ListItem>
                                <asp:ListItem Value="IP">Ingreso de Proveedor</asp:ListItem>
                                <asp:ListItem Value="IT">Ingreso por Terceros</asp:ListItem>
                                <asp:ListItem Value="ID">Ingreso por devolución</asp:ListItem>
                                <asp:ListItem Value="IR">Ingreso por regularización</asp:ListItem>
                                <asp:ListItem Value="ST">Salida a Terceros</asp:ListItem>
                                <asp:ListItem Value="SD">Salida por devolución</asp:ListItem>
                                <asp:ListItem Value="SR">Salida por regularizacion</asp:ListItem>
                           
                            </asp:DropDownList>
                             <uc7:ucwasterisco ID="Ucwasterisco2" runat="server" />
                             <asp:CustomValidator ID="cvTranferencia" runat="server" ClientValidationFunction="ValidaDDL"
                                            ControlToValidate="ddlTransferencia"
                                            ValidationGroup="GrupoNotaPedido" SetFocusOnError="True" Display="None"></asp:CustomValidator>
                        </td>

                      
                      <td style="width: 15%">
                            Referencia Tipo:</td>
                        <td style="width: 25%">
                            <asp:DropDownList ID="ddlRefencia" runat="server" Height="16px" Width="154px"  
                                CauseValidation="true" AsteriscoError="False" ValidationGroup="GrupoNotaPedido">
                                <asp:ListItem Value="-1">--Seleccione--</asp:ListItem>
                                <asp:ListItem Value="GR">Guia de Remisión</asp:ListItem>
                                <asp:ListItem Value="NI">Nota de Ingreso</asp:ListItem>
                                <asp:ListItem Value="NS">Nota de Salida</asp:ListItem>
                              
                            </asp:DropDownList>
                             <uc7:ucwasterisco ID="Ucwasterisco3" runat="server" />
                             <asp:CustomValidator ID="cvddlRefencia" runat="server" ClientValidationFunction="ValidaDDL"
                                            ControlToValidate="ddlRefencia"
                                            ValidationGroup="GrupoNotaPedido" SetFocusOnError="True" Display="None"></asp:CustomValidator>
                        </td>
                       
                    </tr>

                     <tr>
                    
                                <td>Empleado:</td>
                          
                        <td>
                         <asp:TextBox id="txtEmpleado" runat="server" Width="91%"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rvEmpleado" runat="server" Display="None" ValidationGroup="GrupoNotaPedido"
                                            ControlToValidate="txtEmpleado" SetFocusOnError="True" />
                                             <uc7:ucwasterisco ID="Ucwasterisco5" runat="server" />
                        </td>                 

                    </tr>

                    <tr id="trReNumDoc" runat="server" visible="false">
                    
                                <td>Referencia Núm Doc.:</td>
                          
                        <td>
                         <asp:TextBox id="txtNumRefDoc" runat="server" Width="30%"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="cvNumRefDoc" runat="server" Display="None" ValidationGroup="GrupoNotaPedido"
                                            ControlToValidate="txtNumRefDoc" SetFocusOnError="True" />
                                             <uc7:ucwasterisco ID="Ucwasterisco4" runat="server" />
                        </td>                 

                    </tr>

                </table>
  </div>
  
  <div class="container">
  
   <div class="cajaFormularioSeccion" style="height: 260px">
                 <asp:UpdatePanel ID="uppData" runat="server">
                     <ContentTemplate>
                                <uc14:ucwDatosDetalle ID="ucwDatosDetalle" runat="server" />
                            
</ContentTemplate>
</asp:UpdatePanel></div>

   <br />
      
    <asp:ValidationSummary ID="validacionesDatos" runat="server" ShowMessageBox="True" Enabled="true"
            ShowSummary="False" ValidationGroup="GrupoNotaPedido" />
        <asp:UpdatePanel runat="server" ID="uppHidden">
            <ContentTemplate>
                <asp:HiddenField ID="hddCodigo" runat="server" Value="0" />               
                <asp:HiddenField ID="hddCantidadNotaDetalle" runat="server" Value="False" />
                  <asp:HiddenField ID="hddMensajeNotaDetalle" runat="server" Value="False" />
                   </ContentTemplate>
        </asp:UpdatePanel>
  </div>



</asp:Content>
