<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" 
    CodeBehind="BusquedaClientes.aspx.cs" Inherits="cyr.BusquedaClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">

    <asp:ScriptManager ID="smFiltrosCliente" runat="server">
</asp:ScriptManager>

    <div class="divClubChilis">
        <div>
            <asp:UpdatePanel ID="upFiltrosCliente" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="border-container">
                    <div class="filter-row">
                        <div class="filter-label" style="width: 130px;">
                            Tipo de cliente:
                        </div>
                        <div class="filter-data" style="width: 55px;">
                            <asp:RadioButton ID="rbtNatural" runat="server" Text="Natural" GroupName="TD" Checked="true" Width="55" OnCheckedChanged="Td_CheckedChanged" AutoPostBack="true"/>
                        </div>
                        <div class="filter-data" style="width: 60px;">
                            <asp:RadioButton ID="rbtJuridico" runat="server" Text="Jurídico" GroupName="TD" Checked="false" Width="60" OnCheckedChanged="Td_CheckedChanged" AutoPostBack="true"/>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div class="filter-row">
                        <div class="filter-label" style="width: 130px;">
                            Tipo de documento:
                        </div>
                        <div class="filter-data" style="width: 80px;">
                            <asp:DropDownList ID="ddlTipoDoc" runat="server" CssClass="select" Width="80">
                            </asp:DropDownList>
                        </div>
                        <div class="filter-label" style="width: 140px;">
                            Número de documento:
                        </div>
                        <div class="filter-data" style="width: 90px;">
                            <asp:TextBox ID="txtNroDoc" runat="server" Width="90" CssClass="classInput" MaxLength="11"></asp:TextBox>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div class="filter-row">
                        <div class="filter-label" style="width: 130px;" runat="server" id="divCampoNombre">
                            Nombre:
                        </div>
                        <div class="filter-data" style="width: 250px;">
                            <asp:TextBox ID="txtNombre" runat="server" Width="250" CssClass="classInput" MaxLength="256"></asp:TextBox>
                        </div>
                        <div class="filter-data" style="text-align:right; width: 90px;">
                            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="button" 
                                onclick="btnBuscar_Click" />
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div class="filter-row" runat="server" id="divSexo">
                        <div class="filter-label" style="width: 130px;">
                            Sexo:
                        </div>
                        <div class="filter-data" style="width: 90px;">
                            <asp:RadioButton ID="rbtAmbos" runat="server" Text="Ambos" GroupName="SX" Checked="true" Width="90" />
                        </div>
                        <div class="filter-data" style="width: 90px;">
                            <asp:RadioButton ID="rbtMasculino" runat="server" Text="Masculino" GroupName="SX" Checked="false" Width="90" />
                        </div>
                        <div class="filter-data" style="width: 90px;">
                            <asp:RadioButton ID="rbtFemenino" runat="server" Text="Femenino" GroupName="SX" Checked="false" Width="90" />
                        </div>
                        <div class="filter-label">
                        </div>
                        <div class="clear" style="height: 15px;">
                        </div>
                    </div>   
                </div>
                
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="rbtNatural" EventName="CheckedChanged" />
                <asp:AsyncPostBackTrigger ControlID="rbtJuridico" EventName="CheckedChanged" />
                <asp:PostBackTrigger ControlID="btnBuscar" />
            </Triggers>
            </asp:UpdatePanel>
        </div>
        <div style="vertical-align: middle; text-align: center; height: 27px;">
            <asp:Label ID="lblSinResultados" CssClass="strong" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="resultado-reporte" id="divResultado" runat="server" visible="true">
            
            <div style="overflow: auto; min-height:180px; max-height: 400px;">
                <asp:GridView id="dgvClientes" runat="server" AutoGenerateColumns="False" Width="817px"
                BorderColor="#ECECEC" BorderStyle="Solid" ShowHeader="true" 
                    onrowdatabound="dgvClientes_RowDataBound" 
                    onrowcommand="dgvClientes_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Código">
                            <ItemStyle Font-Underline="True" HorizontalAlign="Center" Height="23px" Width="90px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtCliente" runat="server" Text='<%# Bind("CodigoCliente") %>'
                                    CommandArgument='<%# Bind("CodigoCliente") %>' CommandName="cmdDetalleCliente"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tipo de Cliente">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="150px" />
                            <ItemTemplate>
                                <asp:Label ID="lblTipo" runat="server" Text='<%# DataBinder.Eval(Container,"DataItem.TipoCliente") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblTipoDes" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="RazonSocial" HeaderText="Nombre/Razón Social">
                            <ItemStyle HorizontalAlign="Center" Width="250px"/>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Tipo Docu.">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="100px" />
                            <ItemTemplate>
                                <asp:Label ID="lblTipoDoc" runat="server" Text='<%# DataBinder.Eval(Container,"DataItem.TipoDocumento.Acronimo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NumeroDocumento" HeaderText="Número Docu.">
                            <ItemStyle HorizontalAlign="Center" Width="120px"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="Email" HeaderText="Correo Electrónico">
                            <ItemStyle HorizontalAlign="Center" Width="150px"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="TelefonoPrincipal" HeaderText="Teléfono">
                            <ItemStyle HorizontalAlign="Center" Width="110px"/>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Estado">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="80px" />
                            <ItemTemplate>
                                <asp:Label ID="lblEstado" runat="server" Text='<%# DataBinder.Eval(Container,"DataItem.Estado") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblEstadoDes" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Eliminar">
                            <ItemStyle Font-Underline="True" HorizontalAlign="Center" Height="23px" ForeColor="#333333"
                                Width="50px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtElimCliente" runat="server" Text="E"
                                    CommandArgument='<%# Bind("CodigoCliente") %>' CommandName="cmdEliminarCliente"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>  
        </div>
        <div style="text-align:center;">
            <asp:Button ID="btnNuevo" Visible="True" runat="server" Text="Nuevo" 
                CssClass="button" onclick="btnNuevo_Click" />
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {

        });

        function confirmarEliminar(nombreCliente, event) {

            event = event.replace(/_/g, "$");
            
            jcConfirm('Eliminar Cliente', '¿Desea eliminar al cliente ' + nombreCliente + '?', function(choice) {

                if (choice) {
                    __doPostBack(event, '');
                }
            });
            
            return false;
        }
        
    </script>
</asp:Content>

