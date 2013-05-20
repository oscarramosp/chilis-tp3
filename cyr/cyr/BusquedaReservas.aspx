<%@ Page Title="" Language="C#" MasterPageFile="~/Chilis.Master" AutoEventWireup="true" CodeBehind="BusquedaReservas.aspx.cs" Inherits="cyr.BusquedaReservas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <link href="css/fullcalendar.css" rel="stylesheet" />
    <script type="text/javascript" src="js/calendar-vista-dia.js"></script>
    <script type="text/javascript" src="js/fullcalendar.js"></script>
    <div class="divClubChilis">
        <div class="border-container">
            <div class="filter-row">
                <div class="filter-label" style="width: 60px;">
                    Fecha:
                </div>
                <div class="filter-data" style="width: 200px;">
                    <asp:TextBox ID="txtFechaBusqueda" runat="server" CssClass="classInput" />
                </div>
                <div class="filter-data" style="width: 50px;">
                    <input type="button" id="btnBuscar" value="Ir" class="button" />
                </div>
                <div class="filter-data" style="width: 80px;">
                    <asp:Button ID="btnNuevaReserva" runat="server" Text="Nueva Reserva (+)" 
                        CssClass="alt-button" onclick="btnNuevaReserva_Click" />
                </div>
                <div class="clear">
                </div>
            </div>
        </div>
        <div>
            <div id="tabs">
                <ul>
                    <li id="liTabDia"><a href="#tabDia">Vista del Día</a></li>
                    <li id="liTabMesa"><a href="#tabMesa">Vista por Mesa</a></li>
                </ul>
                <div id="tabDia">
                    <div id="calendarDia"></div>                 
                </div>
                <div id="tabMesa">
                    <div style="margin-bottom: 8px;">
                        Mesa:
                        <select id="ddlMesa" class="select">
                        </select>
                    </div>
                    <div id="calendarMesa"></div>                    
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
        // 0 = Vista del día; 1 = Vista por mesa.
        var mSelectedTab = 0;
        var mArrMesas = null;
        var mIsVistaMesaBuilt = false;
        
        $(document).ready(function() {

            $("#<%= txtFechaBusqueda.ClientID %>").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy"
            });

            $("#tabs").tabs();
            
            $("#liTabDia").click(function(){
                mSelectedTab = 0;
            });
            
            $("#liTabMesa").click(function(){
                
                mSelectedTab = 1;
                
                if (!mIsVistaMesaBuilt) {
                    cargarCalendarioMesa(new Date(), null);
                    mIsVistaMesaBuilt = true;
                }
                
            });
            
            // retrieve tables info, so we can load the calendar accordingly.
            <%= typeof(cyr.BusquedaReservas).FullName %>.obtenerMesas(function(rpta) {
                poblarDropDownMesas(rpta);
                buscarReservas(rpta);
                //cargarCalendarioMesa(new Date(), null);
            });
            
            $("#btnBuscar").click(function(){
                listarReservas();
            });
            
            $("#ddlMesa").change(function(){
                var codigoMesa = $(this).val();
                
                if (codigoMesa != '-1') {
                    listarReservas();
                }
            });
        });
        
        function poblarDropDownMesas(rpta) {
        
            if (rpta == null)
                return;

            var lstMesas = rpta.value;
            var ddlMesa = document.getElementById("ddlMesa");
            var i = 0;
            ddlMesa.options[i] = new Option("Seleccione", "-1");
            for (var m in lstMesas) {
                
                if (typeof lstMesas[m] == 'object') {
                    i++;
                    ddlMesa.options[i] = new Option(lstMesas[m].NumeroMesa, lstMesas[m].CodigoMesa);
                }
            }
        }
        
        function buscarReservas(rpta) {
            
            if (rpta == null)
                return;
                
            var lstMesas = rpta.value;
            mArrMesas = new Array();
      
            for (var m in lstMesas) {
            
                if (typeof lstMesas[m] == 'object') {
                    var mesa = {
                        id : lstMesas[m].CodigoMesa,
                        name : lstMesas[m].NumeroMesa
                    }
                    mArrMesas.push(mesa);
                }
            }
            
            // got the tables. Get the events.
            var fecha = $.trim($("#<%= txtFechaBusqueda.ClientID %>").val());
            <%= typeof(cyr.BusquedaReservas).FullName %>.obtenerReservas(fecha, '0', function(rpta) {
            
                var fecha = new Date(); // todas las reservas obtenidas son del día. so...
                cargarCalendarioDia(fecha, rpta);
            });
        }
        
        function cargarCalendarioDia(fecha, rpta) {
            
            // Prepare the calendar.
            // Vista del día
            var d = fecha.getDate();
            var m = fecha.getMonth();
            var y = fecha.getFullYear();
            
            var lstReservas = rpta.value;
            var arrReservas = new Array();
      
            for (var r in lstReservas) {
            
                if (typeof lstReservas[r] == 'object') {
                    
                    var horaInicio = lstReservas[r].HoraInicio; //format HH:MM, split it
                    var horaFin = lstReservas[r].HoraFin;
                    
                    var hI = horaInicio.substring(0, 2);
                    var mI = horaInicio.substring(3);
                    var hF = horaFin.substring(0, 2);
                    var mF = horaFin.substring(3);
                    
                    var nombreCliente = lstReservas[r].Cliente.TipoCliente == 'N' ? lstReservas[r].Cliente.Nombres + ' ' +
                                            lstReservas[r].Cliente.ApellidoPaterno + ' ' + lstReservas[r].Cliente.ApellidoMaterno :
                                            lstReservas[r].Cliente.RazonSocial;

                    var reserva = {
                        id: lstReservas[r].CodigoReserva,
				        title: nombreCliente,
				        start: new Date(y, m, d, hI, mI),
				        end: new Date(y, m, d, hF, mF),
				        allDay: false,
				        tableId: lstReservas[r].Mesa.CodigoMesa,
				        url : 'RegistroReserva.aspx?m=edit&id=' + lstReservas[r].CodigoReserva
                    }
                    arrReservas.push(reserva);
                }
            }

            $('#calendarDia').fullCalendarDia('destroy');

            var calendar = $('#calendarDia').fullCalendarDia({
                header: {
                    left: 'prev,next',
                    center: '',
                    right: ''
                },
                defaultView: 'agendaWeek',
                selectable: false,
                allDaySlot: false,
                selectHelper: true,
                /*
                select: function(start, end, allDay) {
                    var title = prompt('Event Title:');
                    if (title) {
                        calendar.fullCalendarDia('renderEvent',
						{
						    title: title,
						    start: start,
						    end: end,
						    allDay: allDay
						},
						true // make the event "stick"
					);
                    }
                    calendar.fullCalendarDia('unselect');
                },
                */
                editable: false,
                events: arrReservas,
                tables: mArrMesas
            });
        }
        
        function myOwnNext() {
            var fecha = $.trim($("#<%= txtFechaBusqueda.ClientID %>").val());
            var y = fecha.substring(6);
            var m = parseInt(fecha.substring(3,5)) - 1;
            var d = fecha.substring(0,2);
            var dFechaActual = new Date(y, m, d, 0 ,0);
            dFechaActual.setDate(dFechaActual.getDate() + 1);
            
            d = dFechaActual.getDate();
            m = dFechaActual.getMonth() + 1;
            y = dFechaActual.getFullYear();
            
            var nuevaFecha = right("0" + d, 2) + '/' + right("0" + m, 2) + '/' + y;
            
            $("#<%= txtFechaBusqueda.ClientID %>").val(nuevaFecha);
            listarReservas();
        }
        
        function myOwnPrev() {
        
            var fecha = $.trim($("#<%= txtFechaBusqueda.ClientID %>").val());
            var y = fecha.substring(6);
            var m = parseInt(fecha.substring(3,5)) - 1;
            var d = fecha.substring(0,2);
            var dFechaActual = new Date(y, m, d, 0 ,0);
            dFechaActual.setDate(dFechaActual.getDate() - 1);
            
            d = dFechaActual.getDate();
            m = dFechaActual.getMonth() + 1;
            y = dFechaActual.getFullYear();
            
            var nuevaFecha = right("0" + d, 2) + '/' + right("0" + m, 2) + '/' + y;
            
            $("#<%= txtFechaBusqueda.ClientID %>").val(nuevaFecha);
            
            listarReservas();
        }
        
        function listarReservas() {
            
            var fecha = $.trim($("#<%= txtFechaBusqueda.ClientID %>").val());
            var idMesa = 0;
            
            if (!esFechaValida(fecha)) {
                mensaje = '<ul><li>Ingrese una fecha válida (dd/mm/yyyy)</li></ul>';
                jcAlert('Fecha inválida', mensaje, function(choice) { return choice });
                return false;
            }
            
            if (mSelectedTab == '1')
                idMesa = $("#ddlMesa").val();
            
            var y = fecha.substring(6);
            var m = parseInt(fecha.substring(3,5)) - 1;
            var d = fecha.substring(0,2);
            var fechaBuscar = new Date(y, m, d, 0 ,0);
            
            <%= typeof(cyr.BusquedaReservas).FullName %>.obtenerReservas(fecha, idMesa.toString(), function(rpta) {
                if (mSelectedTab == '0')
                    cargarCalendarioDia(fechaBuscar, rpta);
                else 
                    cargarCalendarioMesa(fechaBuscar, rpta);
            });
        }
        
        function cargarCalendarioMesa(fecha, rpta) {
        
		    var d = fecha.getDate();
		    var m = fecha.getMonth();
		    var y = fecha.getFullYear();
    	
    		var lstReservas = rpta != null ? rpta.value : null;
            var arrReservas = new Array();
      
            for (var r in lstReservas) {
            
                if (typeof lstReservas[r] == 'object') {
                    
                    var horaInicio = lstReservas[r].HoraInicio; //format HH:MM, split it
                    var horaFin = lstReservas[r].HoraFin;
                    
                    var hI = horaInicio.substring(0, 2);
                    var mI = horaInicio.substring(3);
                    var hF = horaFin.substring(0, 2);
                    var mF = horaFin.substring(3);
                    
                    var nombreCliente = lstReservas[r].Cliente.TipoCliente == 'N' ? lstReservas[r].Cliente.Nombres + ' ' +
                                            lstReservas[r].Cliente.ApellidoPaterno + ' ' + lstReservas[r].Cliente.ApellidoMaterno :
                                            lstReservas[r].Cliente.RazonSocial;

                    var reserva = {
                        id: lstReservas[r].CodigoReserva,
				        title: nombreCliente,
				        start: new Date(y, m, d, hI, mI),
				        end: new Date(y, m, d, hF, mF),
				        allDay: false,
				        tableId: lstReservas[r].Mesa.CodigoMesa,
				        url : 'RegistroReserva.aspx?m=edit&id=' + lstReservas[r].CodigoReserva
                    }
                    arrReservas.push(reserva);
                }
            }
    		
    		$('#calendarMesa').fullCalendar('destroy');
    		
		    var calendar = $('#calendarMesa').fullCalendar({
			    header: {
				    left: 'prev,next',
				    center: '',
				    right: ''
			    },
			    year: y,
			    month: m,
			    date: d,
			    defaultView: 'agendaDay',
			    selectable: false,
			    allDaySlot : false,
			    selectHelper: true,
			    /*
			    select: function(start, end, allDay) {
				    var title = prompt('Event Title:');
				    if (title) {
					    calendar.fullCalendar('renderEvent',
						    {
							    title: title,
							    start: start,
							    end: end,
							    allDay: allDay
						    },
						    true // make the event "stick"
					    );
				    }
				    calendar.fullCalendar('unselect');
			    },
			    */
			    editable: false,
			    events: arrReservas
		    });
        }
              
        AjaxPro.onLoading = function(show) {
            
            if (show) {
                $("BODY").append('<div id="divMensajeProcesando" class="divMensajeProcesando"></div>');
                $("#divMensajeProcesando").html("Cargando...");
                $("#divMensajeProcesando").css({
                    width: '150',
                    height: '25',
                    top: 0,
                    left: parseInt($(window).width() / 2 - 150 / 2)
                });
            } else {
                $("#divMensajeProcesando").remove();
            }
            
        }

    </script>

</asp:Content>