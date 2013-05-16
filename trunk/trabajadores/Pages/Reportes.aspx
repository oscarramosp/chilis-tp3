<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reportes.aspx.cs" Inherits="Pages_Reportes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" type="text/css" href="~/style/style.css" title="style" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true"></asp:ScriptManager>
    
    <asp:UpdatePanel ID="upGeneral" UpdateMode="Conditional" runat="server">
        <ContentTemplate>

    <div>
    
    <asp:Table ID="tbEncabezado" Width="90%" runat="server" BorderStyle="None" GridLines="None" HorizontalAlign="Center" BackColor="WhiteSmoke">
      <asp:TableRow > 
           <asp:TableHeaderCell BackColor="#4b6c9e" ForeColor="White" ColumnSpan="2" Font-Size="18" Wrap="false" VerticalAlign="Middle">Reportes </asp:TableHeaderCell>
      </asp:TableRow>

      <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right"> <a href="Home.aspx">Menu Principal</a></asp:TableCell>
      </asp:TableRow>

       <asp:TableRow>
            <asp:TableCell HorizontalAlign="Left">
            
                  <div class="sidebar">
       
                    <ul>
                      <li><a href="ReporteHorario.aspx">Horario Semanal</a></li>
                      <li><a href="ReporteTrabajadores.aspx">Trabajadores</a></li>
                      <li><a href=""></a></li>
                      <li><a href=""></a></li>
                      <li><a href=""></a></li>
                    </ul>
       
                  </div>
            
            </asp:TableCell>
      </asp:TableRow>




      
       
    </asp:Table>


    </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
