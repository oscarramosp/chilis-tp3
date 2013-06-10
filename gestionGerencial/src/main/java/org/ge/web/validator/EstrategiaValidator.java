package org.ge.web.validator;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.ge.model.Estrategia;
import org.ge.service.EstrategiaManager;
import org.ge.util.EstrategiaUtil;
import org.ge.util.FormUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class EstrategiaValidator implements Validator {
	@Autowired
	private EstrategiaManager estrategiaManager;

	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {
		return Estrategia.class.isAssignableFrom(clazz);
	}

	public void validate(Object object, Errors errors) {
		Estrategia estrategia = (Estrategia) object;
		if (StringUtils.isEmpty(estrategia.getDescripcion())) {
			errors.rejectValue("descripcion",
					"estrategia.descripcion.requerida");
		}
		if (StringUtils.isEmpty(estrategia.getNombre())) {
			errors.rejectValue("nombre", "estrategia.nombre.requerido");
		}
		boolean isRepeatNombre = estrategiaManager.isRepeatNombre(
				estrategia.getNombre(), estrategia.getCodigo());
		if (isRepeatNombre) {
			errors.rejectValue("nombre", "estrategia.nombre.repetido");
		}
		boolean isRepeatDescription = estrategiaManager.isRepeatDescription(
				estrategia.getDescripcion(), estrategia.getCodigo());
		if (isRepeatDescription) {
			errors.rejectValue("descripcion", "estrategia.descripcion.repetida");
		}
		if (estrategia.getFechaFin() == null || !validarFecha(estrategia.getFechaFin())) {
			errors.rejectValue("fechaFin", "estrategia.fecha.requerida");
		}
		if (estrategia.getFechaInicio() == null || !validarFecha(estrategia.getFechaInicio())) {
			errors.rejectValue("fechaInicio", "estrategia.fecha.requerida");
		}
		if (estrategia.getFechaInicio() != null && estrategia.getFechaFin() != null){
			if (!validarRangoFechas(estrategia.getFechaInicio(), estrategia.getFechaFin())){
				errors.rejectValue("fechaInicio", "estrategia.fecha.rango");
				errors.rejectValue("fechaFin", "estrategia.fecha.rango");
			}
		}
		EstrategiaUtil aux = (EstrategiaUtil) object;
		if(aux.getTipoObjetivo().equals("Funcional")){
			if (aux.getArea().getCodigo() == null) {
				errors.rejectValue("area.codigo", "estrategia.area.requerida");
			}
			if (aux.getObjetivoEstrategia() == null || aux.getObjetivoEstrategia().getCodigo() == null) {
				errors.rejectValue("objetivoEstrategia.codigo", "estrategia.objetivoEstrategia.requerido");
			}
			if (aux.getResponsableEstrategia() == null || aux.getResponsableEstrategia().getCodigo() == null) {
				errors.rejectValue("responsableEstrategia.codigo", "estrategia.responsableEstrategia.requerido");
			}
		} else {
			if (aux.getObjetivoGeneral().getCodigo() == null) {
				errors.rejectValue("objetivoGeneral.codigo", "estrategia.objetivoGeneral.requerido");
			}
			if (aux.getObjetivoGeneral().getCodigo() == null) {
				errors.rejectValue("empleadoGeneral.codigo", "estrategia.empleadoGeneral.requerido");
			}
		}
	}

	public void validarBusqueda(Object object, Errors errors) {
		EstrategiaUtil estrategia = (EstrategiaUtil) object;
		if (estrategia.getTipoObjetivo().equals("Funcional")
				&& (estrategia.getObjetivoEstrategia() == null || estrategia
						.getObjetivoEstrategia().getCodigo() == null)) {
			errors.rejectValue("objetivoEstrategia.codigo",
					"estrategia.objetivoEstrategia.requerido");
		}

		if (estrategia.getFechaFin() == null || !validarFecha(estrategia.getFechaFin())) {
			errors.rejectValue("fechaFin", "estrategia.fecha.requerida");
		}
		if (estrategia.getFechaInicio() == null || !validarFecha(estrategia.getFechaInicio())) {
			errors.rejectValue("fechaInicio", "estrategia.fecha.requerida");
		}
		
		if (estrategia.getFechaInicio() != null && estrategia.getFechaFin() != null){
			if (!validarRangoFechas(estrategia.getFechaInicio(), estrategia.getFechaFin())){
				errors.rejectValue("fechaInicio", "estrategia.fecha.rango");
				errors.rejectValue("fechaFin", "estrategia.fecha.rango");
			}
		}
	}

	@SuppressWarnings("unchecked")
	public void validarLista(Object object, Errors errors) {
		List<Estrategia> estrategias = (List<Estrategia>) object;
		if (estrategias.isEmpty()) {
			System.out.println("aaa");
			errors.rejectValue("codigo", "estrategia.codigo.vacio");
		}
	}

	private boolean validarFecha(Date fecha){

		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");	
		String aux = dateFormat.format(fecha);
		if (aux.trim().length()  != dateFormat.toPattern().length())  
		return false;  
		 
		dateFormat.setLenient(false);  
		  
		try {  
		dateFormat.parse(aux.trim());  
		}  
		catch (ParseException pe) { 
		return false;  
		} 
		return true;
	}
	
	private boolean validarRangoFechas(Date fechaInicio, Date fechaFin){
		if(fechaInicio.after(fechaFin)){
			return false;
		} else {
			return true;
		}
	}
	
	public void validarSeleccionAprobacion(FormUtil estrategia, Errors errors) {	
		if (estrategia.getCodigo() == null) {
			errors.rejectValue("codigo", "estrategia.codigo.select");
		}
	}
}