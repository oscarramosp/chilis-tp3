<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<script>
	function setCheckedValue(tipoElemento, Todos) {
		if (!tipoElemento)
			return;
		var radioLength = radioObj.length;
		if (radioLength == undefined) {
			radioObj.checked = (radioObj.value == newValue.toString());
			return;
		}
		for ( var i = 0; i < radioLength; i++) {
			tipoOperacion[i].checked = false;
			if (tipoOperacion[i].value == Todos.toString()) {
				tipoOperacion[i].checked = true;
			}
		}
	}
</script>
<br>
<br>
<div class="row">
	<div class="column grid_12">
		<h4>Pendientes de Aprobación</h4>
		<form:form commandName="formUtil" method="POST">
			<h6>
				Area:
				<c:out value="${usuario.area.nombre}" />
			</h6>
			<br>
			<h5>Filtrar por Estado</h5>
			<br>
			<form:radiobutton path="tipoOperacion" value="Todos" id="Todos"
				checked="checked" />Ver todos <br>
			<form:radiobutton path="tipoOperacion" value="PendientesRegistro"
				id="PendientesRegistro" />Pendientes de Registro <br>
			<form:radiobutton path="tipoOperacion"
				value="PendientesActualizacion" id="PendientesActualizacion" />Pendientes de Actualización <br>
			<form:radiobutton path="tipoOperacion" value="PendientesBaja"
				id="PendientesBaja" />Pendientes de Baja <br>
			<br>
			<form:errors path="codigo" />
			<br>
			<input type="submit" name="action" value="Buscar" />
			
			<c:if test="${not empty estrategias }">
				<br>
				<br>
				<table class="zebra">
					<thead>
						<tr>
							<th>NOMBRE</th>
							<th>TIPO DE OPERACION</th>
							<th>OBJETIVO VINCULADO</th>
							<th>FECHA INICIO</th>
							<th>FECHA FIN</th>
							<th>RESPONSABLE</th>
							<th>VER</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="estrategia" items="${estrategias}">
							<tr>
								<td><c:out value="${estrategia.nombre}" /></td>
								<td><c:out value="${estrategia.estado}" /></td>
								<td><c:out value="${estrategia.objetivoEstrategia.descripcion}" /></td>
								<td><fmt:formatDate value="${estrategia.fechaInicio}" pattern="dd/MM/yyyy" /></td>
								<td><fmt:formatDate value="${estrategia.fechaFin}" pattern="dd/MM/yyyy" /></td>
								<td><c:out value="${estrategia.responsableEstrategia.nombre} ${estrategia.responsableEstrategia.apellido}" /></td>
								<td><a
									href="visualizarElementoEstrategia.htm?codigo=${estrategia.codigo}">
										Ver</a>
								<td><form:radiobutton path="codigo"
										value="${estrategia.codigo}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<br>
				<br>

				<h6>Comentarios</h6>
				<form:textarea path="comentarios" />
				<input type="submit" name="action" value="Aprobar"
					onclick="return confirm('¿Está seguro de querer Aprobar solicitud?');" />
				<input type="submit" name="action" value="Rechazar"
					onclick="return confirm('¿Está seguro de querer Rechazar solicitud?');" />
			</c:if>
			<input name="button" type="button" onclick=" window.open('','_self','');window.close();;"
				value="Cancelar" />
		</form:form>
	</div>
</div>

<%@ include file="pie.jsp"%>