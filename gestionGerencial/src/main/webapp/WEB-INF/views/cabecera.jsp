<body>

<!-- container
==========================================================================================  -->
<div id="container">
<!-- header- row 1
==========================================================================================  -->
<header>
		<div class="row">
			<div class="column grid_7"><div id="logo"><img src="resources/images/logo.jpg" alt=""></div></div>
			<div class="column grid_5"><p>Usuario: <c:out value="${usuario.nombre}" /> <c:out value="${usuario.apellido}" /></p>
			<p>Ingreso:</p></div>
		</div>
</header>
<!-- nav-main - row 2
==========================================================================================  -->	
	<nav>
		<div class="row">
			<div class="column grid_12">				
				<div id="menu">
					<ul id="nav">
					<li><a href="#">Calidad</a></li>
					<li><a href="#">Franquicias</a></li>
					<li><a class="active" href="#">Gestion Gerencial</a>
						<ul>							
							<li><a href="<c:url value="/consultaObjetivos.htm"/>">Gestionar Objetivos Estrategicos</a></li>
							<li><a href="#">Gestionar Mapas Estrategicos</a></li>
							<li><a href="#">Gestionar Estrategias</a></li>
							<li><a href="#">Gestionar Indicadores</a></li>
							<li><a href="#">Gestionar Planes de Accion</a></li>
							<li><a href="<c:url value="/consultaAprobaciones.htm"/>">Gestionar Aprobaciones</a></li>
						</ul>
					</li>	
					<li><a href="#">Adquisiciones</a></li>
					<li><a href="#">Eventos</a></li>
					</ul>
				</div>			
			</div>
		</div>
	</nav>
	<!-- wrap - row 4 
==========================================================================================  -->
<br>
<br>
<br>
<br>
<div id="wrap">
	<div class="row">
		<div class="column grid_12">
			<h4>GESTION GERENCIAL</h4>				
			<!-- Para que muestre la fecha -->  
			<p>Fecha: 
			<script language="JavaScript" type="text/javascript">  
			MostrarFecha();  
			</script>  
			</p>

<%-- <c:if test="${mensajeConfirmacion == 'Baja'}"> --%>
<!-- 	<script language="javascript"> -->
<!-- 		window.onload = alert("Objetivo dado de baja");-->
<!-- 	</script> -->
<%--  </c:if>  --%>

