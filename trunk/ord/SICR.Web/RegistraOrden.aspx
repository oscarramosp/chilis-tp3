<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="RegistraOrden.aspx.cs" Inherits="SICR.Web.RegistraOrden" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
    <link href="Styles/redmond/jquery-ui-1.8.2.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var tikect = 0;
        var sillaActual = -1;
        var pedidoActual = -1;
        var AsignacionActual = -1;
        var PlaCodigo = -1
        var PlaNombre = '';
        var Modificar = false;
        $(document).ready(function () {

            $('.ddlMesa').change(function () {

                MostrarSillas();
            });



            $('#divEspecialidades li').click(function () {
                $('#divEspecialidades li').css('background-color', 'White');
                $('#divEspecialidades li').css('color', '');
                var EspCodigo = $('span', this).html();
                $(this).css('background-color', 'Blue');
                $(this).css('color', 'White');

                MostrarPlatos(EspCodigo);
            });

            $('#divPlatos li').live('click', function () {
                $('#divPlatos li').css('background-color', 'White');
                $('#divPlatos li').css('color', '');
                PlaCodigo = $('span', this).html();
                PlaNombre = $(this).html();
                $(this).css('background-color', 'Blue');
                $(this).css('color', 'White');
                AgregarPedido();

            });

            $('.sillas input').live('click', function () {
                $('.carta').css('display', 'block');
                $('#divPedido').css('display', 'block');
                $('#divOpciones').css('display', 'block');
                sillaActual = $('span', $(this).parent()).html();
                $('#divPedido ul').css('display', 'none');
                $('#divPedido ul.silla' + sillaActual).css('display', 'block');
                pedidoActual = -1;
            });

            $('#divPedido li').live('click', function () {
                $('#divPedido li').css('background-color', 'White');
                $('#divPedido li').css('color', '');
                pedidoActual = $('span', this).html();
                $(this).css('background-color', 'Blue');
                $(this).css('color', 'White');


            });

            $('.btnEliminar').click(function () {

                if (pedidoActual != -1) {
                    $('.silla' + sillaActual + ' .pedido' + pedidoActual).remove();
                    alert('Pedido eliminado.');
                } else {
                    alert('Debe seleccionar un pedido.');
                }
                return false;
            });
            $('.btnModificar').click(function () {
                Modificar = true;
                if (pedidoActual != -1) {
                    $("#divCantidad").dialog('open');

                } else {
                    alert('Debe seleccionar un pedido.');
                }
                return false;
            });

            $('.btnGuardar').click(function () {
                if (AsignacionActual != -1) {
                    var l = new Array();
                    $('#divPedido li').each(function (index, element) {
                        var pedido = {
                            OrdCodigo: AsignacionActual,
                            SilCodigo: $('input', $(element).parent()).val(),
                            PlaCodigo: $('span', element).html(),
                            PedCantidad: $('.cantidad', element).html()
                        };

                        l.push(pedido);
                    });

                    var data = Sys.Serialization.JavaScriptSerializer.serialize(l);
                    $.ajax({
                        type: "POST",
                        url: "Servicios/RegistraOrden.ashx",
                        data: { consulta: "3", pedido: data },
                        complete: function () {
                            alert('Se ha guardado el pedido');
                        }
                    })
                } else {
                    alert('Debe selecionar una mesa y ingrsar los pedidos');
                }
                return false;
            });

            $("#divCantidad").dialog({
                autoOpen: false,
                modal: true,
                buttons: {
                    "Aceptar": function () {

                        var cantidad = new Number($('.txtCantidad').val());

                        if (isNaN(cantidad)) {
                            alert('Ingrese un valor correcto');
                        } if (cantidad < 1) {
                            alert('Ingrese una cantidad mayor a cero');
                        }
                        else {
                            if (Modificar) {
                                $('.cantidad', '.silla' + sillaActual + ' .pedido' + pedidoActual).html(''+cantidad);
                                $(this).dialog("close");
                                alert('Pedido modificado.');
                            } else {

                                $('#divPedido ul.silla' + sillaActual).append('<li class="pedido' + PlaCodigo + '"><label class="cantidad">' + cantidad + '</label> de ' + PlaNombre + '</li>');

                                $(this).dialog("close");
                            }

                            $('.txtCantidad').val('');
                        }
                    }
                }

            });


        })

        function AgregarPedido() {
            Modificar = false;
            $("#divCantidad").dialog('open');
            
        }
        function MostrarPlatos(EspCodigo) {
            tikect = (new Date).getTime();
            $('#divPlatos').html('Cargando ...');
            $.getJSON('Servicios/RegistraOrden.ashx?tikect=' + tikect + '&consulta=2&EspCodigo=' + EspCodigo, function (data) {

                if (data.length == 0) {
                    $('#divPlatos').html('No se registraron platos y/o bebidas en esta especialidad');
                } else {
                    var platos = '<h3>Platos y Bebidas</h3><ul>';
                    for (i = 0; i < data.length; i++) {
                        platos = platos + '<li><span>' + data[i].Codigo + '</span>' + data[i].Nombre + '</li>';
                    }

                    platos = platos + '</ul>';
                    $('#divPlatos').html(platos);

                }
            });

        }
        function MostrarSillas() {
            if ($('.dllMesa').val() != '') {
                tikect = (new Date).getTime();
                $('#divSillas').html('Cargando ...');
                $.getJSON('Servicios/RegistraOrden.ashx?tiket=' + tikect + '&consulta=1&MesCodigo=' + $('.ddlMesa').val(), function (data) {
                    $('#divSillas').html('');

                    $('.txtServer').val(data.Nombre);
                    AsignacionActual = data.Codigo;
                    if (data.Items.length > 0) {
                        var lista = '<ul class="sillas">';
                        var pedido = '<h3>Pedidos</h3>';
                        for (i = 0; i < data.Items.length; i++) {

                            lista = lista + '<li><span>' + data.Items[i].Codigo + '</span><input type="radio"  name="sillas" /> ' + data.Items[i].Nombre + '</li>';
                            pedido = pedido + '<ul class="silla' + data.Items[i].Codigo + '" style="display:none"><input type="hidden" value="' + data.Items[i].Codigo + '" /></ul>';
                        }
                        lista = lista + '</ul>';
                        $('#divSillas').html(lista);
                        $('#divPedido').html(pedido);
                    } else {
                        $('#divSillas').html('la mesa seleccionada no tiene sillas registradas.')
                    }

                });
            } else {
                alert('Selecione una mesa');
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h2>
        Registrar Orden
    </h2>
    <div style="margin: 20px 0 20px 0">
        <table>
            <tr>
                <td>
                    Nro de Mesa
                </td>
                <td>
                    <asp:DropDownList ID="ddlMesa" runat="server" CssClass="ddlMesa">
                    </asp:DropDownList>
                </td>
                <td>
                    Nro de Server
                </td>
                <td>
                    <asp:TextBox ID="txtServer" CssClass="txtServer" runat="server" ReadOnly="true" Width="100px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" valign="top">
                    <div id="divSillas" style="height: 140px; width: 200px; overflow: auto;">
                    </div>
                </td>
                <td colspan="2" valign="top">
                    <div id="divPedido" style="display: none; height: 140px; overflow: auto; width: 400px">
                    </div>
                </td>
                <td>
                    <div id="divOpciones" style="display: none">
                        <asp:Button ID="btnModficar" runat="server" CssClass="btnModificar" Text="Modficar" /><br />
                        <asp:Button ID="btnEliminar" runat="server" CssClass="btnEliminar" Text="Eliminar" />
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2">
                    <div id="divEspecialidades" class="carta" style="display: none; height: 140px; width: 200px;
                        overflow: auto;">
                        <h3>
                            Especialidades</h3>
                        <ul>
                            <asp:Repeater ID="rptEspecialidad" runat="server">
                                <ItemTemplate>
                                    <li><span>
                                        <%# Eval("EspCodigo") %></span><%# Eval("EspNombre") %></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </td>
                <td valign="top" colspan="2">
                    <div id="divPlatos" class="carta" style="display: none; height: 140px; overflow: auto;
                        width: 400px">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="right">
                    <asp:Button ID="btnGuardar" CssClass="btnGuardar" runat="server" Text="Guardar" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divCantidad" title="Cantidad">
        Ingrese la cantidad
        <asp:TextBox ID="txtCanidad" runat="server" CssClass="txtCantidad"></asp:TextBox>
    </div>
</asp:Content>
