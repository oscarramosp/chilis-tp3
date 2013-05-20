<%@ Page Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" CodeBehind="AprobarReservasEspeciales.aspx.cs" Inherits="cyr.AprobarReservasEspeciales" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">

<asp:ScriptManager ID="smFiltrosCliente" runat="server">
</asp:ScriptManager>

    <div class="divClubChilis">
        <div>
            <asp:UpdatePanel ID="upReservaEspecial" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="border-container">
                    <div class="filter-row">
                        <div class="filter-label" style="width: 130px;">
                    
                        </div>
                       
                        <div class="clear">
                        </div>
                    </div>
                    
                    <div class="filter-row" runat="server" id="divEstado">
               
                        <div class="filter-data" style="text-align:right; width: 90px;">
                            <asp:Button ID="btnAprobar" runat="server" Text="Aprobar" CssClass="button" 
                                onclick="btnAprobar_Click" />
                        </div>
                  
                       <div class="filter-data" style="text-align:right; width: 90px;">
                            <asp:Button ID="btnRechazar" runat="server" Text="Rechazar" CssClass="button" 
                                onclick="btnRechazar_Click" />
                        </div>
                        <div class="clear" style="height: 15px;">
                        </div>
                    </div>   
                </div>
                
            </ContentTemplate>
          <Triggers>
                <asp:PostBackTrigger ControlID="btnAprobar" />
                 <asp:PostBackTrigger ControlID="btnRechazar" />
            </Triggers>
            </asp:UpdatePanel>
        </div>
       <div style="vertical-align: middle; text-align: center; height: 27px;">
            <asp:Label ID="lblSinResultados" CssClass="strong" runat="server" Visible="false"></asp:Label>
        </div>
        <div style="vertical-align: middle; text-align: center; height: 27px;">
            <asp:Label ID="lblResultadoCorreo" CssClass="strong" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="resultado-reporte" id="divResultado" runat="server" visible="true">
            
            <div style="overflow: auto; min-height:180px; max-height: 400px;">
                <asp:GridView id="dgvReservaEspecial" runat="server" AutoGenerateColumns="False" Width="817px"
                BorderColor="#ECECEC" BorderStyle="Solid" 
                    onrowdatabound="dgvReservaEspecial_RowDataBound" 
                    onrowcommand="dgvReservaEspecial_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Selec.">
                            <ItemTemplate>

                             <asp:CheckBox ID="chk" runat="server" Width ="10px"  />
                            </ItemTemplate>
                        </asp:TemplateField>
                               <asp:TemplateField HeaderText="Estado">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("Estado") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Codigo">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:Label ID="lblCodigo" runat="server" Text='<%# Eval("CodigoReserva") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                          <asp:TemplateField HeaderText="Cliente">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="250px" />
                            <ItemTemplate>
                                <asp:Label ID="lblCliente" runat="server" Text='<%# Eval("Cliente.RazonSocial") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                           <asp:TemplateField HeaderText="Fecha Solicitada">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:Label ID="lblFecha" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval("FechaReserva")) %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                             <asp:TemplateField HeaderText="Hora Desde">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:Label ID="lblHoraInicio" runat="server" Text='<%# Eval("HoraInicio") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cantidad Horas">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:Label ID="lblCantHoras" runat="server" Text='<%# Eval("CantidadHoras") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Cantidad Personas">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="60px" />
                            <ItemTemplate>
                                <asp:Label ID="lblCantPersonas" runat="server" Text='<%# Eval("CantidadPersonas") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
           
                      <asp:TemplateField HeaderText="Observacion">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="120px" />
                            <ItemTemplate>
                                <asp:Label ID="lblobservacion" runat="server" Text='<%# Eval("Observacion") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email" Visible="False">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="120px" />
                            <ItemTemplate>
                                <asp:Label ID="lblemail" runat="server" Text='<%# Eval("Cliente.Email") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nombres" Visible="False">
                            <ItemStyle HorizontalAlign="Center" Height="23px" Width="120px" />
                            <ItemTemplate>
                                <asp:Label ID="lblNombres" runat="server" Text='<%# Eval("Cliente.Nombres") %>'></asp:Label>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                   
                    </Columns>
                </asp:GridView>
            </div>  
        </div>
 
    </div>
     <script type="text/javascript">
        $(document).ready(function() {

        $("#<%= btnAprobar.ClientID %>").click(function() {
            return confirmarGrabar();
        });

        $("#<%= btnRechazar.ClientID %>").click(function() {
            return confirmarRechazar();
        });

    });

        function confirmarGrabar() {
 
            jcConfirm('Aprobar Fecha Especial', '¿Desea aprobar la reserva de fecha especial?', function(choice) {

                if (choice) {
                    var event = "<%= btnAprobar.ClientID %>";
                    event = event.replace(/_/g, "$");
                    __doPostBack(event, '');
                }
            });

            return false;
        }

        function confirmarRechazar() {

            jcConfirm('Rechazar Fecha Especial', '¿Desea rechazar la reserva de fecha especial?', function(choice) {

                if (choice) {
                    var event = "<%= btnRechazar.ClientID %>";
                    event = event.replace(/_/g, "$");
                    __doPostBack(event, '');
                }
            });

            return false;
        }
    </script>
    
</asp:Content>

