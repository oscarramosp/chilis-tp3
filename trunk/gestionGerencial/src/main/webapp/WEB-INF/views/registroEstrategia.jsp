<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<form:form commandName="estrategiaNueva" method="POST" onsubmit="return confirm('¿Está seguro de querer ${tipoOperacion} Estrategia?');">
	
<script>
   function alerta() 
  { 
  var operacion= "${tipoOperacion}";
   if (operacion=="Registrar") 
  	 { 
  	 alert("Estrategia Pendiente de Registro");
 	 } 
   else 
  	 { 
  	 alert("Estrategia Pendiente de Actualización");
  	 } 
   }
  </script> 
		<div class="row">
			<div class="column grid_12">
				<fieldset>
					<form:hidden path="codigo"/>
					<br>					
					<h4><c:out value="${tipoOperacion}"></c:out> Iniciativa Estratégica</h4>
					
					<c:if test="${tipoOperacion == 'Registrar'}">	
					<br>
					<h5>Tipo Objetivo Estratégico Relacionado</h5>
					<br>
					<form:radiobutton path="tipoObjetivo" value="General" id="general" /> General <br>
					<form:radiobutton path="tipoObjetivo" value="Funcional" id="funcional"/> Funcional <br>					
					<br>
					<div id="formAreas" style="display: ${visibilidadFuncionalEstrategia};">
					<h5>Area Responsable</h5>
					
					<spring:bind path="area.codigo">
					 <select id="selectArea" name="area.codigo"<%--onchange="updateSelectOptions('${listaObjetivosUrl}', 'selectArea', 'objetivoEstrategia.codigo')"--%>> 
					 <option value="" label="">--Seleccionar...--</option>
					  <c:forEach items="${listaAreas}" var="area">					  					  
					   <option value="${area.codigo}">${area.nombre}</option>
					  </c:forEach>
					 </select>
					</spring:bind>		
					</c:if>
					
					<h5>Objetivo Funcional Relacionado</h5>
					
					<spring:bind path="objetivoEstrategia.codigo">
					 <select id="selectObjetivo" name="objetivoEstrategia.codigo">
					  <c:forEach items="${listaObjetivosFuncionales}" var="objetivo">
					   <option value="${objetivo.codigo}" class="${objetivo.area.codigo}">${objetivo.descripcion}</option>
					  </c:forEach>
					 </select>
					</spring:bind>					
					
					<h5>Persona responsable</h5>
					
					<spring:bind path="responsableEstrategia.codigo">
					 <select id="selectResponsable" name="responsableEstrategia.codigo">
					  <c:forEach items="${listaEmpleados}" var="empleado">
					   <option value="${empleado.codigo}" class="${empleado.area.codigo}">${empleado.nombre} ${empleado.apellido}</option>
					  </c:forEach>
					 </select>
					</spring:bind>
					
					<c:if test="${tipoOperacion == 'Registrar'}">
					 <script type="text/javascript" charset="utf-8">
				          $(function(){
				              $("#selectObjetivo").chained("#selectArea");
				              $("#selectResponsable").chained("#selectArea");
				          });
				     </script>
					</c:if>					
					</div>
										
					<div id="formObjetivoVinculadoGeneral" style="display: ${visibilidadGeneralEstrategia};">
					
					<h5>Objetivo General Relacionado</h5>
					
					<form:select path="objetivoGeneral.codigo" id="selectObjetivoGeneral" >
						<form:options items="${listaObjetivosGenerales}" itemLabel="descripcion"
							itemValue="codigo" id="selectObjetivo" />
					</form:select>
					
					<h5>Persona responsable</h5>
					
					<spring:bind path="empleadoGeneral.codigo">
					 <select id="selectResponsableGeneral" name="empleadoGeneral.codigo">
					  <c:forEach items="${listaEmpleados}" var="empleado">
					   <option value="${empleado.codigo}" class="${empleado.area.codigo}">${empleado.nombre} ${empleado.apellido}</option>
					  </c:forEach>
					 </select>
					</spring:bind>
					</div>
							
					<div id="formAreas" style="display: ${visibilidadFuncionalEstrategia};">
											
					
				     
				     </div>
					
					<h6>Nombre Estrategia</h6>
					<form:input path="nombre"/>
					<form:errors path="nombre" />
					
					<h6>Descripcion Estrategia</h6>
					<form:textarea path="descripcion"/>
					<form:errors path="descripcion" />
					 
					<c:if test="${tipoOperacion == 'Actualizar'}">
					<form:hidden path="objetivoEstrategia.codigo"/>
					</c:if>	
					
					<h5>Vigencia Estrategia</h5>				
					<br>
					<h6>Desde:</h6><form:input path="fechaInicio" id="f_rangeStart" /><form:errors path="fechaInicio" />	
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
					<h6>Hasta:</h6><form:input path="fechaFin" id="f_rangeEnd" /><form:errors path="fechaFin" />
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
					 	
					 			
					<div id="formComentarios">
					<h6>Comentarios</h6>
					<form:textarea path="comentarios"/>	
					</div>
					
					<input type="submit" id="<c:out value="tipoOperacion"></c:out>" name='<c:out value="tipoOperacion"></c:out>' value="${tipoOperacion}"/>
							
					<input name="button" type="button" onclick="window.close();" value="Cancelar" />		
				</fieldset>
		</div>
	</div>
						
					
</form:form>
<%@ include file="pie.jsp"%>
