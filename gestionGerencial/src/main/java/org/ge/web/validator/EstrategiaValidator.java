package org.ge.web.validator;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.ge.model.Estrategia;
import org.ge.service.EstrategiaManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public
class EstrategiaValidator implements Validator {
	@Autowired
	private EstrategiaManager estrategiaManager;

	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {
		return Estrategia.class.isAssignableFrom(clazz);
	}

	public void validate(Object object, Errors errors) {
		Estrategia estrategia = (Estrategia) object;
		if (StringUtils.isEmpty(estrategia.getDescripcion())) {
			errors.rejectValue("descripcion", "estrategia.descripcion.requerida");
		}
		if (StringUtils.isEmpty(estrategia.getNombre())) {
			errors.rejectValue("nombre", "estrategia.nombre.requerido");
		}
		
		boolean isRepeatDescription = estrategiaManager.isRepeatNombre(
				estrategia.getNombre(), estrategia.getCodigo());
		if (isRepeatDescription) {
			errors.rejectValue("descripcion", "estrategia.nombre.repetido");
		}
	}
	
	public void validarBusqueda(Object object, Errors errors) {
		Estrategia estrategia = (Estrategia) object;
		if (estrategia.getFechaFin() == null) {
			errors.rejectValue("fechaFin", "estrategia.fecha.requerida");
		}
		if (estrategia.getFechaInicio() == null) {
			errors.rejectValue("fechaInicio", "estrategia.fecha.requerida");
		}
	}
	
	@SuppressWarnings("unchecked")
	public void validarLista(Object object, Errors errors){		
		List<Estrategia> estrategias =(List<Estrategia>) object;
		if (estrategias.isEmpty()){
			System.out.println("aaa");
			errors.rejectValue("codigo", "estrategia.codigo.vacio");
		}		
	}
}