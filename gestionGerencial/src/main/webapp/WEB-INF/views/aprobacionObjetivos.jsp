<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<script>
function setCheckedValue(tipoElemento, Todos) {
	if(!tipoElemento)
		return;
	var radioLength =  radioObj.length;
	if(radioLength == undefined) {
		radioObj.checked = (radioObj.value == newValue.toString());
		return;
	}
	for(var i = 0; i < radioLength; i++) {
		tipoOperacion[i].checked = false;
		if(tipoOperacion[i].value == Todos.toString()) {
			tipoOperacion[i].checked = true;
		}
	}
}
</script>

	<h3>Pendientes de Aprobación</h3>
				<form:form commandName="formUtil" method="POST">
					<h1>Area: <c:out value="${usuario.area.nombre}" /></h1><br>
					
					<form:radiobutton path="tipoOperacion" value="Todos" id="Todos" checked="checked"/>Ver todos <br>
					<form:radiobutton path="tipoOperacion" value="PendientesRegistro" id="PendientesRegistro" />Pendientes de Registro <br>
					<form:radiobutton path="tipoOperacion" value="PendientesActualizacion" id="PendientesActualizacion" />Pendientes de Actualización <br>
					<form:radiobutton path="tipoOperacion" value="PendientesBaja" id="PendientesBaja" />Pendientes de Baja <br>

					<input type="submit" name="action" value="Buscar" />
						
				<c:if test="${not empty objetivos }">
				<br>
				<br>			
				
				<table>
					<thead>
						<tr>
							<td>DESCRIPCION</td>
							<td>TIPO DE OPERACION</td>
							<td>OBJETIVO VINCULADO</td>
							<td>VER</td>
							<td>SELECCIONAR</td>
						</tr>
					</thead>					
					<tbody>
						<c:forEach var="objetivo" items="${objetivos}">
							<tr>
								<td><c:out value="${objetivo.descripcion}" /></td>
								<td><c:out value="${objetivo.estado}" /></td>
								<c:choose>
								    <c:when test="${objetivo.tipoObjetivo == 'Funcional'}">
								        <td><c:out value="${objetivo.objetivoVinculado.descripcion}" /></td>
								    </c:when>
								    <c:otherwise>
								        <td>No aplica</td>
								    </c:otherwise>
								</c:choose>																
								<td><a href="visualizarElemento.htm?codigo=${objetivo.codigo}"> Ver</a>
								<td><form:radiobutton path="codigo" value="${objetivo.codigo}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<br>
				<br>
				
				<h6>Comentarios</h6>
				<form:textarea path="comentarios"/>
				<input type="submit" name="action" value="Aprobar" />
				<input type="submit" name="action" value="Rechazar" />
				</c:if>
				<c:if test="${empty elementos and not empty formUtil.tipoElemento}">
				<br>No se han encontrado elementos<br>
				</c:if>
				
				</form:form>

												
				<input name="button" type="button" onclick="window.close();" value="Cancelar" />	

<%@ include file="pie.jsp"%>