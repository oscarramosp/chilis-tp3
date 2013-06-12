<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" 
    CodeBehind="RegistroClientes.aspx.cs" Inherits="cyr.FormularioClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <asp:ScriptManager ID="smEditarCliente" runat="server">
    </asp:ScriptManager>

    <div class="divClubChilis">
        <div>
            <asp:UpdatePanel ID="upEditarCliente" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                
                    <div class="border-container">
                        <div class="filter-row">
                            <div class="filter-label" style="width: 140px;">
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
                            <div class="filter-label" style="width: 140px;" runat="server" id="divCampoNombre">
                                Nombre:
                            </div>
                            <div class="filter-data" style="width: 250px;">
                                <asp:TextBox ID="txtNombre" runat="server" Width="250" CssClass="classInput" MaxLength="256"></asp:TextBox>
                            </div>
                            <div class="filter-data" style="text-align:right; width: 90px;">
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row" runat="server" id="divApePaterno">
                            <div class="filter-label" style="width: 140px;">
                                Apellido paterno:
                            </div>
                            <div class="filter-data" style="width: 250px;">
                                <asp:TextBox ID="txtApellidoPaterno" runat="server" Width="250" CssClass="classInput" MaxLength="128"></asp:TextBox>
                            </div>
                            <div class="filter-data" style="text-align:right; width: 90px;">
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row" runat="server" id="divApeMaterno">
                            <div class="filter-label" style="width: 140px;">
                                Apellido materno:
                            </div>
                            <div class="filter-data" style="width: 250px;">
                                <asp:TextBox ID="txtApellidoMaterno" runat="server" Width="250" CssClass="classInput" MaxLength="128"></asp:TextBox>
                            </div>
                            <div class="filter-data" style="text-align:right; width: 90px;">
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 140px;">
                                Tipo de documento:
                            </div>
                            <div class="filter-data" style="width: 95px;">
                                <asp:DropDownList ID="ddlTipoDoc" runat="server" CssClass="select" Width="95">
                                </asp:DropDownList>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 140px;">
                                Número de documento:
                            </div>
                            <div class="filter-data" style="width: 120px;">
                                <asp:TextBox ID="txtNroDoc" runat="server" Width="120" CssClass="classInput" MaxLength="11"></asp:TextBox>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row" runat="server" id="divSexo">
                            <div class="filter-label" style="width: 140px;">
                                Sexo:
                            </div>
                            <div class="filter-data" style="width: 90px;">
                                <asp:RadioButton ID="rbtMasculino" runat="server" Text="Masculino" GroupName="SX" Checked="false" Width="90" />
                            </div>
                            <div class="filter-data" style="width: 90px;">
                                <asp:RadioButton ID="rbtFemenino" runat="server" Text="Femenino" GroupName="SX" Checked="false" Width="90" />
                            </div>
                            <div class="filter-label">
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row" runat="server" id="divContacto" visible="false">
                            <div class="filter-label" style="width: 140px;">
                                Contacto:
                            </div>
                            <div class="filter-data" style="width: 250px;">
                                <asp:TextBox ID="txtContacto" runat="server" Width="250" CssClass="classInput" MaxLength="256"></asp:TextBox>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 140px;">
                                Email:
                            </div>
                            <div class="filter-data" style="width: 250px;">
                                <asp:TextBox ID="txtEmail" runat="server" Width="250" CssClass="classInput" MaxLength="128"></asp:TextBox>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-label" style="width: 140px;">
                                Teléfono:
                            </div>
                            <div class="filter-data" style="width: 120px;">
                                <asp:TextBox ID="txtTelefono" runat="server" Width="120" CssClass="classInput" MaxLength="128"></asp:TextBox>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                    </div>
                
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="rbtNatural" EventName="CheckedChanged" />
                    <asp:AsyncPostBackTrigger ControlID="rbtJuridico" EventName="CheckedChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div style="vertical-align: middle; text-align: center; height: 27px;">
            <asp:Label ID="lblSinResultados" CssClass="strong" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="resultado-reporte" id="divResultado" runat="server" visible="true">
            <div style="min-height:70px;">
                <div style="overflow: auto; min-height:70px;">
                    <asp:UpdatePanel ID="upDirecciones" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView id="dgvDirecciones" runat="server" AutoGenerateColumns="False" Width="500px"
                        BorderColor="#ECECEC" BorderStyle="Solid" ShowHeader="true" 
                        onrowcommand="dgvDirecciones_RowCommand" 
                        onrowdatabound="dgvDirecciones_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Tipo">
                                <ItemStyle HorizontalAlign="Center" Height="23px" Width="130px" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlTipoDir" runat="server" CssClass="select" Width="120">
                                            <asp:ListItem Text="Seleccionar" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Domicilio" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Oficina" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Playa" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Dirección">
                                    <ItemStyle HorizontalAlign="Center" Height="23px" Width="230px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDireccion" runat="server" Width="200" CssClass="classInput" MaxLength="512" Text='<%# Bind("Direccion") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Referencia">
                                    <ItemStyle HorizontalAlign="Center" Height="23px" Width="230px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtReferencia" runat="server" Width="200" CssClass="classInput" MaxLength="512" Text='<%# Bind("Referencia") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Teléfono">
                                    <ItemStyle HorizontalAlign="Center" Height="23px" Width="120px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTelefono" runat="server" Width="120" CssClass="classInput" MaxLength="64" Text='<%# Bind("Telefono") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Eliminar">
                                    <ItemStyle Font-Underline="True" HorizontalAlign="Center" Height="23px" ForeColor="#333333"
                                        Width="50px" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtEliminarDireccion" runat="server" Text="E"
                                            CommandArgument='<%# Container.DataItemIndex %>' CommandName="cmdEliminarDireccion"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCodigoDireccion" runat="server" Text='<%# Bind("CodigoDireccion") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAgregarDireccion" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="dgvDirecciones" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                
                    
                </div>
            </div>
        </div>
        <div class="mensaje">
            <asp:Label ID="lblMensaje" runat="server" ></asp:Label>
        </div>
        
        <div style="height: 25px;">
        </div>
        <div style="text-align:center; vertical-align: bottom;">
            <asp:Button ID="btnAgregarDireccion" Visible="True" runat="server" Text="Agregar dirección" 
                CssClass="button" onclick="btnAgregarDireccion_Click"/>
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
            $("#<%= btnGrabar.ClientID %>").click(function() {
                return validar();
            });
        });

        function validar() {
            
            var rbtNatural = $("#<%= rbtNatural.ClientID %>").is(":checked");
            var rbtJuridico = $("#<%= rbtJuridico.ClientID %>").is(":checked");
            var nombre = $.trim($("#<%= txtNombre.ClientID %>").val());
            var apePaterno = $.trim($("#<%= txtApellidoPaterno.ClientID %>").val());
            var apeMaterno = $.trim($("#<%= txtApellidoMaterno.ClientID %>").val());
            var tipoDoc = $.trim($("#<%= ddlTipoDoc.ClientID %>").val());
            var nroDoc = $.trim($("#<%= txtNroDoc.ClientID %>").val());
            var rbtMasculino = $("#<%= rbtMasculino.ClientID %>").is(":checked");
            var rbtFemenino = $("#<%= rbtFemenino.ClientID %>").is(":checked");
            var contacto = $.trim($("#<%= txtContacto.ClientID %>").val());
            var email = $.trim($("#<%= txtEmail.ClientID %>").val());
            var telefono = $.trim($("#<%= txtTelefono.ClientID %>").val());
            
            var mensaje = '';

            if (rbtNatural) {
                
                if (nombre == '' || !evaluarAlfaEspacio(nombre))
                    mensaje += "<li>Ingrese el nombre.</li>";
                if (apePaterno == '' || !evaluarAlfaEspacio(apePaterno))
                    mensaje += "<li>Ingrese el apellido paterno.</li>";
                if (apeMaterno == '' || !evaluarAlfaEspacio(apeMaterno))
                    mensaje += "<li>Ingrese el apellido materno.</li>";
                if (!rbtMasculino && !rbtFemenino)
                    mensaje += "<li>Seleccione el sexo del cliente.</li>";
            }

            if (rbtJuridico) {
                if (nombre == '' || !evaluarAlfaEspacio(nombre))
                    mensaje += "<li>Ingrese la razón social.</li>";
            }

            if (tipoDoc == '0')
                mensaje += "<li>Seleccione el tipo de documento.</li>";
            if (nroDoc == '' || !esEnteroValido(nroDoc))
                mensaje += "<li>Ingrese el número de documento.</li>";
            if (email == '' || !esEmailValido(email))
                mensaje += "<li>Ingrese un email válido.</li>";
            if (telefono == '' || !esEnteroValido(telefono))
                mensaje += "<li>Ingrese un teléfono válido.</li>";
            
            var cantDirecciones = 0;
            var errorEnGrilla = false;
            $("#<%= dgvDirecciones.ClientID %> tr").each(function() {

                if (cantDirecciones >= 1) {
                    
                    var tipoDir = $(this).children("td").eq(0).find('select').eq(0).val();
                    var direccion = $.trim($(this).children("td").eq(1).find('input').eq(0).val());
                    var referencia = $.trim($(this).children("td").eq(2).find('input').eq(0).val());
                    var telefono = $.trim($(this).children("td").eq(3).find('input').eq(0).val());

                    if (tipoDir == '0') {
                        errorEnGrilla = true;
                        mensaje += "<li>[Dirección] Seleccione el tipo de dirección.</li>";
                    }
                    if (direccion == '') {
                        errorEnGrilla = true;
                        mensaje += "<li>[Dirección] Ingrese la dirección.</li>";
                    }
                    if (referencia == '') {
                        errorEnGrilla = true;
                        mensaje += "<li>[Dirección] Ingrese la referencia.</li>";
                    }
                    if (telefono == '' || !esEnteroValido(telefono)) {
                        errorEnGrilla = true;
                        mensaje += "<li>[Dirección] Ingrese un teléfono válido.</li>";
                    }
                    if (errorEnGrilla)
                        return;
                }
                
                cantDirecciones++;
            });

            if (cantDirecciones <= 1)
                mensaje += "<li>Ingrese al menos una dirección.</li>";
            
            if (mensaje != '') {
                mensaje = '<ul>' + mensaje + '</ul>';
                jcAlert('Datos Incompletos', mensaje, function(choice) { return choice });
                return false;
            }

            jcConfirm('Actualizar Cliente', '¿Desea actualizar el cliente?', function(choice) {

                if (choice) {
                    var event = "<%= btnGrabar.ClientID %>";
                    event = event.replace(/_/g, "$");
                    __doPostBack(event, '');
                }
            });
            
            return false;
        }

        function confirmarEliminar(event) {

            event = event.replace(/_/g, "$");

            jcConfirm('Eliminar Dirección', '¿Desea eliminar la dirección?', function(choice) {

                if (choice) {
                    __doPostBack(event, '');
                }
            });

            return false;
        }
    
    </script>
    
</asp:Content>
