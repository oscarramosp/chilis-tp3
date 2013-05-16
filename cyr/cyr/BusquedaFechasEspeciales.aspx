<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" CodeBehind="BusquedaFechasEspeciales.aspx.cs" Inherits="cyr.BusquedaFechasEspeciales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <asp:ScriptManager ID="smFiltrosCliente" runat="server">
    </asp:ScriptManager>
    <div class="divClubChilis">
        <div>
            <asp:UpdatePanel ID="upFiltrosFecha" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="border-container">
                        <div class="filter-row">
                            <div class="filter-label" style="width: 130px;">
                                Año:
                            </div>
                            <div class="filter-data" style="width: 80px;">
                                <asp:DropDownList ID="ddlAnho" runat="server" CssClass="select" Width="80">
                                </asp:DropDownList>
                            </div>
                            <div class="filter-label" style="width: 140px;">
                                Mes:
                            </div>
                            <div class="filter-data" style="width: 100px;">
                                <asp:DropDownList ID="ddlMes" runat="server" CssClass="select" Width="100">
                                </asp:DropDownList>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 130px;" runat="server" id="divCampoNombre">
                                Descripción:
                            </div>
                            <div class="filter-data" style="width: 250px;">
                                <asp:TextBox ID="txtMotivo" runat="server" Width="250" CssClass="classInput" MaxLength="256"></asp:TextBox>
                            </div>
                            <div class="filter-data" style="text-align:right; width: 90px;">
                                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="button" 
                                    onclick="btnBuscar_Click" />
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
            <div style="overflow: auto; min-height:180px; max-height: 400px;">
                <asp:GridView id="dgvFechas" runat="server" AutoGenerateColumns="False" Width="500px"
                    BorderColor="#ECECEC" BorderStyle="Solid" ShowHeader="true" 
                    onrowcommand="dgvFechas_RowCommand" onrowdatabound="dgvFechas_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Código" HeaderStyle-HorizontalAlign="Center">
                            <ItemStyle Font-Underline="True" HorizontalAlign="Center" Height="23px" Width="90px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtFechaEspecial" runat="server" Text='<%# Bind("Codigo") %>'
                                    CommandArgument='<%# Bind("Codigo") %>' CommandName="cmdDetalleFecha"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderStyle-HorizontalAlign="Center">
                            <ItemStyle HorizontalAlign="Center" Width="80px"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="Motivo" HeaderText="Motivo" HeaderStyle-HorizontalAlign="Center">
                            <ItemStyle HorizontalAlign="Left" Width="250px"/>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Eliminar" HeaderStyle-HorizontalAlign="Center">
                            <ItemStyle Font-Underline="True" HorizontalAlign="Center" Height="23px" ForeColor="#333333"
                                Width="50px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtElimFecha" runat="server" Text="E"
                                    CommandArgument='<%# Bind("Codigo") %>' CommandName="cmdEliminarFecha"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div style="text-align:center;">
            <asp:Button ID="btnNuevo" Visible="True" runat="server" Text="Nuevo" 
                CssClass="button" onclick="btnNuevo_Click"/>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {

        });

        function confirmarEliminar(fecha, motivo, event) {

            event = event.replace(/_/g, "$");

            jcConfirm('Eliminar Fecha', '¿Desea eliminar la fecha especial: ' + fecha + '-' + motivo + ' ?', function(choice) {

                if (choice) {
                    __doPostBack(event, '');
                }
            });

            return false;
        }
    </script>
</asp:Content>
