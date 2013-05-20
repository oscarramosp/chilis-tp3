<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<spring:url value="/listaObjetivosAreaIndicador.htm" var="listaObjetivosUrl"/>

<div class="row">
	<div class="column grid_12">
		<form:form commandName="indicadorBusqueda" method="POST">
			<br>
			<br>
			<h4>Búsqueda de Indicadores</h4>

				<h5>Tipo Objetivo Estratégico</h5>
				<br>
				<form:radiobutton path="tipoObjetivo" value="General" id="general"/>
				General <br>
				<form:radiobutton path="tipoObjetivo" value="Funcional" id="funcional" />
				Funcional <br><br>
 				
 				<div id="formAreas" style="display: ${visibilidadFuncionalIndicador};">
					<h5>Area Responsable</h5>
					
					<spring:bind path="area.codigo">
					 <select id="selectArea" name="area.codigo"> 
					 <option value="" label="">--Seleccionar...--</option>
					  <c:forEach items="${listaAreas}" var="area">					  					  
					   <option value="${area.codigo}">${area.nombre}</option>
					  </c:forEach>
					 </select>
					</spring:bind>								
								
					<h5>Objetivo Funcional Relacionado</h5>
					
					<spring:bind path="objetivo.codigo">
					 <select id="selectObjetivo" name="objetivo.codigo">
					  <c:forEach items="${listaObjetivosFuncionales}" var="objetivo">
					   <option value="${objetivo.codigo}" class="${objetivo.area.codigo}">${objetivo.descripcion}</option>
					  </c:forEach>
					 </select>
					</spring:bind>
					<form:errors path="objetivo.codigo" />
					
					 <script type="text/javascript" charset="utf-8">
				          $(function(){
				              $("#selectObjetivo").chained("#selectArea"); 
				          });
				     </script>
								
				</div>
				
				<div id="formObjetivoVinculadoGeneral" style="display: ${visibilidadGeneralIndicador};">
					<h5>Objetivo General Relacionado</h5>
					<form:select path="objetivoGeneral.codigo" id="selectObjetivoGeneral" >
						<form:options items="${listaObjetivosGenerales}" itemLabel="descripcion"
							itemValue="codigo" id="selectObjetivo" />
					</form:select>
				</div>
							
				
				<h5>Estado</h5>
				<form:select path="estado">
					<form:option label="pendiente de aprobacion" value="pendAprobacion" />
					<form:option label="pendiente de actualizacion" value="pendUpdate" />
					<form:option label="pendiente de baja" value="pendBaja" />
					<form:option label="registrado" value="registrado" />
					<form:option label="dado de baja" value="baja" />
					<form:option label="rechazado" value="rechazado" />
				</form:select>                

				<br>
				<br>
				<input type="submit" id="Buscar" name="Buscar" value="Buscar" />
			<br>
			<form:errors path="codigo" />
			<br>
			<c:if test="${not empty indicadores }">
				<table class="zebra">
					<thead>
						<tr>
							<th>Indicador</th>
							<th>Objetivo Estratégico</th>
							<th>Estado</th>
							<th>Actualizar</th>
							<th>Dar de Baja</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="indicador" items="${indicadores}">
							<tr>
								<td><c:out value="${indicador.nombre}" /></td>
								<td><c:out value="${indicador.objetivo.descripcion}" /></td>
								<td><c:out value="${indicador.estado}" /></td>
								<td><a
									href="registroIndicador.htm?codigoIndicador=${indicador.codigo}">
										Actualizar </a></td>
								<td><a
									href="bajaIndicador.htm?codigoIndicador=${indicador.codigo}"
									onclick="return confirm('¿Está seguro de querer dar de baja Indicador?');">
										Dar de Baja </a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<br>
			<input type="button" id="Agregar" name="Agregar"
				onclick="location.href='<c:url value="/registroIndicador.htm"/>'"
				value="Agregar" />

			<input type="button" id="Limpiar" name="Limpiar"
				onclick="location.href='<c:url value="consultaIndicadores.htm" />'"
				value="Limpiar" />

			<input name="button" type="button" onclick=" window.open('','_self','');window.close();;"
				value="Cancelar" />
		</form:form>
	</div>
</div>

<%@ include file="pie.jsp"%>