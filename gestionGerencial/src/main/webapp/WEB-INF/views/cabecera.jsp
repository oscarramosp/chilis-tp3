<body background="resources/images/fondo-chilis.png"> 
<div class="row">
	<div class="column grid_7"><div id="logo"><img src="resources/images/logo.jpg" alt=""></div></div>
	<div class="column grid_5"><p>Usuario: <c:out value="${usuario.nombre}" /> <c:out value="${usuario.apellido}" /></p>
	<!--<p>Ingreso:</p>-->
	<!-- Para que muestre la fecha -->
	<p>Fecha: 
	<script language="JavaScript" type="text/javascript">  
		MostrarFecha();  
	</script></p></div>
</div>
	<nav>
		<div class="row">
			<div class="column grid_12">				
				<div id="menu">
					<ul id="nav">
					<li><a href="#">Almacen</a></li>
					<li><a href="#">Clientes</a></li>
					<li><a class="active" href="#">Gestion Gerencial</a>
						<ul>							
							<li><a href="<c:url value="/consultaObjetivos.htm"/>">Gestionar Objetivos Estrategicos</a></li>
							<li><a href="#">Gestionar Mapas</a></li>
							<li><a href="#">Gestionar Estrategias</a></li>
							<li><a href="#">Gestionar Indicadores</a></li>
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
	</nav>	
<c:if test="${mensajeConfirmacion == 'Baja'}">
	<script language="javascript">
 		window.onload = alert("Objetivo pendiente de baja");
 		self.location = "consultaObjetivos.htm";
 	</script> 
 </c:if> 
 <c:if test="${mensajeConfirmacion == 'Actualizacion'}">
	<script language="javascript">
 		window.onload = alert("Objetivo pendiente de actualizacion");
 		self.location = "consultaObjetivos.htm";
 	</script> 
</c:if> 
<c:if test="${mensajeConfirmacion == 'Registro'}">
	<script language="javascript">
 		window.onload = alert("Objetivo pendiente de registro");
 		self.location = "consultaObjetivos.htm";
 	</script> 
</c:if> 