<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IngresarPostulante.aspx.cs" Inherits="Pages_IngresarPostulante" %>
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
           <asp:TableHeaderCell BackColor="#4b6c9e" ForeColor="White" ColumnSpan="2" Font-Size="18" Wrap="false" VerticalAlign="Middle">Ingresar Postulante </asp:TableHeaderCell>
           
      </asp:TableRow>

      <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right"> <a href="Home.aspx">Menu Principal</a></asp:TableCell>
      </asp:TableRow>
      
      <asp:TableRow>
        <asp:TableCell>
             <asp:TabContainer ID="tbcPostulante" runat="server" >
                <asp:TabPanel ID="tpPostulanteGenerral" HeaderText="Datos Personales" runat="server" BackColor="WhiteSmoke" >
                    <ContentTemplate>
                            <asp:Table ID="tbPostulanteGeneral" runat="server" BorderStyle="None" GridLines="None" Width="100%">
                                         
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
                                        DNI:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtDNI" runat="server" Width="150"></asp:TextBox>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar su DNI" Font-Size="Medium" ID="RequiredFieldValidator3" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtDNI" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Fec. Nacimiento:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtFecNac" runat="server" Width="100"></asp:TextBox>
                                        <asp:CalendarExtender runat="server" ID="CFechaReunion" TargetControlID="txtFecNac"></asp:CalendarExtender>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar Fec. de Nac." Font-Size="Medium" ID="rfvDescripcion" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtFecNac" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
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
                                        Nacionalidad:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:DropDownList ID="drpNac" runat="server"></asp:DropDownList>
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
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TextBox ID="txtCorreo" runat="server" Width="200"></asp:TextBox>
                                        <asp:RequiredFieldValidator Width="5" ErrorMessage="- Debe ingresar Correo" Font-Size="Medium" ID="RequiredFieldValidator6" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtCorreo" ValidationGroup="Datos"></asp:RequiredFieldValidator> 
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Cargo:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:DropDownList ID="drpCargo" runat="server"></asp:DropDownList>
                                      </asp:TableCell>
                                       <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        Disponibilidad:
                                      </asp:TableCell>
                                      <asp:TableCell HorizontalAlign="Left" Font-Bold="true">
                                        <asp:DropDownList ID="drpDisponibilidad" runat="server"></asp:DropDownList>
                                      </asp:TableCell>
                                    </asp:TableRow>


                                    <asp:TableRow>
                                      <asp:TableCell HorizontalAlign="Right" Font-Bold="true" ColumnSpan="6">
                                        <asp:Button ID="btnSiguiente" Height="40" BackColor="WhiteSmoke" runat="server"  OnClick="btnSiguiente_Click" ValidationGroup="Datos" Text="Siguiente" />
                                      </asp:TableCell>
                                    </asp:TableRow>

                                     <asp:TableRow>
                                      <asp:TableCell HorizontalAlign="Left" ColumnSpan="6">
                                      <asp:ValidationSummary runat="server" ForeColor="Red" ID="vsDatos" DisplayMode="List" BorderStyle="Dotted" ShowSummary="true"  ValidationGroup="Datos"/>
                                      </asp:TableCell>
                                    </asp:TableRow>

                                   
                                </asp:Table>
                    
                    </ContentTemplate>

                </asp:TabPanel>
                
                <asp:TabPanel ID="tpFormacion" HeaderText="Formacion" Visible="false" runat="server" BackColor="WhiteSmoke" >
                    <ContentTemplate>
                        <asp:Table ID="tbFormacion" runat="server" BorderStyle="None" GridLines="None" Width="100%" >
                           <asp:TableRow HorizontalAlign="Left" Font-Bold="true">
                                <asp:TableCell BackColor="#4b6c9e" ForeColor="White">Formación:</asp:TableCell>
                           </asp:TableRow>

                            <asp:TableRow>
                            
                            <asp:TableCell>
                            <asp:GridView ID="gvFormacion" runat="server" AutoGenerateColumns="False" ShowFooter="False"  ShowHeader="true" Width="100%" OnRowDataBound="gvFormacion_RowDataBound" >
                                            <Columns>
                                                <asp:TemplateField HeaderText="Operaciones" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%# Eval("IdFormacion") %>' OnClick="lnkDeleteFormacion_Click">Eliminar</asp:LinkButton>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Nivel" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:DropDownList ID="ddlNivel" runat="server"> </asp:DropDownList>
                                                            <asp:CompareValidator ID="cvNivel" ForeColor="Red" runat="server" ControlToValidate="ddlNivel" ErrorMessage="Debe Seleccionar Nivel" Operator="NotEqual" Text="*" ValueToCompare="0" ValidationGroup="Grabar"></asp:CompareValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Titulo" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:TextBox ID="txtTitulo" runat="server" Text='<%# Eval("Titulo") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvTitulo" runat="server" ForeColor="Red" ControlToValidate="txtTitulo" ErrorMessage="Debe Seleccionar Titulo" ValidationGroup="Grabar">*</asp:RequiredFieldValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Fecha Titulación" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:TextBox ID="txtFechaTitulacion" runat="server" Text='<%# Eval("FechaTitulacion") %>' Width="80px"></asp:TextBox>
                                                            <asp:CalendarExtender runat="server" ID="ceFecTitulacion" TargetControlID="txtFechaTitulacion"></asp:CalendarExtender>
                                                            <asp:RequiredFieldValidator ID="rfvFechaTitulacion" ForeColor="Red" runat="server" ControlToValidate="txtFechaTitulacion" ErrorMessage="Debe seleccionar Fecha de Titulacion" ValidationGroup="Grabar">*</asp:RequiredFieldValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Situación" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:DropDownList ID="ddlSituacion" runat="server"> </asp:DropDownList>
                                                            <asp:CompareValidator ID="cvSituacion" runat="server" ForeColor="Red" ControlToValidate="ddlSituacion" ErrorMessage="Debe Seleccionar Situacion" Operator="NotEqual" Text="*" ValueToCompare="0" ValidationGroup="Grabar"></asp:CompareValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Años Formado" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:TextBox ID="txtAnioFormado" runat="server" Text='<%# Eval("AnioFormado") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvAnioFormado" runat="server" ControlToValidate="txtAnioFormado" ErrorMessage="*" ValidationGroup="Grabar">*</asp:RequiredFieldValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle BackColor="#4b6c9e" ForeColor="White" Font-Size="Small" />
                                        </asp:GridView>
                                    </asp:TableCell>
                                    </asp:TableRow>

                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                                <asp:Button ID="btnAddFormacion" runat="server" Text="Añadir" CssClass="botton" OnClick="btnAddFormacion_Click" />
                                        </asp:TableCell>
                                    </asp:TableRow>

                               

                                     <asp:TableRow HorizontalAlign="Left" Font-Bold="true">
                                            <asp:TableCell BackColor="#4b6c9e" ForeColor="White">Habilidades Linguísticas::</asp:TableCell>
                                     </asp:TableRow>
                                    <asp:TableRow>
                                         
                                        <asp:TableCell>
                                                 <asp:GridView ID="gvHabilidad" runat="server" AutoGenerateColumns="False" ShowFooter="False"
                                            Width="100%" OnRowDataBound="gvHabilidad_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Operaciones" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%# Eval("IdHabilidadLinguistica") %>' OnClick="lnkDeleteHabilidad_Click">Eliminar</asp:LinkButton>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Idioma" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:DropDownList ID="ddlIdioma" runat="server">
                                                            </asp:DropDownList>
                                                            <asp:CompareValidator ID="cvIdioma" runat="server" ForeColor="Red" ControlToValidate="ddlIdioma"
                                                                ErrorMessage="Falta Idioma" Operator="NotEqual" Text="*" ValueToCompare="0" ValidationGroup="Grabar"></asp:CompareValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Lectura" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:DropDownList ID="ddlLectura" runat="server">
                                                            </asp:DropDownList>
                                                            <asp:CompareValidator ID="cvLectura" runat="server" ForeColor="Red" ControlToValidate="ddlLectura"
                                                                ErrorMessage="Falta Lectura" Operator="NotEqual" Text="*" ValueToCompare="0" ValidationGroup="Grabar"></asp:CompareValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Escritura" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:DropDownList ID="ddlEscritura" runat="server">
                                                            </asp:DropDownList>
                                                            <asp:CompareValidator ID="cvEscritura" runat="server" ForeColor="Red" ControlToValidate="ddlEscritura"
                                                                ErrorMessage="Falta Escritura" Operator="NotEqual" Text="*" ValueToCompare="0" ValidationGroup="Grabar"></asp:CompareValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Hablado" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:DropDownList ID="ddlHablado" runat="server">
                                                            </asp:DropDownList>
                                                            <asp:CompareValidator ID="cvHablado" runat="server" ForeColor="Red" ControlToValidate="ddlHablado"
                                                                ErrorMessage="Falta Hablado" Operator="NotEqual" Text="*" ValueToCompare="0" ValidationGroup="Grabar"></asp:CompareValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle BackColor="#4b6c9e" ForeColor="White" Font-Size="Small" />
                                        </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>

                                     <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                                <asp:Button ID="btnAddHabilidad" runat="server" Text="Añadir" CssClass="botton" OnClick="btnAddHabilidad_Click" />
                                        </asp:TableCell>
                                    </asp:TableRow>

                            

                                <asp:TableRow HorizontalAlign="Left" Font-Bold="true">
                                        <asp:TableCell BackColor="#4b6c9e" ForeColor="White">Experiencia:</asp:TableCell>
                                </asp:TableRow>
                              
                                <asp:TableRow>

                                        <asp:TableCell>
                                            <asp:GridView ID="gvExperiencia" runat="server" AutoGenerateColumns="False" ShowFooter="False" Width="100%" OnRowDataBound="gvExperiencia_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Operaciones" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%# Eval("IdExperiencia") %>' OnClick="lnkDeleteExperiencia_Click">Eliminar</asp:LinkButton>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Nombre de Empresa" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:TextBox ID="txtNombreEmpresa" runat="server" Text='<%# Eval("NombreEmpresa") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvNombreEmpresa" ForeColor="Red" runat="server" ControlToValidate="txtNombreEmpresa" ErrorMessage="Falta Nombre de Empresa" ValidationGroup="Grabar">*</asp:RequiredFieldValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Fecha Inicio" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:TextBox ID="txtFechaInicio" runat="server" Text='<%# Eval("FechaInicio") %>' Width="80px"></asp:TextBox>
                                                            <asp:CalendarExtender runat="server" ID="ceFechaInicio" TargetControlID="txtFechaInicio"></asp:CalendarExtender>
                                                            <asp:RequiredFieldValidator ID="rfvFechaInicio" ForeColor="Red" runat="server" ControlToValidate="txtFechaInicio" ErrorMessage="Falta Fecha de Inicio" ValidationGroup="Grabar">*</asp:RequiredFieldValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Fecha Final" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:TextBox ID="txtFechaFinal" runat="server" Text='<%# Eval("FechaFinal") %>' Width="80px"></asp:TextBox>
                                                            <asp:CalendarExtender runat="server" ID="ceFechaFin" TargetControlID="txtFechaFinal"></asp:CalendarExtender>
                                                            <asp:RequiredFieldValidator ID="rfvFechaFinal" ForeColor="Red" runat="server" ControlToValidate="txtFechaFinal" ErrorMessage="Falta Fecha de Fin" ValidationGroup="Grabar">*</asp:RequiredFieldValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Cargo" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:DropDownList ID="ddlCargo" runat="server">
                                                            </asp:DropDownList>
                                                            <asp:CompareValidator ID="cvCargo" runat="server" ForeColor="Red" ControlToValidate="ddlCargo" ErrorMessage="Falta Cargo"
                                                                Operator="NotEqual" Text="*" ValueToCompare="0" ValidationGroup="Grabar"></asp:CompareValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Responsabilidad" ItemStyle-HorizontalAlign="Center">
                                                    <EditItemTemplate>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <div>
                                                            <asp:TextBox ID="txtResponsabilidad" runat="server" Text='<%# Eval("Responsabilidad") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvResponsabilidad" ForeColor="Red" runat="server" ControlToValidate="txtResponsabilidad"
                                                                ErrorMessage="Falta Responsabilidad" ValidationGroup="Grabar">*</asp:RequiredFieldValidator>
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle BackColor="#4b6c9e" ForeColor="White" Font-Size="Small" />
                                        </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>

                                     <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Right">
                                                <asp:Button ID="btnAddExperiencia" runat="server" Text="Añadir" CssClass="botton" OnClick="btnAddExperiencia_Click"  />
                                        </asp:TableCell>
                                    </asp:TableRow>

                                    <asp:TableRow>
                                      <asp:TableCell HorizontalAlign="Right" Font-Bold="true" ColumnSpan="6">
                                        <asp:Button ID="btnGrabar" Height="40" Width="100" BackColor="White" runat="server"  Text="Grabar" OnClick="btnGrabar_Click" ValidationGroup="Grabar" />
                                      </asp:TableCell>
                                    </asp:TableRow>

                                    <asp:TableRow>
                                      <asp:TableCell HorizontalAlign="Left">
                                        <asp:ValidationSummary runat="server" ForeColor="Red" ID="ValidationSummary1" DisplayMode="List" BorderStyle="Dotted" ShowSummary="true"  ValidationGroup="Grabar"/>
                                      </asp:TableCell>
                                    </asp:TableRow>

                                </asp:Table>
                    </ContentTemplate>
                
                </asp:TabPanel>    
            </asp:TabContainer>

        
    
        </asp:TableCell>
      </asp:TableRow>

     <asp:TableRow>
        <asp:TableCell HorizontalAlign="Left">
            <asp:Label ID="lblErrror" ForeColor="Red" runat="server" Text=""></asp:Label>
        </asp:TableCell>
     </asp:TableRow>
                                          

    
    </asp:Table>


    </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
