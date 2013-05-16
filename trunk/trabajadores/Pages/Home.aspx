<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Pages_Home" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="~/style/style.css" title="style" />

</head>
<body>
    <form id="form1" runat="server">
      <div id="main">
    <div id="header">
      <div id="logo">
        <div id="logo_text">
          <!-- class="logo_colour", allows you to change the colour of the text -->
          <h1>Modulo<span class="logo_colour"> Trabajadores</span></h1>
          <h2>Bienvenidos</h2>
        </div>
      </div>
      <div id="menubar">
        <ul id="menu">
          <!-- put class="selected" in the li tag for the selected page - to highlight which page you're on -->
          <li class="selected"><a href="IngresarPostulante.aspx">Postulante</a></li>
          <li><a href="ListarTrabajadoresActivos.aspx">Trabajador</a></li>
          <li><a href="HoraExtra.aspx">Horas Extras</a></li>
          <li><a href="Horario.aspx">Horario</a></li>
          <li><a href="CeseTrabajador.aspx">Cese</a></li>
          <li><a href="Reportes.aspx">Reportes</a></li>
          
        </ul>
      </div>
    </div>
    <div id="site_content">
      <div class="sidebar">
       
        <ul>
          <li><a href="IngresarPostulante.aspx">Ingreso de Postulante</a></li>
          <li><a href="ListarTrabajadoresActivos.aspx">Ingreso de Trabajador</a></li>
          <li><a href="HoraExtra.aspx">Horas Extras</a></li>
          <li><a href="Horario.aspx">Horario</a></li>
          <li><a href="CeseTrabajador.aspx">Cese de Trabajador</a></li>
          <li><a href="Reportes.aspx">Reportes</a></li>
        </ul>
       
      </div>
      <div id="content">
      
      </div>
    </div>
    <div id="content_footer"></div>
    <div id="footer">
      Copyright &copy; UPC 
    </div>
  </div>

    </form>
</body>
</html>
