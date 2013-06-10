package org.ge.web.validator;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.ge.model.Indicador;
import org.ge.service.IndicadorManager;
import org.ge.util.IndicadorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public
class IndicadorValidator implements Validator {
	@Autowired
	private IndicadorManager indicadorManager;

	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {
		return Indicador.class.isAssignableFrom(clazz);
	}

	public void validate(Object object, Errors errors) {
		Indicador indicador = (Indicador) object;
		if (StringUtils.isEmpty(indicador.getDescripcion())) {
			errors.rejectValue("descripcion", "indicador.descripcion.requerida");
		}
		if (StringUtils.isEmpty(indicador.getNombre())) {
			errors.rejectValue("nombre", "indicador.nombre.requerido");
		}
		if (StringUtils.isEmpty(indicador.getFormula())) {
			errors.rejectValue("formula", "indicador.formula.requerida");
		}
		if (StringUtils.isEmpty(indicador.getMeta())) {
			errors.rejectValue("meta", "indicador.meta.requerida");
		}
		
		boolean isRepeatNombre = indicadorManager.isRepeatNombre(
				indicador.getNombre(), indicador.getCodigo());
		if (isRepeatNombre) {
			errors.rejectValue("nombre", "indicador.nombre.repetido");
		}
		
		boolean isRepeatDescription = indicadorManager.isRepeatDescripcion(
				indicador.getDescripcion(), indicador.getCodigo());
		if (isRepeatDescription) {
			errors.rejectValue("descripcion", "indicador.descripcion.repetida");
		}
		
		IndicadorUtil aux = (IndicadorUtil) object;
		if(aux.getTipoObjetivo().equals("Funcional")){
			if (aux.getArea().getCodigo() == null) {
				errors.rejectValue("area.codigo", "indicador.area.requerida");
			}
			
			if (aux.getObjetivo() == null || aux.getObjetivo().getCodigo() == null) {
				errors.rejectValue("objetivo.codigo", "indicador.objetivo.requerido");
			}
		} else {
			if (aux.getObjetivoGeneral().getCodigo() == null) {
				errors.rejectValue("objetivoGeneral.codigo", "indicador.objetivo.requerido");
			}
		}
		
	}
	
	public void validarBusqueda(Object object, Errors errors) {
		IndicadorUtil indicador = (IndicadorUtil) object;
		if (indicador.getTipoObjetivo().equals("Funcional") && (indicador.getObjetivo()== null || indicador.getObjetivo().getCodigo()== null)) {
			errors.rejectValue("objetivo.codigo", "indicador.objetivo.requerido");
		}
	}
	
	@SuppressWarnings("unchecked")
	public void validarLista(Object object, Errors errors){		
		List<Indicador> indicadores =(List<Indicador>) object;
		if (indicadores.isEmpty()){
			System.out.println("aaa");
			errors.rejectValue("codigo", "indicador.codigo.vacio");
		}		
	}
}