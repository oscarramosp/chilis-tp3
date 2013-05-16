<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteHorario.aspx.cs" Inherits="Pages_ReporteHorario" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true"></asp:ScriptManager>
    
    <asp:UpdatePanel ID="upGeneral" UpdateMode="Conditional" runat="server">
        <ContentTemplate>

    <div>
    
    <asp:Table ID="tbEncabezado" Width="90%" runat="server" BorderStyle="None" GridLines="None" HorizontalAlign="Center" BackColor="WhiteSmoke">
      <asp:TableRow > 
           <asp:TableHeaderCell BackColor="#4b6c9e" ForeColor="White" ColumnSpan="2" Font-Size="18" Wrap="false" VerticalAlign="Middle">Reporte Horario </asp:TableHeaderCell>
      </asp:TableRow>

      <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right"> <a href="Reportes.aspx">Regresar a Reportes</a></asp:TableCell>
      </asp:TableRow>

      <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right">
                <asp:Table runat="server" ID="tbDatos" Width="50%" HorizontalAlign="Center" GridLines="None">
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Left" Width="20%" Font-Bold="true" >
                                Semana: 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Left" Width="40%">
                            <asp:DropDownList ID="drpSemana" runat="server" AutoPostBack="true" onselectedindexchanged="ddlSemana_SelectedIndexChanged"></asp:DropDownList>
                        </asp:TableCell>

                        <asp:TableCell HorizontalAlign="Left" Width="40%">
                            <asp:Button runat="server" ID="btnImprimir" Text="Imprimir" Width="80" Height="40"  OnClientClick="return window.print();" />
                        </asp:TableCell>
            
                   
                    </asp:TableRow>
                </asp:Table>        
            
            </asp:TableCell>
      </asp:TableRow>
      
      <asp:TableRow>
        <asp:TableCell>
             <asp:Table runat="server" ID="tbSemana" Width="100%" HorizontalAlign="Center" GridLines="Both">
                

                <asp:TableRow>
                    <asp:TableCell Width="70"  BackColor="#4b6c9e" ForeColor="White" Font-Bold="true" HorizontalAlign="Center"></asp:TableCell>
                    <asp:TableCell Width="200" BackColor="#4b6c9e" ForeColor="White" Font-Bold="true" HorizontalAlign="Center">Lunes</asp:TableCell>
                    <asp:TableCell Width="200" BackColor="#4b6c9e" ForeColor="White" Font-Bold="true" HorizontalAlign="Center">Martes</asp:TableCell>
                    <asp:TableCell Width="200" BackColor="#4b6c9e" ForeColor="White" Font-Bold="true" HorizontalAlign="Center">Miercoles</asp:TableCell>
                    <asp:TableCell Width="200" BackColor="#4b6c9e" ForeColor="White" Font-Bold="true" HorizontalAlign="Center">Jueves</asp:TableCell>
                    <asp:TableCell Width="200" BackColor="#4b6c9e" ForeColor="White" Font-Bold="true" HorizontalAlign="Center">Viernes</asp:TableCell>
                    <asp:TableCell Width="200" BackColor="#4b6c9e" ForeColor="White" Font-Bold="true" HorizontalAlign="Center">Sabado</asp:TableCell>
                    <asp:TableCell Width="200" BackColor="#4b6c9e" ForeColor="White" Font-Bold="true" HorizontalAlign="Center">Domingo</asp:TableCell>
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
