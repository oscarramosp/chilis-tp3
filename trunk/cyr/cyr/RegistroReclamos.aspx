<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" CodeBehind="RegistroReclamos.aspx.cs" Inherits="cyr.RegistroReclamos" %>

<%@ Register Src="UC/ucBuscarCliente.ascx" TagName="buscarCliente" TagPrefix="ucChilis" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <asp:ScriptManager ID="smEditarReclamo" runat="server">
    </asp:ScriptManager>
    <div class="divClubChilis">
        <ucChilis:buscarCliente ID="ucBuscarCliente" runat="server" />
        <fieldset>
            <legend>Datos del Reclamo</legend>
            <div class="border-container">
                <div class="filter-row">
                    <div class="filter-label" style="width: 130px;">
                        Número de reclamo:
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:TextBox ID="txtNumeroReclamo" runat="server" Width="100" CssClass="classInput" MaxLength="11" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="filter-label" style="width: 130px;">
                        Estado:
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:DropDownList ID="ddlEstado" runat="server" CssClass="select">
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row">
                    <div class="filter-label" style="width: 130px;">
                        Fecha de Creación:
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:TextBox ID="txtFecCre" runat="server" Width="100" CssClass="classInput" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="filter-label" style="width: 130px;">
                        Fecha de Cierre:
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:TextBox ID="txtFecCie" runat="server" Width="100" CssClass="classInput" MaxLength="5"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row">
                    <div class="filter-label" style="width: 50px;">
                        Local:
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:DropDownList ID="ddlLocal" runat="server" CssClass="select" Width="130">
                        </asp:DropDownList>
                    </div>
                    <div class="filter-label" style="width: 130px;">
                        Tipo de Reclamo:
                    </div>
                    <div class="filter-data" style="width: 130px;">
                        <asp:DropDownList ID="ddlTipoReclamo" runat="server" CssClass="select" Width="130">
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row">
                    <div class="filter-label" style="width: 100px;">
                        Reclamo:
                    </div>
                    <div class="filter-data" style="width: 250px;">
                        <asp:TextBox ID="txtReclamo" runat="server" Width="200" CssClass="classInput" MaxLength="200"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row" runat="server">
                    <div class="filter-label" style="width: 100px;">
                        Respuestas:
                    </div>
                    <asp:UpdatePanel ID="upRespuestas" UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <div class="filter-data" style="width: 495px;">
                                <div style="overflow: auto; min-height: 180px; max-height: 400px;">
                                    <asp:GridView ID="dgvRespuestas" runat="server" AutoGenerateColumns="False" Width="487px" BorderColor="#ECECEC" BorderStyle="Solid" ShowHeader="true" onrowcommand="dgvRespuestas_RowCommand" onrowdatabound="dgvRespuestas_RowDataBound" >
                                        <Columns>
                                            <asp:TemplateField HeaderText="Nro. rpta">
                                                <ItemStyle HorizontalAlign="Center" Height="23px" Width="70px" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNroRespuesta" runat="server" Text='<%# Eval("NumeroRespuesta") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Respuesta">
                                                <ItemStyle HorizontalAlign="Center" Height="23px" Width="260px" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRespuesta" runat="server" Text='<%# Eval("Respuesta") %>' Width="250"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fec. respuesta">
                                                <ItemStyle HorizontalAlign="Center" Height="23px" Width="100px" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFecRes" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval("FechaRespuesta")) %>' Width="90"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="E">
                                                <ItemStyle Font-Underline="True" HorizontalAlign="Center" Height="23px" ForeColor="#333333" Width="47" />
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbtElimRespuesta" runat="server" Text="E" CommandArgument='<%# Container.DataItemIndex %>' CommandName="cmdEliminarRespuesta"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAgregarRespuesta" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div class="clear">
                    </div>
                </div>
                
                <div class="filter-row">
                    <div class="filter-data" style="width: 643px; text-align: center">
                        <asp:Button ID="btnAgregarRespuesta" runat="server" Text="Agregar Respuesta" CssClass="button" OnClick="btnAgregarRespuesta_Click" ToolTip="Agregar Respuesta" />
                    </div>
                    <div class="mensaje">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                
                <div class="filter-row">
                    <div class="filter-data" style="width: 120px;">
                        <asp:Button ID="btnGrabarReclamo" runat="server" Text="Grabar Reclamo" CssClass="button" onclick="btnGrabarReclamo_Click" />
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:Button ID="btnCerrar" runat="server" Text="Cancelar" CssClass="alt-button" onclick="btnCerrar_Click" />
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
        </fieldset>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {

            $("#<%= txtFecCre.ClientID %>").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy"
            });

            $("#<%= txtFecCie.ClientID %>").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy"
            });

            $("#<%= btnGrabarReclamo.ClientID %>").click(function() {
                return validar();
            });

            $("#<%= btnCerrar.ClientID %>").click(function() {
                return confirmarCancelar();
            });

        });        
    
        function validar() {

            var codigoCliente = $.trim($("#<%= ucBuscarCliente.CodigoClienteClientID %>").val());
            var estado = $("#<%= ddlEstado.ClientID %>").val();
            var fechaCreacion = $("#<%= txtFecCre.ClientID %>").val();
            var fechaCierre = $.trim($("#<%= txtFecCie.ClientID %>").val());
            var local = $.trim($("#<%= ddlLocal.ClientID %>").val());
            var tipoReclamo = $.trim($("#<%= ddlTipoReclamo.ClientID %>").val());
            var reclamo = $.trim($("#<%= txtReclamo.ClientID %>").val());

            var mensaje = '';
            
            if (codigoCliente == '' || codigoCliente == '0')
                mensaje += "<li>Seleccione un cliente.</li>";
            if (estado == '' || estado == '0')
                mensaje += "<li>Seleccione el estado.</li>";
            if (fechaCreacion == '' || !esFechaValida(fechaCreacion)) {
                mensaje += "<li>Ingrese una fecha de creación válida (dd/mm/yyyy).</li>";
            } else {
                if (esFechaMayorHoy(fechaCreacion))
                    mensaje += "<li>La fecha de creación no puede ser mayor a la fecha actual.</li>";
            }
            if (fechaCierre != '') {
                 if (!esFechaValida(fechaCierre))
                     mensaje += "<li>Ingrese una fecha de cierre válida (dd/mm/yyyy).</li>";
                 else if (esFechaMayorHoy(fechaCierre))
                     mensaje += "<li>La fecha de cierre no puede ser mayor a la fecha actual.</li>";
            }

            if (local == '' || local == '0')
                mensaje += "<li>Seleccione el local.</li>";
            if (tipoReclamo == '' || tipoReclamo == '0')
                mensaje += "<li>Seleccione el tipo de reclamo.</li>";
            if (reclamo == '')
                mensaje += "<li>Ingrese el reclamo.</li>";

            // Validar respuestas.

            var cantRespuestas = 0;
            var errorEnGrilla = false;
            $("#<%= dgvRespuestas.ClientID %> tr").each(function() {

                if (cantRespuestas >= 1) {

                    var respuesta = $.trim($(this).children("td").eq(1).find('input').eq(0).val());
                    var fechaRespuesta = $.trim($(this).children("td").eq(2).find('input').eq(0).val());

                    if (respuesta == '') {
                        errorEnGrilla = true;
                        mensaje += "<li>[Respuesta] Ingrese la respuesta.</li>";
                    }
                    if (fechaRespuesta == '' || !esFechaValida(fechaRespuesta)) {
                        errorEnGrilla = true;
                        mensaje += "<li>[Respuesta] Ingrese una fecha de respuesta válida (dd/mm/yyyy).</li>";
                    } else if (esFechaMayorHoy(fechaRespuesta)) {
                        mensaje += "<li>[Respuesta] La fecha de respuesta no puede ser mayor a la fecha actual.</li>";
                    }

                    if (errorEnGrilla)
                        return;
                }

                cantRespuestas++;
            });
            
            if (mensaje != '') {
                mensaje = '<ul>' + mensaje + '</ul>';
                jcAlert('Datos Incompletos', mensaje, function(choice) { return choice });
                return false;
            }
            
            jcConfirm('Actualizar Reclamo', '¿Desea actualizar el reclamo?', function(choice) {

                if (choice) {
                    var event = "<%= btnGrabarReclamo.ClientID %>";
                    event = event.replace(/_/g, "$");
                    __doPostBack(event, '');
                }
            });
            
            return false;
        }

        function confirmarCancelar() {

            jcConfirm('Cancelar Actualización del Reclamo', '¿Desea cancelar la actualización del Reclamo?', function(choice) {

                if (choice) {
                    var event = "<%= btnCerrar.ClientID %>";
                    event = event.replace(/_/g, "$");
                    __doPostBack(event, '');
                }
            });

            return false;
        }

        function confirmarEliminar(numeroRespuesta, event) {

            event = event.replace(/_/g, "$");

            jcConfirm('Eliminar Respuesta', '¿Desea eliminar la respuesta ' + numeroRespuesta + '?', function(choice) {

                if (choice) {
                    __doPostBack(event, '');
                }
            });

            return false;
        }
        
    </script>

</asp:Content>
