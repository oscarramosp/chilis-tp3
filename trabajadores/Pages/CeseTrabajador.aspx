<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CeseTrabajador.aspx.cs" Inherits="Pages_CeseTrabajador" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true"></asp:ScriptManager>
    
    <asp:UpdatePanel ID="upGeneral" UpdateMode="Conditional" runat="server">
        <ContentTemplate>

    <div>
    
    <asp:Table ID="tbEncabezado" Width="90%" runat="server" BorderStyle="None" GridLines="None" HorizontalAlign="Center" BackColor="WhiteSmoke">
      <asp:TableRow > 
           <asp:TableHeaderCell BackColor="#4b6c9e" ForeColor="White" ColumnSpan="2" Font-Size="18" Wrap="false" VerticalAlign="Middle">Cese de Trabajador </asp:TableHeaderCell>
      </asp:TableRow>

      <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right"> <a href="Home.aspx">Menu Principal</a></asp:TableCell>
      </asp:TableRow>

      <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right">
                <asp:Table runat="server" ID="tbDatos" Width="70%" HorizontalAlign="Center" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" Width="100" Font-Bold="true">
                            Trabajador: 
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left" Width="100">
                        <asp:DropDownList ID="drpTrabajador" runat="server" AutoPostBack="true" onselectedindexchanged="ddlTrabajadores_SelectedIndexChanged"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell Width="200">
                    </asp:TableCell>
                </asp:TableRow>
               
               <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" Width="100" Font-Bold="true">
                        Codigo: <asp:Label ID="lblCodigo" ForeColor="Red" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left"  Font-Bold="true">
                        Cargo: <asp:DropDownList ID="drpCargo" Enabled="false" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left" Width="100" Font-Bold="true" ColumnSpan="2">
                        Tipo Trab: <asp:DropDownList ID="drpTipo" Enabled="false" runat="server"></asp:DropDownList>     
                    </asp:TableCell>
               
                </asp:TableRow>
                
                </asp:Table>        
            
            </asp:TableCell>
      </asp:TableRow>
      
      <asp:TableRow>
        <asp:TableCell>
             <asp:Table runat="server" ID="tbCese" Width="70%" HorizontalAlign="Center" GridLines="Horizontal">
                

                <asp:TableRow>
                    <asp:TableCell Width="70" Font-Bold="true">Fecha de Cese:</asp:TableCell>
                    <asp:TableCell Width="100" Font-Bold="true">
                        <asp:TextBox ID="txtFechaCese" runat="server"></asp:TextBox>
                        <asp:CalendarExtender runat="server" ID="cFechaCese" TargetControlID="txtFechaCese"></asp:CalendarExtender>
                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar Fecha de Cese" Font-Size="Medium" ID="RequiredFieldValidator3" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtFechaCese" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                    </asp:TableCell>
                    <asp:TableCell Width="50" Font-Bold="true">Motivo:</asp:TableCell>
                    <asp:TableCell Width="200" Font-Bold="true">
                        <asp:DropDownList ID="drpMotivo" runat="server"></asp:DropDownList>      
                    </asp:TableCell>
                    
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="4" Font-Bold="true">
                         Observación:
                    </asp:TableCell>
                </asp:TableRow>

                 <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="4">
                         <asp:TextBox ID="txtMotivo" runat="server" TextMode="MultiLine" Width="600" Height="50"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
        

                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right" ColumnSpan="4">
                         <asp:Button runat="server" ID="btnGrabar"  Text="Grabar" Width="80" Height="40" onclick="btnGrabar_Click" ValidationGroup="Datos"/>
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="4">
                        <asp:Label ID="lblErrror" ForeColor="Red" Text="" runat="server" ></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                         
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="4">
                        <asp:ValidationSummary runat="server" ForeColor="Red" ID="vsDatos" DisplayMode="List" BorderStyle="Dotted" ShowSummary="true"  ValidationGroup="Datos"/>
                    </asp:TableCell>
                </asp:TableRow>

             </asp:Table>
    
        </asp:TableCell>
      </asp:TableRow>

   
       
    </asp:Table>


    </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
