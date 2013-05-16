<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" CodeBehind="RegistroReserva.aspx.cs" Inherits="cyr.RegistroReserva" %>
<%@ Register Src="~/UC/ucBuscarCliente.ascx" TagName="buscarCliente" TagPrefix="ucChilis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <script type="text/javascript" src="js/jquery.maskedinput.js"></script>

    <asp:ScriptManager ID="smEditarReserva" runat="server">
    </asp:ScriptManager>
    <div class="divClubChilis">
        <ucChilis:buscarCliente ID="ucBuscarCliente" runat="server" />
        <fieldset>
            <legend>Datos de la Reserva</legend>
            <div class="border-container">
                <div class="filter-row">
                    <div class="filter-label" style="width: 130px;">
                        Número de reserva:
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:TextBox ID="txtNumeroReserva" runat="server" Width="100" CssClass="classInput" MaxLength="11" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row">
                    <div class="filter-label" style="width: 130px;">
                        Fecha:
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:TextBox ID="txtFechaReserva" runat="server" Width="100" CssClass="classInput" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="filter-label" style="width: 50px;">
                        Hora:
                    </div>
                    <div class="filter-data" style="width: 90px;">
                        <asp:TextBox ID="txtHoraInicio" runat="server" Width="50" CssClass="classInput" MaxLength="5"></asp:TextBox>
                    </div>
                    <div class="filter-label" style="width: 50px;">
                        Hasta:
                    </div>
                    <div class="filter-data" style="width: 90px;">
                        <asp:TextBox ID="txtHoraFin" runat="server" Width="50" CssClass="classInput" MaxLength="5"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row">
                    <div class="filter-label" style="width: 130px;">
                        Cantidad de personas:
                    </div>
                    <div class="filter-data" style="width: 250px;">
                        <asp:TextBox ID="txtCantidadPersonas" runat="server" Width="60" CssClass="classInput" MaxLength="5"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row">
                    <div class="filter-label" style="width: 130px;">
                        Mesa:
                    </div>
                    <div class="filter-data" style="width: 250px;">
                        <asp:DropDownList ID="ddlMesa" runat="server" CssClass="select">
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="filter-row">
                    <div class="filter-label" style="width: 130px;">
                        Observaciones:
                    </div>
                    <div class="filter-data" style="width: 400px;">
                        <asp:TextBox ID="txtObservaciones" runat="server" Rows="4" Columns="30" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                
                <div class="mensaje">
                    <asp:Label ID="lblMensaje" runat="server" ></asp:Label>
                </div>
                
                <div class="filter-row">
                    <div class="filter-label" style="width: 200px;">
                    </div>
                    <div class="filter-data" style="width: 120px;">
                        <asp:Button ID="btnGrabarReserva" runat="server" Text="Grabar Reserva" 
                            CssClass="button" onclick="btnGrabarReserva_Click" />
                    </div>
                    <div class="filter-data" runat="server" id="divCancelarReserva" visible="false" style="width: 130px;">
                        <asp:Button ID="btnEliminarReserva" runat="server" Text="Cancelar Reserva" 
                            CssClass="red-button" onclick="btnEliminarReserva_Click" />
                    </div>
                    <div class="filter-data" style="width: 150px;">
                        <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" CssClass="alt-button" 
                            onclick="btnCerrar_Click" />
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
        </fieldset>
         
      
    </div>
    
    <script type="text/javascript">

        $(document).ready(function() {

            $.mask.definitions['H'] = '[012]';
            $.mask.definitions['N'] = '[012345]';
            $.mask.definitions['n'] = '[0123456789]';
            $("#<%= txtHoraInicio.ClientID %>").mask("Hn:Nn");
            $("#<%= txtHoraFin.ClientID %>").mask("Hn:Nn");

            $('#<%= txtHoraInicio.ClientID %>').blur(function() {
                validaHora(this);
            });

            $('#<%= txtHoraFin.ClientID %>').blur(function() {
                validaHora(this);
            });

            $("#<%= txtFechaReserva.ClientID %>").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy"
            });

            $("#<%= btnGrabarReserva.ClientID %>").click(function() {
                return confirmarGrabar();
            });

            $("#<%= btnEliminarReserva.ClientID %>").click(function() {
                return confirmarCancelar();
            });

        });

        function confirmarGrabar() {

            var codigoCliente = $.trim($("#<%= ucBuscarCliente.CodigoClienteClientID %>").val());
            var fecha = $.trim($("#<%= txtFechaReserva.ClientID %>").val());
            var horaInicio = $.trim($("#<%= txtHoraInicio.ClientID %>").val());
            var horaFin = $.trim($("#<%= txtHoraFin.ClientID %>").val());
            var cantidad = $.trim($("#<%= txtCantidadPersonas.ClientID %>").val());
            var mesa = $.trim($("#<%= ddlMesa.ClientID %>").val());

            var mensaje = '';

            if (codigoCliente == '' || codigoCliente == '0')
                mensaje += "<li>Seleccione el cliente.</li>";
            if (fecha == '' || !esFechaValida(fecha))
                mensaje += "<li>Ingrese una fecha de reserva válida (dd/mm/yyyy).</li>";
            if (horaInicio == '')
                mensaje += "<li>Ingrese una hora de inicio de reserva válida.</li>";
            if (horaFin == '')
                mensaje += "<li>Ingrese una hora de fin de reserva válida.</li>";
            if (cantidad == '' || !esEnteroValido(cantidad))
                mensaje += "<li>Ingrese la cantidad de personas.</li>";
            if (mesa == '0')
                mensaje += "<li>Seleccione la mesa.</li>";

            if (horaInicio != '' && horaFin != '') {
                var hI = horaInicio;
                var hF = horaFin;
                hI = parseInt(hI.replace(':', ''));
                hF = parseInt(hF.replace(':', ''));
                
                if (horaInicio > horaFin) {
                    mensaje = mensaje + '<li> La hora de inicio de reserva debe ser menor que la hora de fin.</li>';
                }
            }

            if (mensaje != '') {
                mensaje = '<ul>' + mensaje + '</ul>';
                jcAlert('Datos Incompletos', mensaje, function(choice) { return choice });
                return false;
            }
            
            jcConfirm('Actualizar Reserva', '¿Desea actualizar la reserva?', function(choice) {

                if (choice) {
                    var event = "<%= btnGrabarReserva.ClientID %>";
                    event = event.replace(/_/g, "$");
                    __doPostBack(event, '');
                }
            });

            return false;
        }

        function confirmarCancelar() {

            jcConfirm('Cancelar Reserva', '¿Desea cancelar la reserva?', function(choice) {

                if (choice) {
                    var event = "<%= btnEliminarReserva.ClientID %>";
                    event = event.replace(/_/g, "$");
                    __doPostBack(event, '');
                }
            });

            return false;
        }

        function validaHora(valor) {
            if (valor.value.indexOf("_") == -1) {
                var hora = valor.value.split(":")[0];
                if (parseInt(hora) > 23) {
                    valor.value = '';
                }
            }
        }
        
    </script>

</asp:Content>
