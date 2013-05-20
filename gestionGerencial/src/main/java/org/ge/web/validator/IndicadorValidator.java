package org.ge.web.validator;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.ge.model.Indicador;
import org.ge.service.EstrategiaManager;
import org.ge.util.IndicadorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public
class IndicadorValidator implements Validator {
	@Autowired
	private EstrategiaManager indicadorManager;

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
		
		boolean isRepeatDescription = indicadorManager.isRepeatNombre(
				indicador.getNombre(), indicador.getCodigo());
		if (isRepeatDescription) {
			errors.rejectValue("descripcion", "indicador.nombre.repetido");
		}
	}
	
	public void validarBusqueda(Object object, Errors errors) {
		IndicadorUtil indicador = (IndicadorUtil) object;
		if (indicador.getTipoObjetivo().equals("Funcional") && (indicador.getObjetivo()== null || indicador.getObjetivo().getCodigo()== null)) {
			errors.rejectValue("objetivo.codigo", "indicador.objetivoFuncional.requerido");
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