<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<script>
 function alerta()
 {
 alert("Objetivo dado de baja");
 }
 </script>
 
<form:form commandName="objetivoBusqueda" method="POST">
	<h3>Criterios de búsqueda</h3>
				
				<fieldset>
					<h3>Tipo Objetivo Estratégico</h3><br>
					<form:radiobutton path="tipoObjetivo" value="General" id="general" /> General <br>
					<form:radiobutton path="tipoObjetivo" value="Funcional" id="funcional"/> Funcional <br>
				
					<div id="formAreas" style="display: ${visibilidadFuncional};">
					<label>Area Responsable</label>
					<form:select path="area.codigo" >
					<form:options items="${listaAreas}" itemLabel="nombre" itemValue="codigo" id="selectArea"/>
					</form:select>
					</div>
					
					<h3>Estado</h3>
					<form:select path="estado">
					<form:option label="pendiente de aprobacion" value="pendAprobacion"/>
					<form:option label="pendiente de actualizacion" value="pendUpdate"/>
					<form:option label="pendiente de baja" value="pendBaja"/>
					<form:option label="registrado" value="registrado"/>
					<form:option label="dado de baja" value="baja"/>
					<form:option label="rechazado" value="rechazado"/>
					</form:select>
					
					<input type="submit" id="Buscar" name="Buscar" value="Buscar" />
							
				</fieldset>
			
				<form:errors path="codigo"/>
				<br>
				<c:if test="${not empty objetivos }">				
				<table>
					<thead>
						<tr>
							<td>Objetivo</td>
							<td>Tipo</td>
							<td>Estado</td>
							<td></td>
							<td></td>
						</tr>
					</thead>					
					<tbody>
						<c:forEach var="objetivo" items="${objetivos}">
							<tr>
								<td><c:out value="${objetivo.descripcion}" /></td>
								<td><c:out value="${objetivo.tipoObjetivo}" /></td>
								<td><c:out value="${objetivo.estado}" /></td>
								<td><a href="registroObjetivo.htm?codigoObjetivo=${objetivo.codigo}"> Actualizar </a></td>
								<td><a href="bajaObjetivo.htm?codigoObjetivo=${objetivo.codigo}" onclick="return confirm('¿Está seguro de querer dar de baja Objetivo?');"> Dar de Baja </a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:if>
				
				<input type="button" id="Agregar" name="Agregar"
								onclick="location.href='<c:url value="/registroObjetivo.htm"/>'"
								value="Agregar" />
								
				<input type="button" id="Limpiar" name="Limpiar"
								onclick="location.href='<c:url value="consultaObjetivos.htm" />'"
								value="Limpiar" />
								
				<input name="button" type="button" onclick="window.close();" value="Cancelar" />	
</form:form>

<%@ include file="pie.jsp"%>