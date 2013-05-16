<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" CodeBehind="RegistroFechaEspecial.aspx.cs" Inherits="cyr.RegistroFechaEspeciale" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <asp:ScriptManager ID="smEditarFechaEspecial" runat="server">
    </asp:ScriptManager>
    
    <div class="divClubChilis">
        <div>
            <asp:UpdatePanel ID="upEditarFechaEspecial" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="border-container">
                        <div class="filter-row">
                            <div class="filter-label" style="width: 140px;" runat="server" id="divCampoNombre">
                                Fecha:
                            </div>
                            <div class="filter-data" style="width: 150px;">
                                <asp:TextBox ID="txtFecha" runat="server" Width="100" CssClass="classInput" MaxLength="10"></asp:TextBox>
                            </div>
                            <div class="filter-data" style="text-align:right; width: 90px;">
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 140px;" runat="server" id="div1">
                                Motivo:
                            </div>
                            <div class="filter-data" style="width: 250px;">
                                <asp:TextBox ID="txtMotivo" runat="server" Width="250" CssClass="classInput" MaxLength="256"></asp:TextBox>
                            </div>
                            <div class="filter-data" style="text-align:right; width: 90px;">
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="mensaje">
            <asp:Label ID="lblMensaje" runat="server" ></asp:Label>
        </div>
        <div style="height: 25px;">
        </div>
        <div style="text-align:center; vertical-align: bottom;">
            &nbsp
            <asp:Button ID="btnGrabar" Visible="True" runat="server" Text="Grabar" 
                CssClass="button" onclick="btnGrabar_Click"/>
            &nbsp
            <asp:Button ID="btnCancelar" Visible="True" runat="server" Text="Cancelar" 
                CssClass="button" onclick="btnCancelar_Click"/>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#<%= txtFecha.ClientID %>").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy"
            });

            $("#<%= btnGrabar.ClientID %>").click(function() {
                return confirmarGrabar();
            });
        });

        function confirmarGrabar() {
            var fecha = $.trim($("#<%= txtFecha.ClientID %>").val());
            var motivo = $.trim($("#<%= txtMotivo.ClientID %>").val());

            var mensaje = '';

            if (fecha == '' || !esFechaValida(fecha))
                mensaje += "<li>Ingrese una fecha válida (dd/mm/yyyy).</li>";
            if (motivo == '' || !evaluarAlfaEspacio(motivo))
                mensaje += "<li>Ingrese el motivo.</li>";

            if (mensaje != '') {
                mensaje = '<ul>' + mensaje + '</ul>';
                jcAlert('Datos Incompletos', mensaje, function(choice) { return choice });
                return false;
            }

            jcConfirm('Actualizar Fecha Especial', '¿Desea actualizar la fecha especial?', function(choice) {

                if (choice) {
                    var event = "<%= btnGrabar.ClientID %>";
                    event = event.replace(/_/g, "$");
                    __doPostBack(event, '');
                }
            });

            return false;
        }
    </script>
</asp:Content>
