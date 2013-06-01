<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucwDatosDetalle.ascx.cs"
    Inherits="ucwDatosDetalle" %>
<%@ Register Src="~/Controles/ucwFecha.ascx" TagName="ucwFecha" TagPrefix="uc1" %>
<%@ Register Src="~/Controles/ucwTituloPopup.ascx" TagName="ucwTituloPopup" TagPrefix="uc7" %>
<%@ Register Src="~/Controles/ucwGrabarCerrar.ascx" TagName="ucwGrabarCerrar" TagPrefix="uc8" %>
<%@ Register Src="ucwRegistros.ascx" TagName="ucwRegistros" TagPrefix="uc3" %>
<%@ Register Src="ucwAsterisco.ascx" TagName="ucwAsterisco" TagPrefix="uc4" %>
<script language="javascript" type="text/javascript">
    function ObtenerProducto() {
        eval($("#<%=btnActualiza.ClientID %>").trigger('click'))
    }

    function MostrarModalNotaIS() {
        $find('<%= mpeActualizarNotaIS.ClientID %>').show();
    }

    function ValidarNroActividades(btn) {
         
       return confirm('¿Está seguro de eliminar el Registro seleccionado?');
   }


   function ValidaDDL(source, arguments) {
       if (arguments.Value < 1) {
           arguments.IsValid = false;
       } else {
           arguments.IsValid = true;

       }

   }

   function multiplica() {
       
           var cantidad = parseFloat($("#<%=txtCantActual.ClientID %>").val());
           var precio = parseFloat($("#<%=txtPrecioUnit.ClientID %>").val());
           var total = Math.round(precio * cantidad * 100) / 100;           
           if (isNaN(total)) {
               $("#<%=txtPrecioTotal.ClientID %>").val(0);
           }
           else {
               $("#<%=txtPrecioTotal.ClientID %>").val(total);
           }

       
   }

</script>
<style type="text/css">
    .Hide
    {
        display: none;
    }
</style>
<div class="lblTituloSeccion">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td>
                Lista de Nota de I/S Detalle
            </td>
            <td>
                <div align="right">
                    <asp:ImageButton ID="imbAgregar" runat="server" CausesValidation="false"  ImageUrl="~/Imagenes/Botones/bot_nuevo_on.gif" />
                </div>
            </td>
        </tr>
    </table>
</div>
<div>
    <asp:UpdatePanel ID="uppData" runat="server">
        <ContentTemplate>
            <uc3:ucwRegistros ID="ucwTotal" runat="server" />
            <div style="height: 150px; overflow-y: auto">
                <asp:GridView ID="gdvListado" runat="server" AutoGenerateColumns="False" DataKeyNames="CodigoDetIS"
                    OnRowDataBound="gdvListado_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Modificar" ImageUrl="~/Imagenes/Iconos/ico_editadetalleregistro.png"
                                    CausesValidation="false" ToolTip="Modificar" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbDeleteRow" runat="server" CommandName="Delete" ImageUrl="~/Imagenes/Iconos/ico_eliminaregistro.png"
                                    OnClientClick="return ValidarNroActividades(this);" ToolTip="Eliminar" /></ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Correlativo" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblCorrelativo" runat="server" Text='<%# Bind("CodigoDetIS") %>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CodigoIS" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblCodigoIS" runat="server" Text='<%# Bind("CodigoIS") %>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("CodItem") %>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Descripcion">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcionx" runat="server" Text='<%# Bind("descripcion") %>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cantidad">
                            <ItemTemplate>
                                <asp:Label ID="lblCantidad" runat="server" Text='<%# Bind("cantActual") %>'></asp:Label></ItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Medida">
                            <ItemTemplate>
                                <asp:Label ID="lblMedida" runat="server" Text='<%# Bind("medida") %>'></asp:Label></ItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Precio Unit.">
                            <ItemTemplate>
                                <asp:Label ID="lblPrecioUnit" runat="server" Text='<%# Bind("precioUnitario") %>' /></ItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Precio Total">
                            <ItemTemplate>
                                <asp:Label ID="lblTotal" runat="server" Text='<%# Bind("precioTotal") %>' />
                                <asp:Label ID="lblLote"  visible="false"  runat="server" Text='<%# Bind("lote") %>' />
                                <asp:Label ID="lblSerie"  visible="false"  runat="server" Text='<%# Bind("serie") %>' />
                                <asp:Label ID="lblFechaCaducidad"  visible="false"  runat="server" Text='<%# Bind("fechaCaducidad") %>' />
                                <asp:Label ID="lblFechaElaboracion"  visible="false"  runat="server" Text='<%# Bind("fechaElaboracion") %>' />
                                
                                </ItemTemplate>
<ItemStyle Width="15%" />
                        </asp:TemplateField>
                        
                        
                    </Columns>
                </asp:GridView> 
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Button ID="btnPhantom" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="mpeActualizarNotaIS" runat="server" PopupControlID="pnlNotaISDetalle"
        TargetControlID="btnPhantom" CancelControlID="imgCerrar" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlNotaISDetalle" runat="server" Width="800px">
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
                    <td class="emg_box">
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
                                                            <uc8:ucwGrabarCerrar ID="ucwGrabarCerrar" runat="server" VisibleModificar="false" 
                                                                 ValidationGroup="GrupoNotaISDetalle" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <p>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="upFindProyectoFase" runat="server">
                                            <ContentTemplate>
                                                <div class="cajaFormulario" style="width: 95%">
                                                    <table id="tblTablaFases" style="width: 100%" class="TablaRegistros" cellpadding="0"
                                                        border="0">
                                                        <tr>
                                                            <td style="width: 20%">
                                                                Codigo Item:</td>
                                                            <td>                                                                
                                                             <asp:TextBox ID="txtCodItem" runat="server" MaxLength="20"  ValidationGroup="GrupoNotaISDetalle"></asp:TextBox>
                                                                <asp:ImageButton ID="btnActualiza" runat="server" 
                                                                    ImageUrl="~/Imagenes/Botones/transparente.gif" 
                                                                    onclick="btnActualiza_Click" />
                                                             <asp:RequiredFieldValidator ID="rfvCodItem" runat="server" Display="None" ValidationGroup="GrupoNotaISDetalle"
                                            ControlToValidate="txtCodItem" SetFocusOnError="True" />
                                                            <uc4:ucwAsterisco ID="UcwAsterisco5" runat="server" />
                                                              </td>
                                                            
                                                            <td style="width: 20px">
                                                               Descripción: </td>
                                                            <td style="width: 250px">
                                                                <asp:TextBox ID="txtDescripcion" runat="server" MaxLength="200" ValidationGroup="GrupoNotaISDetalle"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" Display="None" ValidationGroup="GrupoNotaISDetalle"
                                            ControlToValidate="txtDescripcion" SetFocusOnError="True" />
                                                       <uc4:ucwAsterisco ID="UcwAsterisco3" runat="server" />
                                                        </td>
                                                        </tr>

                                                        <tr>
                                                            <td style="width: 20%">
                                                                Cantidad Actual:
                                                            </td>
                                                            <td>
                                                                        <asp:TextBox ID="txtCantActual" runat="server" MaxLength="200" ValidationGroup="GrupoNotaISDetalle"></asp:TextBox>
                                                       <asp:RequiredFieldValidator ID="rfvCantActual" runat="server" Display="None" ValidationGroup="GrupoNotaISDetalle"
                                            ControlToValidate="txtCantActual" SetFocusOnError="True" />
                                                       <uc4:ucwAsterisco ID="UcwAsterisco2" runat="server" />
                                                      
                                                             
                                                                  </td>
                                                            <td style="width: 20px">
                                                            Medida:
                                                            </td>
                                                             <td style="width: 25px">
                                                            <asp:TextBox ID="txtMedida" runat="server"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="rfvMedida" runat="server" Display="None" ValidationGroup="GrupoNotaISDetalle"
                                            ControlToValidate="txtMedida" SetFocusOnError="True" />
                                             <uc4:ucwAsterisco ID="ucwAstDireccion" runat="server" />    
                                                                                                 
                                                            </td>
                                                            

                                                        </tr>
                                                        <tr>

                                                        <td style="width: 20px">
                                                            Lote:
                                                            </td>
                                                            <td style="width: 25px">
                                                            
                                                            <asp:TextBox ID="txtLote" runat="server"></asp:TextBox>
                                                             <asp:RequiredFieldValidator ID="rfvLote" runat="server" Display="None" ValidationGroup="GrupoNotaISDetalle"
                                            ControlToValidate="txtLote" SetFocusOnError="True" />
                                             <uc4:ucwAsterisco ID="UcwAsterisco6" runat="server" />
                                                            </td>

                                                         <td style="width: 20%">
                                                                Serie:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtSerie" runat="server"></asp:TextBox>
                                                             <asp:RequiredFieldValidator ID="rfvSerie" runat="server" Display="None" ValidationGroup="GrupoNotaISDetalle"
                                            ControlToValidate="txtSerie" SetFocusOnError="True" />
                                             <uc4:ucwAsterisco ID="UcwAsterisco4" runat="server" />
                                                            </td>
                                                            
                                                           
                                                        </tr>
                                                        <tr>
                                                           <td>
                                                                Fecha Elaboración:
                                                            </td>
                                                            <td>
                                                                    <asp:TextBox ID="txtFechaElabora" runat="server" Width="70px" CssClass="textbox" MaxLength="10"></asp:TextBox><cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFechaElabora"></cc1:CalendarExtender>                                                               
                                                            </td>

                                                            <td>
                                                                Fecha Caducidad:
                                                            </td>
                                                            <td>
                                                                        <asp:TextBox ID="txtFechaCaducidad" runat="server" Width="70px" CssClass="textbox" MaxLength="10"></asp:TextBox><cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFechaCaducidad"></cc1:CalendarExtender>                                                               
                                                            </td>
                                                           
                                                        </tr>
                                                        <tr>
                                                        <td style="width: 20px">
                                                            Precio Unitario:
                                                            </td>
                                                            <td style="width: 250px">
                                                            
                                                            <asp:TextBox ID="txtPrecioUnit" runat="server"></asp:TextBox>
                                                             <asp:RequiredFieldValidator ID="rfvPrecioUnit" runat="server" Display="None" ValidationGroup="GrupoNotaISDetalle"
                                            ControlToValidate="txtPrecioUnit" SetFocusOnError="True" />
                                             <uc4:ucwAsterisco ID="UcwAsterisco1" runat="server" />
                                                            </td>
                                                            <td style="width: 20px">
                                                            Precio Total:
                                                            </td>
                                                            <td style="width: 250px">
                                                            
                                                            <asp:TextBox ID="txtPrecioTotal" runat="server" ReadOnly="True"></asp:TextBox>
                                                             <asp:RequiredFieldValidator ID="rfvPrecioTotal" runat="server" Display="None" ValidationGroup="GrupoNotaISDetalle"
                                            ControlToValidate="txtPrecioTotal" SetFocusOnError="True" />
                                             <uc4:ucwAsterisco ID="UcwAsterisco7" runat="server" />
                                                            </td>
                                                           
                                                        </tr>
                                                      
                                                     
                                                    </table>
                                                     <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" Enabled="true"
                                                        ShowSummary="False" ValidationGroup="GrupoNotaISDetalle" />
                                                   <asp:HiddenField ID="hddCorrelativo" runat="server" />
                                                    <asp:HiddenField ID="hddActivo" runat="server" />
                                                    <asp:HiddenField ID="hddTipoOperacion" runat="server" />
                                                    <asp:HiddenField ID="hddCorrelativoMaximo" runat="server" />
                                                </div>
                                            </ContentTemplate>
                                               <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="imbAgregar" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="gdvListado" EventName="RowCommand" />
                                                <asp:AsyncPostBackTrigger ControlID="ucwGrabarCerrar" EventName="OnGrabar" />
                                                <asp:AsyncPostBackTrigger ControlID="ucwGrabarCerrar" EventName="OnCerrar" />
                                                
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <asp:HiddenField ID="hddCodigo" runat="server" Value="0" />
</div>
