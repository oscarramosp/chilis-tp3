<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AsignarMesa.aspx.cs" Inherits="SICR.Web.AsignarMesa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.divMesa').click(function () {
                $('.divMesa').css('border', '0px solid blue');
                $(this).css('border', '5px solid blue');
                $('#tbFormulario').css('display', 'block');
                $('input', '#mesaActual').val($('input', this).val());
            });


        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Asignación de Mesa</h2>
    <div style=" margin: 20px 0 20px 0">
        Zona:
        <asp:DropDownList ID="ddlZona" runat="server" OnSelectedIndexChanged="ddlZona_SelectedIndexChanged"
            AutoPostBack="True">
        </asp:DropDownList>
    </div>
    <div id="divMesas" style=" border:1px solid">
        <asp:ListView ID="lvMesas" runat="server">
            <ItemTemplate>
                <div style="display: inline-block; width: 100px; height: 100px; border: 0px solid;">
                    <div style="display: block; width: 50px; height: 50px; border: 0px solid; margin: 25px;
                        text-align: center; vertical-align: middle">
                        <asp:Panel ID="pnlMesa" runat="server" BackColor="Red" ForeColor="White" Width="100%"
                            Height="100%" OnDataBinding="pnlMesa_DataBinding">
                            <asp:Literal ID="lrtMesa" runat="server" Text='<%# Eval("MesNombre") %>'></asp:Literal>
                            <asp:HiddenField ID="hfCodMesa" runat="server" Value='<%# Eval("MesCodigo") %>' />
                        </asp:Panel>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
    <asp:ValidationSummary ID="vsFormulario" runat="server" CssClass="failureNotification"
        ValidationGroup="vgRegistrarAsignacion" />
    <table id="tbFormulario" style="display: none" >
        <tr>
            <td>
                Nombre del cliente
            </td>
            <td>
                <asp:TextBox ID="txtCliente" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtCliente"
                    CssClass="failureNotification" ErrorMessage="Ingrese el nombre del cliente."
                    ToolTip="Ingrese el nombre del cliente." ValidationGroup="vgRegistrarAsignacion">*</asp:RequiredFieldValidator>
            </td>
            <td>
                Código Anfitrión
            </td>
            <td>
                <asp:TextBox ID="txtAnfitrion" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAnfitrion"
                    CssClass="failureNotification" ErrorMessage="Ingrese el código del anfitrión."
                    ToolTip="Ingrese el código del anfitrión." ValidationGroup="vgRegistrarAsignacion">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Cantidad de personas
            </td>
            <td>
                <asp:TextBox ID="txtCantidad" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCantidad"
                    CssClass="failureNotification" ErrorMessage="Ingrese la cantidad de personas."
                    ToolTip="Ingrese la cantidad de personas." ValidationGroup="vgRegistrarAsignacion">*</asp:RequiredFieldValidator>
                <asp:RangeValidator ID="rvCantidad" runat="server" ControlToValidate="txtCantidad"
                    ErrorMessage="El valor ingresado en cantidad no es correcto." ToolTip="El valor ingresado en cantidad no es correcto."
                    MaximumValue="100" MinimumValue="1" Type="Integer" ValidationGroup="vgRegistrarAsignacion">*</asp:RangeValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
            <td align="right">
                <div id="mesaActual">
                    <asp:HiddenField ID="hfCodMesaActual" runat="server" />
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click"
                    ValidationGroup="vgRegistrarAsignacion" />
            </td>
        </tr>
    </table>
</asp:Content>
