<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="frmConsultaProductos.aspx.cs" Inherits="AppAlmacen.Interfaces.Productos.frmConsultaProductos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/Controles/ucwFecha.ascx" TagName="ucwFecha" TagPrefix="uc1" %>
<%@ Register Src="~/Controles/ucwTituloPopup.ascx" TagName="ucwTituloPopup" TagPrefix="uc7" %>
<%@ Register Src="~/Controles/ucwGrabarCerrar.ascx" TagName="ucwGrabarCerrar" TagPrefix="uc8" %>
 <%@ Register Src="~/Controles/ucwBuscarLimpiar.ascx" TagName="ucwBuscarLimpiar"
    TagPrefix="uc3" %>
    
    <script src="../../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="../../Scripts/JScript.js">    
    </script>
    <link href="../../App_Themes/Principal/estilos.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<script language="javascript" type="text/javascript">


    function ImgCLick() {
        document.getElementById("ucwProductos_imbAgregar").click();
    }
    function DoScroll() {
        try {
            document.getElementById("DataGridCabecera").style.pixelLeft = -(divScroll.scrollLeft);
        } catch (ex) { }
    }
   </script>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager runat="server" ID="scriptID"></asp:ScriptManager>
  <asp:Panel ID="pnlProductos" runat="server" Width="624px" Height="313px">
        <div style="background-color: #FFF8E9; width: 102%; height: 319px;">
            <table style="width: 640px; height: 311px;" border="0" cellpadding="0" 
                cellspacing="0">
                <tr style="height: 2px">
                    <td class="style3">
                    </td>
                </tr>
                <tr>
                    <td height="20" class="style3">
                        <table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="18" class="emg_tittle">
                                    &nbsp;</td>
                                <td width="24" valign="top">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        <div class="emg_text">
                            <table id="Sub_Tabla" style="width: 100%">
                                <tr>
                                    <td style="height: 14px; width: 100%">
                                        <div class="EstiloTitulo">
                                            <div class="EstiloTituloBandeja" 
                                                style="width: 100%; top: 0px; left: 0px; height: 11px;">
                                                <uc7:ucwTituloPopup ID="ucwTituloBandeja" runat="server" />
                                            </div>
                                            <div class="ContenedorBotones" style="vertical-align: middle">
                                                <table>
                                                    <tr>
                                                        <td>
                                                                <uc3:ucwbuscarlimpiar ID="ucwBuscarLimpiar" runat="server"  VisibleExportar="false" CausesValidationBuscar="false" CausesValidationLimpiar="false"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                           
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                         <div>
                                              <table class="TablaRegistros">
           
          
            <tr> <td>Codigo Producto</td>
                    <td>
        <asp:TextBox runat="server" ID="txtCodigo"></asp:TextBox>  </td>
                  <td>Nombre Producto</td>
                    <td>
        <asp:TextBox runat="server" ID="txtNombre" Width="260px"></asp:TextBox>  </td>
        
                  
            
            </tr>
          
        </table>
        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="upFindProyectoFase" runat="server">
                                            <ContentTemplate>
                                              <table border=0 cellpadding=0 cellspacing=0 >
                                    <tr><td>
                                     <div 
                                                  style=" OVERFLOW: hidden; width:600px" >               
						                     <table ID="DataGridCabecera" border="1" cellpadding="0" cellspacing="0" 
                                                 class="cGrid" style="POSITION:relative;z-index:50;table-layout:inherit" 
                                                 width="600px">
                                                 <tr class="cajaFormulario">
                                                     <td align="center" style="width:100px">
                                                         Codigo</td>
                                                     <td align="center" style="width:200px">
                                                         Nombre</td>
                                                     <td align="center" style="width:200px">
                                                         Descripcion</td>
                                                 </tr>
                                             </table>
                                                      </div>

                                                            </td></tr><tr><td>
                                             <div style="OVERFLOW: auto; width:619px; height: 175px;" ID="divScroll" 
                                                 onscroll="DoScroll()" >
				                                 <asp:Panel ID="Panel1div" runat="server" BorderWidth="0" ScrollBars="None">
                                                     <table border="0" cellpadding="0" cellspacing="0" style="table-layout:inherit" 
                                                         width="600px">
                                                         <tr>
                                                             <td>
                                                                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                     <ContentTemplate>
                                                                         <div style="width: 100%">
                                                                             <table ID="tblTablaFases" border="0" cellpadding="0" style="width: 100%">
                                                                                 <tr>
                                                                                     <td style="width: 100%">
                                                                                         <asp:GridView ID="gdvListado" runat="server" AutoGenerateColumns="False" 
                                                                                             DataKeyNames="codigo"
                                                                                             ShowHeader="False" Width="600px">
                                                                                             <Columns>
                                                                                                 <asp:BoundField DataField="codigoPr" HeaderText="codigoPr">
                                                                                                 <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                                                 </asp:BoundField>

                                                                                                 <asp:BoundField DataField="Nombre" HeaderText="Nombre">
                                                                                                 <HeaderStyle HorizontalAlign="Center" Width="200px" />
                                                                                                 </asp:BoundField>
                                                                                                 <asp:BoundField DataField="Descripcion" HeaderText="Descripcion">
                                                                                                 <HeaderStyle HorizontalAlign="Center" Width="200px" />
                                                                                                 </asp:BoundField>
                                                                                                
                                                                                             </Columns>
                                                                                         </asp:GridView>
                                                                                     </td>
                                                                                 </tr>
                                                                             </table>
                                                                         </div>
                                                                     </ContentTemplate>
                                                                 </asp:UpdatePanel>
                                                             </td>
                                                         </tr>
                                                     </table>
                                                 </asp:Panel>
                                             </div>
                                         
									    
									     
									      </td>
								    </tr>
							    </table>
						    	
					            </ContentTemplate>
					            </asp:UpdatePanel>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
</div>
    </div>
    </form>
</body>
</html>
