<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListarTrabajadoresActivos.aspx.cs" Inherits="Pages_ListarTrabajadoresActivos" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Table ID="tbResultado" runat="server" GridLines="Both" BorderWidth="0px" HorizontalAlign="Center" CellSpacing="5" CellPadding="5" Width="850" BackColor="White">         
                  <%--  <%--------------Tabla Resultado----------- %>--%>
    <asp:TableRow>
            <asp:TableHeaderCell BackColor="#4b6c9e" ForeColor="White" Font-Size="18">Mantenimiento de Trabajadores </asp:TableHeaderCell>
    </asp:TableRow>

    <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right"> <a href="Home.aspx">Menu Principal</a></asp:TableCell>
    </asp:TableRow>

    <asp:TableRow>
        <asp:TableCell HorizontalAlign="Left"> 
            <asp:LinkButton ID="lkbNuevo" Text="Ingresar Nuevo Trabajador" runat="server"></asp:LinkButton>
        </asp:TableCell>
        
    </asp:TableRow>
    
     <asp:TableRow>
        <asp:TableCell>

          <asp:GridView ID="gvResultado" runat="server" AllowPaging="True" AutoGenerateColumns="False" HeaderStyle-BackColor="#4b6c9e"  HeaderStyle-ForeColor="White" AlternatingRowStyle-BackColor="LightGray" onpageindexchanging="gvResultado_PageIndexChanging" HorizontalAlign="Center" EmptyDataText="No hay Informacion Disponible" PageSize="5">
            <AlternatingRowStyle BackColor="LightGray"></AlternatingRowStyle>
        <Columns>
            <asp:BoundField DataField="Codigo" HeaderText="Codigo" ReadOnly="True" SortExpression="Codigo" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre Completo" ReadOnly="True" SortExpression="Nombre" />
            <asp:BoundField DataField="Cargo" HeaderText="Cargo" ReadOnly="True" SortExpression="Cargo" />
            <asp:BoundField DataField="TipoTrabajador" HeaderText="Tipo Trabajador" ReadOnly="True" SortExpression="TipoTrabajador" />
            <asp:HyperLinkField DataNavigateUrlFields="Link" DataTextField="Modificar" HeaderText="Modificar" />
        </Columns>

<HeaderStyle BackColor="#4b6c9e" ForeColor="White"></HeaderStyle>
     </asp:GridView>

        </asp:TableCell>
     </asp:TableRow>
     
        
     </asp:Table>

    
    </div>
    </form>
</body>
</html>
