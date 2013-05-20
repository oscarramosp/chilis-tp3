<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" CodeBehind="BusquedaReclamos.aspx.cs" Inherits="cyr.BusquedaReclamos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <asp:ScriptManager ID="smFiltrosReclamo" runat="server">
    </asp:ScriptManager>
    <div class="divClubChilis">
        <div>
            <asp:UpdatePanel ID="upFiltrosReclamo" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="border-container">
                        <div class="filter-row">
                            <div class="filter-label" style="width: 130px;">
                                Número de Reclamo:
                            </div>
                            <div class="filter-data" style="width: 110px;">
                                <asp:TextBox ID="txtNroRec" runat="server" Width="90" CssClass="classInput" MaxLength="11"></asp:TextBox>
                            </div>
                            <div class="filter-label" style="width: 70px;">
                                Estado:
                            </div>
                            <div class="filter-data" style="width: 80px;">
                                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="select" Width="80">
                                </asp:DropDownList>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 130px;">
                                Tipo de documento:
                            </div>
                            <div class="filter-data" style="width: 130px;">
                                <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="select" Width="110">
                                </asp:DropDownList>
                            </div>
                            <div class="filter-label" style="width: 130px;">
                                Número de documento:
                            </div>
                            <div class="filter-data" style="width: 110px;">
                                <asp:TextBox ID="txtNumDoc" runat="server" Width="95" CssClass="classInput" MaxLength="11"></asp:TextBox>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 150px;">
                                Nombre / Razón Social:
                            </div>
                            <div class="filter-data" style="width: 250px;">
                                <asp:TextBox ID="txtNomRazSoc" runat="server" Width="250" CssClass="classInput" MaxLength="200"></asp:TextBox>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 110px;">
                                Fecha creación:</div>
                            <div class="filter-label" style="width: 50px;">
                                Inicio:</div>
                            <div class="filter-data" style="width: 180px;">
                                <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="classInput"></asp:TextBox>
                            </div>
                            <div class="filter-label" style="width: 30px;">
                                Fin:</div>
                            <div class="filter-data">
                                <asp:TextBox ID="txtFechaFin" runat="server" CssClass="classInput"></asp:TextBox>
                            </div>
                            <div class="filter-data" style="text-align: right; width: 90px;">
                                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="button" OnClick="btnBuscar_Click" />
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnBuscar" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div style="vertical-align: middle; text-align: center; height: 27px;">
            <asp:Label ID="lblSinResultados" CssClass="strong" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="resultado-reporte" id="divResultado" runat="server" visible="true">
            <div style="overflow: auto; min-height: 180px; max-height: 400px;">
                <asp:GridView ID="dgvReclamos" runat="server" AutoGenerateColumns="False" Width="817px" BorderColor="#ECECEC" BorderStyle="Solid" ShowHeader="true" onrowcommand="dgvReclamos_RowCommand" onrowdatabound="dgvReclamos_RowDataBound" >
                    <Columns>
                        <asp:TemplateField HeaderText="Nro. de reclamo">
                            <ItemStyle Font-Underline="True" HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtReclamo" runat="server" Text='<%# Eval("CodigoReclamo") %>' CommandArgument='<%# Eval("CodigoReclamo") %>' CommandName="cmdDetalleReclamo"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nro. Doc. cliente">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:Label ID="lblNroDocCli" runat="server" Text='<%# Eval("Cliente.NumeroDocumento") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nombre de cliente">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="150px" />
                            <ItemTemplate>
                                <asp:Label ID="lblNomCom" runat="server" Text='<%# Eval("Cliente.NombreCompleto") %>' ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fec. creación">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:Label ID="lblTipoDoc" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval("FechaCreacion")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Estado">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="80px" />
                            <ItemTemplate>
                                <asp:Label ID="lblEstado" runat="server" Text='<%# (Eval("Estado").ToString() == "A") ? "Atendido" : "Pendiente" %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Eliminar">
                            <ItemStyle Font-Underline="True" HorizontalAlign="Center" Height="23px" ForeColor="#333333" Width="50px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtElimReclamo" runat="server" Text="E" CommandArgument='<%# Eval("CodigoReclamo") %>' CommandName="cmdEliminarReclamo"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div style="text-align: center;">
            <asp:Button ID="btnNuevo" Visible="True" runat="server" Text="Nuevo" CssClass="button" OnClick="btnNuevo_Click" />
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

            $("#<%= btnBuscar.ClientID %>").click(function() {
                return validar();
            });

        });

        function confirmarEliminar(numeroReclamo, event) {

            event = event.replace(/_/g, "$");

            jcConfirm('Eliminar Reclamo', '¿Desea eliminar el reclamo ' + numeroReclamo + '?', function(choice) {

                if (choice) {
                    __doPostBack(event, '');
                }
            });

            return false;
        }

        function validar() {

            var fechaInicio = $.trim($("#<%= txtFechaInicio.ClientID %>").val());
            var fechaFin = $.trim($("#<%= txtFechaFin.ClientID %>").val());
            var mensaje = '';
            
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
                if (!esFechaMayorIgual(fechaFin, fechaInicio)) mensaje = mensaje + "<li>La fecha final debe ser mayor o igual a la fecha inicial</li>";

            if (mensaje != '') {
                mensaje = '<ul>' + mensaje + '</ul>';
                jcAlert('Datos Incompletos', mensaje, function(choice) { return choice });
                return false;
            }

            return true;
        }
        
    </script>

</asp:Content>
