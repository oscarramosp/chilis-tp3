<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HoraExtra.aspx.cs" Inherits="Pages_HoraExtra" %>

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
           <asp:TableHeaderCell BackColor="#4b6c9e" ForeColor="White" ColumnSpan="2" Font-Size="18" Wrap="false" VerticalAlign="Middle">Ingresar Horas Extras </asp:TableHeaderCell>
      </asp:TableRow>

      <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right"> <a href="Home.aspx">Menu Principal</a></asp:TableCell>
      </asp:TableRow>

      <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right">
                <asp:Table runat="server" ID="tbDatos" Width="70%" HorizontalAlign="Center" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" Width="100" Font-Bold="true">
                            Semana: 
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left">
                        <asp:DropDownList ID="drpSemana" runat="server" AutoPostBack="true" onselectedindexchanged="ddlSemana_SelectedIndexChanged"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left" Width="100" Font-Bold="true">
                            Trabajador: 
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left">
                        <asp:DropDownList ID="drpTrabajador" runat="server" AutoPostBack="true" onselectedindexchanged="ddlTrabajadores_SelectedIndexChanged"></asp:DropDownList>
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
             <asp:Table runat="server" ID="tbHorasExtras" Width="70%" HorizontalAlign="Center" GridLines="Both">
                

                <asp:TableRow>
                    <asp:TableCell Width="100" Font-Bold="true"></asp:TableCell>
                    <asp:TableCell Width="100" Font-Bold="true">Lunes</asp:TableCell>
                    <asp:TableCell Width="100" Font-Bold="true">Martes</asp:TableCell>
                    <asp:TableCell Width="100" Font-Bold="true">Miercoles</asp:TableCell>
                    <asp:TableCell Width="100" Font-Bold="true">Jueves</asp:TableCell>
                    <asp:TableCell Width="100" Font-Bold="true">Viernes</asp:TableCell>
                    <asp:TableCell Width="100" Font-Bold="true">Sabado</asp:TableCell>
                    <asp:TableCell Width="100" Font-Bold="true">Domingo</asp:TableCell>
                </asp:TableRow>

                 <asp:TableRow>
                    <asp:TableCell Width="100" Font-Bold="true">Entrada</asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtLunesE" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtMartesE" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtMiercolesE" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtJuevesE" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtViernesE" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtSabadoE" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtDomingoE" runat="server" ></asp:TextBox></asp:TableCell>
                </asp:TableRow>

                 <asp:TableRow>
                    <asp:TableCell Width="100" Font-Bold="true">Salida</asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtLunesS" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtMartesS" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtMiercolesS" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtJuevesS" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtViernesS" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtSabadoS" runat="server" ></asp:TextBox></asp:TableCell>
                    <asp:TableCell Width="100"><asp:TextBox Width="80" ReadOnly="true" ID="txtDomingoS" runat="server" ></asp:TextBox></asp:TableCell>
                </asp:TableRow>

                
                 <asp:TableRow>
                    <asp:TableCell Width="100" Font-Bold="true">Horas Extras</asp:TableCell>
                    <asp:TableCell Width="100"><asp:DropDownList ID="ddlLunes" runat="server" AutoPostBack="true" onselectedindexchanged="ddlDias_SelectedIndexChanged" ></asp:DropDownList></asp:TableCell>
                    <asp:TableCell Width="100"><asp:DropDownList ID="ddlMartes" runat="server" AutoPostBack="true" onselectedindexchanged="ddlDias_SelectedIndexChanged" ></asp:DropDownList></asp:TableCell>
                    <asp:TableCell Width="100"><asp:DropDownList ID="ddlMiercoles" runat="server" AutoPostBack="true" onselectedindexchanged="ddlDias_SelectedIndexChanged"></asp:DropDownList></asp:TableCell>
                    <asp:TableCell Width="100"><asp:DropDownList ID="ddlJueves" runat="server" AutoPostBack="true" onselectedindexchanged="ddlDias_SelectedIndexChanged"></asp:DropDownList></asp:TableCell>
                    <asp:TableCell Width="100"><asp:DropDownList ID="ddlViernes" runat="server" AutoPostBack="true" onselectedindexchanged="ddlDias_SelectedIndexChanged"></asp:DropDownList></asp:TableCell>
                    <asp:TableCell Width="100"><asp:DropDownList ID="ddlSabado" runat="server" AutoPostBack="true" onselectedindexchanged="ddlDias_SelectedIndexChanged"></asp:DropDownList></asp:TableCell>
                    <asp:TableCell Width="100"><asp:DropDownList ID="ddlDomingo" runat="server" AutoPostBack="true" onselectedindexchanged="ddlDias_SelectedIndexChanged"></asp:DropDownList></asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell ColumnSpan="7" Font-Bold="true" HorizontalAlign="Right">Total Horas Extra Semana</asp:TableCell>   
                    <asp:TableCell ><asp:TextBox ID="txtTotal" runat="server" Width="80"></asp:TextBox></asp:TableCell>   
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right" ColumnSpan="8">
                        <asp:Button runat="server" ID="btnImprimir"  Text="Imprimir" Width="80" Height="40"  OnClientClick="return window.print();" />
                        <asp:Button runat="server" ID="btnGrabar"  Text="Grabar" Width="80" Height="40" onclick="btnGrabar_Click"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="8">
                        <asp:Label ID="lblErrror" ForeColor="Red" Text="" runat="server" ></asp:Label>
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
