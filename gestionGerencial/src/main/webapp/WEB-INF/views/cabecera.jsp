<header>
		<div class="row">
			<div class="column grid_7"><div id="logo"><img src="resources/images/logo.jpg" alt=""></div></div>
			<div class="column grid_5"><h5>Usuario:</h5> <c:out value="${usuario.nombre}" /> <c:out value="${usuario.apellido}" />
			<h5>Ingreso:</h5>
			<!-- Para que muestre la fecha -->
			<h8>Fecha:</h8>
			<script language="JavaScript" type="text/javascript">  
			MostrarFecha();
			</script></div>
		</div>
</header>

<body>

	<div class="row">
			<div class="column grid_12">				
				<div id="menu">
					<ul class="nav">
					<li><a href="#">Almacen</a></li>
					<li><a href="#">Clientes</a></li>
					<li><a class="active" href="#">Gestion Gerencial</a>
						<ul>							
							<li><a href="<c:url value="/consultaObjetivos.htm"/>">Gestionar Objetivos Estrategicos</a></li>
							<li><a href="#">Gestionar Mapas</a></li>
							<li><a href="<c:url value="/consultaEstrategias.htm"/>">Gestionar Estrategias</a></li>
							<li><a href="<c:url value="/consultaIndicadores.htm"/>">Gestionar Indicadores</a></li>
							<li><a href="#">Gestionar Planes de Accion</a></li>
							<li><a href="<c:url value="/aprobaciones.htm"/>">Aprobaciones</a></li>
						</ul>
					</li>	
					<li><a href="#">Ordenes</a></li>
					<li><a href="#">Trabajadores</a></li>
					</ul>
				</div>			
			</div>
		</div>
<c:if test="${mensajeConfirmacion == 'PendBaja'}">
	<script language="javascript">
 		window.onload = alert("Objetivo pendiente de baja");
 		self.location = "consultaObjetivos.htm";
 	</script> 
 </c:if> 
 <c:if test="${mensajeConfirmacion == 'PendActualizacion'}">
	<script language="javascript">
 		window.onload = alert("Objetivo pendiente de actualizacion");
 		self.location = "consultaObjetivos.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'PendRegistro'}">
	<script language="javascript">
 		window.onload = alert("Objetivo pendiente de registro");
 		self.location = "consultaObjetivos.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'Baja'}">
	<script language="javascript">
 		window.onload = alert("Elemento Dado de Baja");
 		self.location = "aprobacionObjetivos.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'Registrado'}">
	<script language="javascript">
 		window.onload = alert("Cambios Registrados");
 		self.location = "aprobacionObjetivos.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'Rechazado'}">
	<script language="javascript">
 		window.onload = alert("Cambios rechazados");
 		self.location = "aprobacionObjetivos.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'Restaurado'}">
	<script language="javascript">
 		window.onload = alert("Operación de Baja Rechazada. El elemento ha sido restaurado como Registrado");
 		self.location = "aprobacionObjetivos.htm";
 	</script> 
</c:if>
<c:if test="${mensajeConfirmacion == 'PendBajaEstrategia'}">
	<script language="javascript">
 		window.onload = alert("Estrategia pendiente de baja");
 		self.location = "consultaEstrategias.htm";
 	</script> 
 </c:if> 
 <c:if test="${mensajeConfirmacion == 'PendActualizacionEstrategia'}">
	<script language="javascript">
 		window.onload = alert("Estrategia pendiente de actualizacion");
 		self.location = "consultaEstrategias.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'PendRegistroEstrategia'}">
	<script language="javascript">
 		window.onload = alert("Estrategia pendiente de registro");
 		self.location = "consultaEstrategias.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'BajaEstrategia'}">
	<script language="javascript">
 		window.onload = alert("Estrategia Dada de Baja");
 		self.location = "aprobacionEstrategias.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'RegistradoEstrategia'}">
	<script language="javascript">
 		window.onload = alert("Cambios Registrados");
 		self.location = "aprobacionEstrategias.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'RechazadoEstrategia'}">
	<script language="javascript">
 		window.onload = alert("Cambios rechazados");
 		self.location = "aprobacionEstrategias.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'RestauradoEstrategia'}">
	<script language="javascript">
 		window.onload = alert("Operación de Baja Rechazada. El elemento ha sido restaurado como Registrado");
 		self.location = "aprobacionEstrategias.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'PendBajaIndicador'}">
	<script language="javascript">
 		window.onload = alert("Indicador pendiente de baja");
 		self.location = "consultaIndicadores.htm";
 	</script> 
 </c:if> 
 <c:if test="${mensajeConfirmacion == 'PendActualizacionIndicador'}">
	<script language="javascript">
 		window.onload = alert("Indicador pendiente de actualizacion");
 		self.location = "consultaIndicadores.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'PendRegistroIndicador'}">
	<script language="javascript">
 		window.onload = alert("Indicador pendiente de registro");
 		self.location = "consultaIndicadores.htm";
 	</script> 
</c:if> 