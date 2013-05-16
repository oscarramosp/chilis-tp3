<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IngresarTrabajador.aspx.cs" Inherits="Pages_IngresarTrabajador" %>
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
           <asp:TableHeaderCell BackColor="#4b6c9e" ForeColor="White" ColumnSpan="2" Font-Size="18" Wrap="false" VerticalAlign="Middle">Ingresar Trabajador </asp:TableHeaderCell>
      </asp:TableRow>

       <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right"> <a href="Home.aspx">Menu Principal</a></asp:TableCell>
     </asp:TableRow>
      
      <asp:TableRow>
        <asp:TableCell>
             <asp:TabContainer ID="tbcTrabajador" runat="server" >
                <asp:TabPanel ID="tpTrabajadorGenerral" HeaderText="Datos Personales" runat="server" BackColor="WhiteSmoke" >
                    <ContentTemplate>
                            <asp:Table ID="tbTrabajadorGeneral" runat="server" BorderStyle="None" GridLines="None" Width="100%">
                                         
                                    <asp:TableRow>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Nombre:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtNombre" runat="server" Width="150"></asp:TextBox>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar su Nombre" Font-Size="Medium" ID="rfvNombre" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtNombre" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Ape. Paterno:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtPaterno" runat="server" Width="150"></asp:TextBox>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar su Ape. Paterno" Font-Size="Medium" ID="RequiredFieldValidator1" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtPaterno" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Ape. Materno:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtMaterno" runat="server" Width="150"></asp:TextBox>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar su Ape. Materno" Font-Size="Medium" ID="RequiredFieldValidator2" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtMaterno" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                    </asp:TableRow>

                                    <asp:TableRow>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Documento:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:DropDownList ID="drpDocumento" runat="server"></asp:DropDownList>
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        N.- Documento:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtNumero" runat="server" Width="100"></asp:TextBox>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar N.- Documento" Font-Size="Medium" ID="rfvDescripcion" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtNumero" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Sexo:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:DropDownList ID="drpSexo" runat="server"></asp:DropDownList>
                                        
                                      </asp:TableCell>
                                    </asp:TableRow>

                                    <asp:TableRow>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Fec. Nacimiento:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtFecNac" runat="server" Width="100"></asp:TextBox>
                                        <asp:CalendarExtender runat="server" ID="CFechaReunion" TargetControlID="txtFecNac"></asp:CalendarExtender>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar Fec. de Nac." Font-Size="Medium" ID="RequiredFieldValidator3" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtFecNac" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Direccion:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtDir" runat="server" Width="150"></asp:TextBox>
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Telefono:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtTelefono" runat="server" Width="150"></asp:TextBox>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar Telefono" Font-Size="Medium" ID="RequiredFieldValidator5" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtTelefono" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                    </asp:TableRow>

                                    <asp:TableRow>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Correo:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true" ColumnSpan="3">
                                        <asp:TextBox ID="txtCorreo" runat="server" Width="200"></asp:TextBox>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar Correo" Font-Size="Medium" ID="RequiredFieldValidator6" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtCorreo" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                      
                                    </asp:TableRow>

                                 
                                
                                          
                                </asp:Table>
                    
                    </ContentTemplate>

                </asp:TabPanel>
                
                <asp:TabPanel ID="tpPuesto" HeaderText="Datos del Puesto" runat="server" BackColor="WhiteSmoke" >
                    <ContentTemplate>
                        <asp:Table ID="tbPuesto" runat="server" BorderStyle="None" GridLines="None" HorizontalAlign="Center" Width="70%" >
                           <asp:TableRow HorizontalAlign="Left" Font-Bold="true">
                                <asp:TableCell BackColor="#4b6c9e" ForeColor="White" ColumnSpan="2">Datos del Puesto:</asp:TableCell>
                           </asp:TableRow>
                           <asp:TableRow>
                                 <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Cargo:
                                 </asp:TableCell>
                                 <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:DropDownList ID="drpCargo" runat="server"></asp:DropDownList>
                                 </asp:TableCell>
                           </asp:TableRow>
                           <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                     Tipo Trabajador:
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                    <asp:DropDownList ID="drpTipoTrabajador" runat="server"></asp:DropDownList>
                                 </asp:TableCell>
                           
                           </asp:TableRow>
                                   
                           <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                     Fecha de Inicio:
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                     <asp:TextBox ID="txtInicio" runat="server" Width="100"></asp:TextBox>
                                        <asp:CalendarExtender runat="server" ID="ceInicio" TargetControlID="txtInicio"></asp:CalendarExtender>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar Fec. de Inicio." Font-Size="Medium" ID="RequiredFieldValidator4" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtInicio" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                 </asp:TableCell>
                           
                           </asp:TableRow>

                             <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                     Fecha de Fin:
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                     <asp:TextBox ID="txtFin" runat="server" Width="100"></asp:TextBox>
                                        <asp:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="txtFin"></asp:CalendarExtender>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar Fec. de Inicio." Font-Size="Medium" ID="RequiredFieldValidator7" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtFin" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                 </asp:TableCell>
                           
                           </asp:TableRow>

                           <asp:TableRow>
                                <asp:TableCell ColumnSpan="2">
                                    <asp:GridView Width="100%" ID="gvResultado" runat="server" AllowPaging="True" AutoGenerateColumns="False" HeaderStyle-ForeColor="White" AlternatingRowStyle-BackColor="LightGray"  HorizontalAlign="Center" EmptyDataText="No hay Informacion Disponible" onrowcancelingedit="gvResultado_RowCancelingEdit"  onrowediting="gvResultado_RowEditing" onrowupdating="gvResultado_RowUpdating">
                                        <AlternatingRowStyle BackColor="LightGray"></AlternatingRowStyle>
                                    <Columns>
                                       <asp:TemplateField HeaderText="Editar">
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="lkbUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Actualizar" ></asp:LinkButton>
                                                &nbsp;<asp:LinkButton ID="lkbCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar"></asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lkbEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Editar"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                                                                                
                                            <ItemTemplate>
                                                <asp:Label ID="lblCodigo" runat="server" Text='<%# Bind("Codigo") %>' ></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Cargo" HeaderText="Cargo" ReadOnly="True" SortExpression="Cargo" />
                                        <asp:BoundField DataField="Tipo"  HeaderText="Tipo" ReadOnly="True" SortExpression="Tipo" />
                                        <asp:TemplateField HeaderText="FechaInicio" SortExpression="FechaInicio">
                                            <EditItemTemplate>
                                              <asp:TextBox ID="txtFechaInicio" runat="server" Width="80px" Text='<%# Bind("FechaInicio") %>'></asp:TextBox>
                                              <asp:CalendarExtender runat="server" ID="CFechaInicio" TargetControlID="txtFechaInicio"></asp:CalendarExtender>
                                            </EditItemTemplate>
                                        
                                            <ItemTemplate>
                                                <asp:Label ID="lblInicio" runat="server" Text='<%# Bind("FechaInicio") %>' ></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         
                                         <asp:TemplateField HeaderText="FechaFin" SortExpression="FechaFin">
                                            <EditItemTemplate>
                                              <asp:TextBox ID="txtFechaFin" runat="server" Width="80px" Text='<%# Bind("FechaFin") %>'></asp:TextBox>
                                              <asp:CalendarExtender runat="server" ID="CFechaFin" TargetControlID="txtFechaFin"></asp:CalendarExtender>
                                            </EditItemTemplate>
                                        
                                            <ItemTemplate>
                                                <asp:Label ID="lblFin" runat="server" Text='<%# Bind("FechaFin") %>' ></asp:Label>
                                            </ItemTemplate>
                                         </asp:TemplateField>
                                        
                                     </Columns>

                                    <HeaderStyle BackColor="#4b6c9e" ForeColor="White"></HeaderStyle>
                                </asp:GridView>
                                
                                </asp:TableCell>
                                                   
                           </asp:TableRow>

                       
                        </asp:Table>
                    </ContentTemplate>
                
                </asp:TabPanel>    
            </asp:TabContainer>

        
    
        </asp:TableCell>
      </asp:TableRow>

          
        <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right" Font-Bold="true" ColumnSpan="6">
                    <asp:Button ID="btnGrabar" Height="40" BackColor="WhiteSmoke" runat="server" ValidationGroup="Datos" Text="Grabar" OnClick="btnGrabar_Click" />
            </asp:TableCell>
        </asp:TableRow>

      <asp:TableRow>
        <asp:TableCell HorizontalAlign="Left" ColumnSpan="6">
            <asp:ValidationSummary runat="server" ForeColor="Red" ID="vsDatos" DisplayMode="List" BorderStyle="Dotted" ShowSummary="true"  ValidationGroup="Datos"/>
        </asp:TableCell>
      </asp:TableRow>

      <asp:TableRow>
           <asp:TableCell HorizontalAlign="Left" ColumnSpan="6">
                 <asp:Label ID="lblErrror" runat="server" Text=""></asp:Label>
           </asp:TableCell>
      </asp:TableRow>
    
    </asp:Table>


    </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
