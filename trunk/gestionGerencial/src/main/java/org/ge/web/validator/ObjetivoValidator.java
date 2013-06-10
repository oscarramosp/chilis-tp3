package org.ge.web.validator;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.model.ObjetivoGeneral;
import org.ge.service.ObjetivoManager;
import org.ge.util.FormUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public
class ObjetivoValidator implements Validator {
	@Autowired
	private ObjetivoManager objetivoManager;

	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {
		return Objetivo.class.isAssignableFrom(clazz);
	}

	public void validate(Object object, Errors errors) {
		Objetivo objetivo = (Objetivo) object;
		if (StringUtils.isEmpty(objetivo.getDescripcion())) {
			errors.rejectValue("descripcion", "objetivo.descripcion.requerida");
		}
		
		boolean isRepeatDescription = objetivoManager.isRepeatDescription(
				objetivo.getDescripcion(), objetivo.getCodigo());
		if (isRepeatDescription) {
			errors.rejectValue("descripcion", "objetivo.descripcion.repetida");
		}
	}
	@SuppressWarnings("unchecked")
	public void validarLista(Object object, Errors errors){		
		List<Objetivo> objetivos =(List<Objetivo>) object;
		if (objetivos.isEmpty()){
			System.out.println("aaa");
			errors.rejectValue("codigo", "objetivo.codigo.vacio");
		}		
	}
	@SuppressWarnings("unchecked")
	public void validarListaObjetivoGeneral(Object object, Errors errors){		
		List<ObjetivoGeneral> objetivos =(List<ObjetivoGeneral>) object;
		if (objetivos.isEmpty()){
			System.out.println("aaa");
			errors.rejectValue("codigo", "objetivo.codigo.vacio");
		}		
	}
	@SuppressWarnings("unchecked")
	public void validarListaObjetivoFuncional(Object object, Errors errors){		
		List<ObjetivoFuncional> objetivos =(List<ObjetivoFuncional>) object;
		if (objetivos.isEmpty()){
			System.out.println("aaa");
			errors.rejectValue("codigo", "objetivo.codigo.vacio");
		}		
	}
	public void validarSeleccionAprobacion(FormUtil objetivo, Errors errors) {	
		if (objetivo.getCodigo() == null) {
			errors.rejectValue("codigo", "objetivo.codigo.select");
		}
	}
}