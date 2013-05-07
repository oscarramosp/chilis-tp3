<%@ Page Title="Nota de Pedido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmConsultaNotaIO.aspx.cs" Inherits="AppAlmacen.Interfaces.Registros.frmConsultaNotaIO" %>
<%@ Register Src="~/Controles/ucwNuevoEditarEliminar.ascx" TagName="ucwNuevoEditarEliminar"
    TagPrefix="uc1" %>
    <%@ Register Src="~/Controles/ucwBuscarLimpiar.ascx" TagName="ucwBuscarLimpiar"
    TagPrefix="uc3" %>
    <%@ Register Src="~/Controles/ucwTituloBandeja.ascx" TagName="ucwTituloBandeja"
    TagPrefix="uc2" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="uppData" runat="server">
        <ContentTemplate>
   
    <div>

      <table cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td style="height: 14px; width: 100%">
                                        <div class="EstiloTitulo">
                                            <div class="EstiloTituloBandeja" style="width: 100%">
                                                <uc2:ucwTituloBandeja ID="ucwTituloBandeja" runat="server" />
                                            </div>
                                            <div class="ContenedorBotones">
                                                
                                              
   
    <uc3:ucwbuscarlimpiar ID="ucwBuscarLimpiar" runat="server"  VisibleExportar="false"  Visible="true" />

                             </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>

  <div style="text-align: right">
                </div>
<div class="cajaFormulario">
                 <br />
            <table class="TablaRegistros">
           <tr>
           <td>
           Tipo de Operación
           </td>
           <td>
           <asp:DropDownList ID="ddlTipoOperacion" runat="server" 
                 AutoPostBack="true" 
                   onselectedindexchanged="ddlTipoOperacion_SelectedIndexChanged">
                   <asp:ListItem Value="0">--Seleccione--</asp:ListItem>
               
               <asp:ListItem Value="NI">Nota Ingreso</asp:ListItem>
               <asp:ListItem Value="NS">Nota Salida</asp:ListItem>
               </asp:DropDownList>
           
           </td>
           </tr>
            
            <tr id="trNumPedido" runat="server" visible="false" >
                <td>
                    Número de Pedido:</td>
                <td>
                
                <asp:TextBox ID="txtCodNumPedido" runat="server"></asp:TextBox>
                    </td>
               
            </tr>
          
        </table>

   

        </div>
      <div style="text-align: right">
                </div>

     <div class="container" id="divGrillaNotaPedido" runat="server" visible="true">

                      <asp:GridView ID="gdvListado" runat="server" AutoGenerateColumns="False" DataKeyNames="CodigoIS">
                    <Columns>
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditRow" runat="server" CommandName="Edit" 
                                    ImageUrl="~/Imagenes/Iconos/ico_editadetalleregistro.png" ToolTip="Modificar" />
                                    <asp:Label visible="false" ID="lblCodEdit" runat="server" Text='<%# Bind("CodigoIS") %>' />
                                   
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="Código">
                       <ItemTemplate>
                                 <asp:Label ID="lblcod" runat="server" Text='<%# Bind("CodigoIS") %>' Visible="false"/>
                                 <asp:Label ID="lblCod2" runat="server" Text='<%# Bind("correlativo") %>' Visible="true"/>                                
                                </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tipo Documento">
                        <ItemTemplate>
                         <asp:Label ID="lblTipDoc" runat="server" Text='<%# Bind("tipoDocumento") %>' Visible="false"/>
                         <asp:Label ID="lblTipDocDes" runat="server" Text='<%# Bind("DestipoDocumento") %>' />
                         </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Fecha">
                        <ItemTemplate>
                         <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("fecha") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Periodo">
                        <ItemTemplate>
                         <asp:Label ID="lblPeriodo" runat="server" Text='<%# Bind("periodo") %>' />
                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Center" />                        
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Transferencia">
                        <ItemTemplate>
                         <asp:Label ID="lblTransCod" runat="server" Text='<%# Bind("transTipo") %>' Visible="false"/>
                         <asp:Label ID="lblTransDes" runat="server" Text='<%# Bind("DestransTipo") %>' />

                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Referencia">
                         <ItemTemplate>
                         <asp:Label ID="lblrefCod" runat="server" Text='<%# Bind("referTipo") %>' Visible="false"/>
                         <asp:Label ID="lblrefDes" runat="server" Text='<%# Bind("DesreferTipo") %>' />

                          </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Ref. Num Doc">
                        <ItemTemplate>
                         <asp:Label ID="lblrefnumDoc" runat="server" Text='<%# Bind("referNumDoc") %>' />
                        </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="U. Origen">
                        <ItemTemplate>
                           <asp:Label ID="lblUOriCod" runat="server" Text='<%# Bind("CodunidOrigen") %>' Visible="false"/>
                         <asp:Label ID="lblUOriDes" runat="server" Text='<%# Bind("unidOrigen") %>' />
                      </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Center" />
                        
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="U. Destino">
                         <ItemTemplate>
                           <asp:Label ID="lblUDestCod" runat="server" Text='<%# Bind("CodunidDestino") %>' Visible="false"/>
                           <asp:Label ID="lblEmpleado" runat="server" Text='<%# Bind("empleado") %>' Visible="false"/>
                           <asp:Label ID="lblCodPedido" runat="server" Text='<%# Bind("CodPedido") %>' Visible="false"/>
                           <asp:Label ID="lblCodPedido2" runat="server" Text='<%# Bind("CodPedido2") %>' Visible="false"/>
                         
                         <asp:Label ID="lblUDestDes" runat="server" Text='<%# Bind("unidDestino") %>' />

                      </ItemTemplate>
                          <HeaderStyle HorizontalAlign="Center" />
                        
                        </asp:TemplateField>
                      
                    </Columns>
                </asp:GridView>

                    </div>

                    <div style="text-align: right">
                </div>


            

    </div>
 
    </ContentTemplate>
    </asp:UpdatePanel>

   

</asp:Content>
