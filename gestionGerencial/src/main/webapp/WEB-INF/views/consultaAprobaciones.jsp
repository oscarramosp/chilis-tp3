<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<script>
function setCheckedValue(tipoElemento, Estrategia) {
	if(!tipoElemento)
		return;
	var radioLength =  radioObj.length;
	if(radioLength == undefined) {
		radioObj.checked = (radioObj.value == newValue.toString());
		return;
	}
	for(var i = 0; i < radioLength; i++) {
		tipoElemento[i].checked = false;
		if(tipoElemento[i].value == Estrategia.toString()) {
			tipoElemento[i].checked = true;
		}
	}
}
</script>

	<h3>Pendientes de Aprobación</h3>
				<form:form commandName="formUtil" method="POST">
					<h1>Area: <c:out value="${usuario.area.nombre}" /></h1><br>
					
					<form:radiobutton path="tipoElemento" value="Objetivo" id="Objetivo" />Objetivos Estratégicos <br>
					<form:radiobutton path="tipoElemento" value="Estrategia" id="Estrategia" />Iniciativas Estratégicas <br>
					<form:radiobutton path="tipoElemento" value="PlanAccion" id="PlanAccion" />Planes de Acción <br>
					<form:radiobutton path="tipoElemento" value="Indicador" id="Indicador" />Indicadores <br>
					<form:radiobutton path="tipoElemento" value="MapaEstrategico" id="MapaEstrategico" />Mapas Estratégicos <br>

					<input type="submit" name="action" value="Buscar" />
						
				<c:if test="${not empty elementos }">
				<br>
				<br>			
				
				<table>
					<thead>
						<tr>
							<td>DESCRIPCION   </td>
							<td>TIPO DE OPERACION   </td>
							<td>SELECCIONAR   </td>
<!-- 							<td>CONSULTAR   </td> -->
<!-- 							<td>APROBAR   </td> -->
<!-- 							<td>RECHAZAR   </td> -->
							
						</tr>
					</thead>					
					<tbody>
						<c:forEach var="elemento" items="${elementos}">
							<tr>
								<td><c:out value="${elemento.descripcion}" /></td>
								<td><c:out value="${elemento.estado}" /></td>
								<td><a href="visualizarElemento.htm?codigo=${elemento.codigo}&tipo=${formUtil.tipoElemento}"> Ver </a>
								<td><form:radiobutton path="codigo" value="${elemento.codigo}"/></td>
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