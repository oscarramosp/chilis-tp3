<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true"
    CodeBehind="GenerarReporteReclamos.aspx.cs" Inherits="cyr.GenerarReporteReclamos" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <div class="divClubChilis">
        <div>
            <div class="border-container">
                <div class="filter-row">
                    <div class="filter-label" style="width: 100px;">
                        Fecha creación:</div>
                    <div class="filter-label" style="width: 50px;">
                        Inicio:</div>
                    <div class="filter-data" style="width: 210px;">
                        <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="classInput"></asp:TextBox>
                    </div>
                    <div class="filter-label" style="width: 50px;">
                        Fin:</div>
                    <div class="filter-data">
                        <asp:TextBox ID="txtFechaFin" runat="server" CssClass="classInput"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row">
                    <div class="filter-label" style="width: 150px;">
                        Estado:</div>
                    <div class="filter-data" style="width: 210px;">
                        <asp:DropDownList ID="ddlEstado" runat="server" CssClass="select">
                        </asp:DropDownList>
                    </div>
                    <div class="filter-label">
                    </div>
                    <div class="filter-data">
                        <asp:Button ID="btnGenerarReporte" runat="server" Text="Generar Reporte" CssClass="button"
                            OnClick="btnGenerarReporte_Click" />
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
        </div>
        
        <asp:Label ID="lblSinResultados" CssClass="strong" runat="server" Visible="false"></asp:Label>
        <div class="resultado-reporte" id="divResultado" runat="server" visible="false">
            <div id="section_to_print">
                <div>
                    <h4>Reporte de Reclamos</h4>
                </div>
                <div style="padding-bottom: 20px;">
                    <div style="float: left; position: relative; min-width: 300px;">
                        Generado el
                        <asp:Label ID="lblGenerado" runat="server" Text="" CssClass="strong"></asp:Label>
                    </div>
                    <div>
                        Rango:
                        <asp:Label ID="lblRango" runat="server" Text="" CssClass="strong"></asp:Label>
                    </div>
                </div>
                <div>
                    <CR:CrystalReportViewer ID="crvReclamos" runat="server" 
                        DisplayGroupTree="False" 
                        EnableDrillDown="true" EnableParameterPrompt="False" HasCrystalLogo="False" 
                        HasDrillUpButton="False" HasSearchButton="False" 
                        HasToggleGroupTreeButton="False" HasViewList="False" 
                        HasZoomFactorList="False" ToolbarStyle-Width = "640px" Height="500px" Width="783px" EnableDatabaseLogonPrompt="false" 
                        ReuseParameterValuesOnRefresh="True"/>
                </div>
            </div>
        </div>
        <div>
            <asp:Button ID="btnImprimir" Visible="false" runat="server" Text="Imprimir" CssClass="button" OnClientClick="javascript:print(); return false;" />
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {

            $("#<%= txtFechaInicio.ClientID %>").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy"
            });

            $("#<%= txtFechaFin.ClientID %>").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy"
            });

            $("#<%= btnGenerarReporte.ClientID %>").click(function() {
                return validar();
            });
        });

        function validar() {
            
            var fechaInicio = $.trim($("#<%= txtFechaInicio.ClientID %>").val());
            var fechaFin = $.trim($("#<%= txtFechaFin.ClientID %>").val());
            var mensaje = '';
            // ugly
            var fechaCorrecta1 = false;
            var fechaCorrecta2 = false;

            if (fechaInicio == '' || !esFechaValida(fechaInicio))
                mensaje = mensaje + "<li>Ingrese fecha inicial (dd/mm/yyyy)</li>";
            else
                fechaCorrecta1 = true;

            if (fechaFin == '' || !esFechaValida(fechaFin))
                mensaje = mensaje + "<li>Ingrese fecha final (dd/mm/yyyy)</li>";
            else
                fechaCorrecta2 = true;
            
            if (fechaCorrecta1 && fechaCorrecta2)
                if(!esFechaMayorIgual(fechaFin, fechaInicio)) mensaje = mensaje + "<li>La fecha final debe ser mayor o igual a la fecha inicial</li>";
        
            if (mensaje != '') {
                mensaje = '<ul>' + mensaje + '</ul>';
                jcAlert('Datos Incompletos', mensaje, function(choice) { return choice });
                return false;
            }

            return true;
        }
        
    </script>

</asp:Content>
