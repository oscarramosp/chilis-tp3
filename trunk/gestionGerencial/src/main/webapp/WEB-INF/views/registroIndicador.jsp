<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<form:form commandName="indicadorNuevo" method="POST" onsubmit="return confirm('�Est� seguro de querer ${tipoOperacion} Indicador?');">
	
<script>
   function alerta() 
  { 
  var operacion= "${tipoOperacion}";
   if (operacion=="Registrar") 
  	 { 
  	 alert("Indicador Pendiente de Registro");
 	 } 
   else 
  	 { 
  	 alert("Indicador Pendiente de Actualizaci�n");
  	 } 
   }
  </script> 
		<div class="row">
			<div class="column grid_12">
				<fieldset>
					<form:hidden path="codigo"/>
					<br>					
					<h4><c:out value="${tipoOperacion}"></c:out> Indicador</h4>
					
					<c:if test="${tipoOperacion == 'Registrar'}">	
					<br>
					<h5>Tipo Objetivo Estrat�gico Relacionado</h5>
					<br>
					<form:radiobutton path="tipoObjetivo" value="General" id="general" /> General <br>
					<form:radiobutton path="tipoObjetivo" value="Funcional" id="funcional"/> Funcional <br>					
					<br>
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
					</c:if>
					
					<h5>Objetivo Funcional Relacionado</h5>
					
					<spring:bind path="objetivo.codigo">
					 <select id="selectObjetivo" name="objetivo.codigo">
					  <c:forEach items="${listaObjetivosFuncionales}" var="objetivo">
					   <option value="${objetivo.codigo}" class="${objetivo.area.codigo}">${objetivo.descripcion}</option>
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
										
					<div id="formObjetivoVinculadoGeneral" style="display: ${visibilidadGeneralIndicador};">
					
					<h5>Objetivo General Relacionado</h5>
					
					<form:select path="objetivoGeneral.codigo" id="selectObjetivoGeneral" >
						<form:options items="${listaObjetivosGenerales}" itemLabel="descripcion"
							itemValue="codigo" id="selectObjetivo" />
					</form:select>
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
					 
					<h6>Formula</h6>
					<form:input path="formula"/>
					<form:errors path="formula" />
					
					<h6>Meta</h6>
					<form:input path="meta"/>
					<form:errors path="meta" />
					 
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
