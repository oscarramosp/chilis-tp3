<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<spring:url value="/listaObjetivosArea.htm" var="listaObjetivosUrl"/>

<!-- <script type="text/javascript">
 function updateSelectOptions(lookupUrl, parentSelectElementId, childSelectElementId) {
     var parentSelectRef = jQuery('#' + parentSelectElementId);
     var childSelectRef  = jQuery('#' + childSelectElementId);
     jQuery.getJSON(lookupUrl,
         {searchId: parentSelectRef.val()}, 
         function(data) {
            var html = '<option value="">Selecionar...</option>';
             var len = data.length;
             for (var i = 0; i< len; i++) {
                 html += '<option value="' + data[i].codigo + '">' + data[i].descripcion + '</option>';
             }
             childSelectRef.html(html);
         }
     );
 }
</script> -->


<div class="row">
	<div class="column grid_12">
		<form:form commandName="estrategiaBusqueda" method="POST">
			<br>
			<br>
			<h4>Búsqueda de Iniciativa Estratégica</h4>

				<h5>Tipo Objetivo Estratégico</h5>
				<br>
				<form:radiobutton path="tipoObjetivo" value="General" id="general" />
				General <br>
				<form:radiobutton path="tipoObjetivo" value="Funcional" id="funcional" />
				Funcional <br><br>
 				
 				<div id="formAreas" style="display: ${visibilidadFuncionalEstrategia};">
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
					
					<spring:bind path="objetivoEstrategia.codigo">
					 <select id="selectObjetivo" name="objetivoEstrategia.codigo">
					  <c:forEach items="${listaObjetivosFuncionales}" var="objetivo">
					   <option value="${objetivo.codigo}" class="${objetivo.area.codigo}">${objetivo.descripcion}</option>
					  </c:forEach>
					 </select>
					</spring:bind>
					<form:errors path="objetivoEstrategia.codigo" />	
					
					 <script type="text/javascript" charset="utf-8">
				          $(function(){
				              $("#selectObjetivo").chained("#selectArea"); 
				          });
				     </script>
								
				</div>
				
				<div id="formObjetivoVinculadoGeneral" style="display: ${visibilidadGeneralEstrategia};">
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

				
				<h6>Desde:</h6><form:input path="fechaInicio" id="f_rangeStart" readonly="true"/><form:errors path="fechaInicio" />
				<button id="f_rangeStart_trigger">...</button>
				<script type="text/javascript">
                  RANGE_CAL_1 = new Calendar({
                          inputField: "f_rangeStart",
                          dateFormat: "%d/%m/%Y",
                          trigger: "f_rangeStart_trigger",
                          bottomBar: false,
                          onSelect: function() {
                                  var date = Calendar.intToDate(this.selection.get());
                                  LEFT_CAL.args.min = date;
                                  LEFT_CAL.redraw();
                                  this.hide();
                          }
                  });
                  function clearRangeStart() {
                          document.getElementById("f_rangeStart").value = "";
                          LEFT_CAL.args.min = null;
                          LEFT_CAL.redraw();
                  };
                </script>
                <br>
				<h6>Hasta:</h6><form:input path="fechaFin" id="f_rangeEnd" readonly="true"/><form:errors path="fechaFin" />
                <button id="f_rangeEnd_trigger">...</button>
                <script type="text/javascript">
                  RANGE_CAL_2 = new Calendar({
                          inputField: "f_rangeEnd",
                          dateFormat: "%d/%m/%Y",
                          trigger: "f_rangeEnd_trigger",
                          bottomBar: false,
                          onSelect: function() {
                                  var date = Calendar.intToDate(this.selection.get());
                                  LEFT_CAL.args.max = date;
                                  LEFT_CAL.redraw();
                                  this.hide();
                          }
                  });
                  function clearRangeEnd() {
                          document.getElementById("f_rangeEnd").value = "";
                          LEFT_CAL.args.max = null;
                          LEFT_CAL.redraw();
                  };
                </script>
                

				<br>
				<br>
				<input type="submit" id="Buscar" name="Buscar" value="Buscar" />
			<br>
			<form:errors path="codigo" />
			<br>
			<c:if test="${not empty estrategias }">
				<table class="zebra">
					<thead>
						<tr>
							<th>Iniciativa Estratégica</th>
							<th>Objetivo Estratégico</th>
							<th>Área Responsable</th>
							<th>Fecha Inicio</th>
							<th>Fecha Fin</th>
							<th>Estado</th>
							<th>Actualizar</th>
							<th>Dar de Baja</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="estrategia" items="${estrategias}">
							<tr>
								<td><c:out value="${estrategia.nombre}" /></td>
								<td><c:out value="${estrategia.objetivoEstrategia.descripcion}" /></td>
								<c:choose>
									<c:when test="${estrategiaBusqueda.tipoObjetivo == 'Funcional'}">
										<td><c:out value="${estrategia.objetivoEstrategia.area.nombre}" /></td>
									</c:when>
									<c:otherwise>
										<td>Ámbito General</td>
									</c:otherwise>
								</c:choose>							
								<td><fmt:formatDate value="${estrategia.fechaInicio}" pattern="dd/MM/yyyy" /></td>
								<td><fmt:formatDate value="${estrategia.fechaFin}" pattern="dd/MM/yyyy" /></td>
								<td><c:out value="${estrategia.estado}" /></td>
								<td><a
									href="registroEstrategia.htm?codigoEstrategia=${estrategia.codigo}">
										Actualizar </a></td>
								<td><a
									href="bajaEstrategia.htm?codigoEstrategia=${estrategia.codigo}"
									onclick="return confirm('¿Está seguro de querer dar de baja Estrategia?');">
										Dar de Baja </a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<br>
			<input type="button" id="Agregar" name="Agregar"
				onclick="location.href='<c:url value="/registroEstrategia.htm"/>'"
				value="Agregar" />

			<input type="button" id="Limpiar" name="Limpiar"
				onclick="location.href='<c:url value="consultaEstrategias.htm" />'"
				value="Limpiar" />

			<input name="button" type="button" onclick=" window.open('','_self','');window.close();;"
				value="Cancelar" />
		</form:form>
	</div>
</div>

<%@ include file="pie.jsp"%>