<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<script>
	function alerta() {
		alert("Objetivo dado de baja");
	}
</script>
<div class="row">
	<div class="column grid_12">
		<form:form commandName="objetivoBusqueda" method="POST">
			<br>
			<br>
			<h4>Criterios de búsqueda</h4>

			<fieldset>
				<h5>Tipo Objetivo Estratégico</h5>
				<br>

				<form:radiobutton path="tipoObjetivo" value="General" id="general" />
				General <br>
				<form:radiobutton path="tipoObjetivo" value="Funcional"
					id="funcional" />
				Funcional <br> <br>
				<div id="formAreas" style="display: ${visibilidadFuncional};">
					<h5>Area Responsable</h5>
					<form:select path="area.codigo">
						<form:options items="${listaAreas}" itemLabel="nombre"
							itemValue="codigo" id="selectArea" />
					</form:select>
				</div>
				<br>
				<h5>Estado</h5>
				<form:select path="estado">
					<form:option label="pendiente de aprobacion" value="pendAprobacion" />
					<form:option label="pendiente de actualizacion" value="pendUpdate" />
					<form:option label="pendiente de baja" value="pendBaja" />
					<form:option label="registrado" value="registrado" />
					<form:option label="dado de baja" value="baja" />
					<form:option label="rechazado" value="rechazado" />
				</form:select>

				<input type="submit" id="Buscar" name="Buscar" value="Buscar" />

			</fieldset>

			<form:errors path="codigo" />
			<br>
			<c:if test="${not empty objetivos }">
				<table class="zebra">
					<thead>
						<tr>
							<th>Objetivo</th>
							<th>Tipo</th>
							<th>Estado</th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="objetivo" items="${objetivos}">
							<tr>
								<td><c:out value="${objetivo.descripcion}" /></td>
								<td><c:out value="${objetivo.tipoObjetivo}" /></td>
								<td><c:out value="${objetivo.estado}" /></td>
								<td><a
									href="registroObjetivo.htm?codigoObjetivo=${objetivo.codigo}">
										Actualizar </a></td>
								<td><a
									href="bajaObjetivo.htm?codigoObjetivo=${objetivo.codigo}"
									onclick="return confirm('¿Está seguro de querer dar de baja Objetivo?');">
										Dar de Baja </a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<br>
			<input type="button" id="Agregar" name="Agregar"
				onclick="location.href='<c:url value="/registroObjetivo.htm"/>'"
				value="Agregar" />

			<input type="button" id="Limpiar" name="Limpiar"
				onclick="location.href='<c:url value="consultaObjetivos.htm" />'"
				value="Limpiar" />

			<input name="button" type="button" onclick=" window.open('','_self','');window.close();;"
				value="Cancelar" />
		</form:form>
	</div>
</div>

<%@ include file="pie.jsp"%>