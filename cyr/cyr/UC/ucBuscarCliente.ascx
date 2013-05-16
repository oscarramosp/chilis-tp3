<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucBuscarCliente.ascx.cs" Inherits="cyr.UC.ucBuscarCliente" %>
<fieldset>
    <legend>Datos del Cliente</legend>
    <div class="border-container">
        <div class="filter-row">
            <div class="filter-label" style="width: 90px;">
                Tipo de Doc.:
            </div>
            <div class="filter-data" style="width: 150px;">
                <asp:DropDownList ID="ddlTipoDoc" runat="server" CssClass="select" Width="95" Enabled="false">
                </asp:DropDownList>
            </div>
            <div class="filter-label" style="width: 100px;">
                Nro. Documento:
            </div>
            <div class="filter-data" style="width: 150px;">
                <asp:TextBox ID="txtNroDoc" runat="server" Width="100" CssClass="classInput" MaxLength="11" Enabled="false"></asp:TextBox>
                <asp:HiddenField ID="hdnCodigoCliente" runat="server" />
            </div>
            <div class="filter-data" style="width: 60px;">
                <asp:Button ID="btnBuscarCliente" runat="server" Text="Buscar Cliente" 
                    CssClass="alt-button" onclick="btnBuscarCliente_Click" />
            </div>
            <div class="clear">
            </div>
        </div>
        <div class="filter-row">
            <div class="filter-label" style="width: 90px;">
                Nombres:
            </div>
            <div class="filter-data" style="width: 250px;">
                <asp:TextBox ID="txtNombre" runat="server" Width="250" CssClass="classInput" MaxLength="256" Enabled="false"></asp:TextBox>
            </div>
            <div class="clear">
            </div>
        </div>
        <div class="filter-row">
            <div class="filter-label" style="width: 90px;">
                Tel&eacute;fono:
            </div>
            <div class="filter-data" style="width: 250px;">
                <asp:TextBox ID="txtTelefono" runat="server" Width="100" CssClass="classInput" MaxLength="15" Enabled="false"></asp:TextBox>
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
</fieldset>