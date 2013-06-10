<%@ include file="/common/taglibs.jsp"%>
<%@ include file="cabecera.jsp"%>

<form:form commandName="objetivoNuevo" method="POST" onsubmit="return confirm('¿Está seguro de querer ${tipoOperacion} Objetivo?');">
			
<!-- <script> -->
<!--  function confirmacion() -->
<!--  { -->
<!--  var x; -->
<%--  var r=confirm("¿Está seguro de querer ${tipoOperacion} Objetivo?"); --%>
<!--  if (r==true) -->
<!--    { -->
<!--    x="true"; -->
<!--    } -->
<!--  else -->
<!--   { -->
<!--    x="false"; -->
<!--    } -->
<!--  } -->
<!-- </script> -->
	
<script>
   function alerta() 
  { 
  var operacion= "${tipoOperacion}";
   if (operacion=="Registrar") 
  	 { 
  	 alert("Objetivo Pendiente de Registro");
 	 } 
   else 
  	 { 
  	 alert("Objetivo Pendiente de Actualización");
  	 } 
   }
  </script> 
		<div class="row">
			<div class="column grid_12">
				<fieldset>
					<form:hidden path="codigo"/>
					<br>
					<c:if test="${tipoOperacion == 'Registrar'}">	
					<h3>Tipo Objetivo Estratégico</h3>
					<br>
					<form:radiobutton path="tipoObjetivo" value="General" id="general" /> General <br>
					<form:radiobutton path="tipoObjetivo" value="Funcional" id="funcional"/> Funcional <br>
					</c:if>
					<h6>Descripcion</h6>
					<form:textarea path="descripcion"/>
					<form:errors path="descripcion" />
				
					<c:if test="${tipoOperacion == 'Registrar' or objetivoNuevo.tipoObjetivo == 'Funcional'}">
					<div id="formAreas" style="display: ${visibilidadFuncional};">
					<h6>Area Responsable</h6>
					<form:select path="area.codigo" >
					<form:options items="${listaAreas}" itemLabel="nombre" itemValue="codigo" id="selectArea"/>
					</form:select>
					 </div>
					<div id="formObjetivoVinculado" style="display: ${visibilidadFuncional};">
					<h6>Objetivo Vinculado</h6>
					<form:select path="objetivoVinculado.codigo" >
					<form:options items="${listaObjetivosGenerales}" itemLabel="descripcion" itemValue="codigo" id="selectObjetivo"/>
					</form:select>
					 </div>		
					</c:if>					
					 
					 <c:if test="${tipoOperacion == 'Actualizar'}">
					<form:hidden path="objetivoEfecto.codigo"/>	
					<form:hidden path="tipoObjetivo"/>					
					 </c:if>	
					 			
					 <div id="formComentarios">
					<h6>Comentarios</h6>
					<form:textarea path="comentarios"/>	
					 </div>
					
					<input type="submit" id="<c:out value="tipoOperacion"></c:out>" name='<c:out value="tipoOperacion"></c:out>' value="${tipoOperacion}"/>
							
					<input name="button" type="button" onclick=" window.open('','_self','');window.close();;"
				value="Cancelar" />
				</fieldset>
		</div>
	</div>
						
					
</form:form>
<%@ include file="pie.jsp"%>
