package org.ge.service.impl;

import java.util.List;

import org.ge.dao.IndicadorDao;
import org.ge.model.Indicador;
import org.ge.model.ObjetivoFuncional;
import org.ge.service.IndicadorManager;
import org.ge.util.IndicadorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public
class IndicadorManagerImpl implements IndicadorManager {
	
	@Autowired
	private IndicadorDao indicadorDao;

	public List<Indicador> getListaIndicadores(String estado) {
		return indicadorDao.getListaIndicadores(estado);
	}

	public List<Indicador> getListaIndicadores(Indicador indicador) {
		return indicadorDao.getListaIndicadores(indicador);
	}
	
	public Indicador getIndicadorPorCodigo(Integer codigoIndicador) {
		return indicadorDao.getIndicadorPorCodigo(codigoIndicador);
	}
	
	public IndicadorUtil getIndicadorUtilPorCodigo(Integer codigoIndicador) {
		Indicador indicador = indicadorDao.getIndicadorPorCodigo(codigoIndicador);
		IndicadorUtil aux = new IndicadorUtil();
		aux.setCodigo(indicador.getCodigo());
		aux.setComentarios(indicador.getComentarios());
		aux.setDescripcion(indicador.getDescripcion());
		aux.setObjetivo(indicador.getObjetivo());
		aux.setEstado(indicador.getEstado());
		aux.setFechaRegistro(indicador.getFechaRegistro());
		aux.setFormula(indicador.getFormula());
		aux.setMeta(indicador.getMeta());
		aux.setNombre(indicador.getNombre());
		if(indicador.getObjetivo().getTipoObjetivo().equals("Funcional")){
			aux.setArea(((ObjetivoFuncional)indicador.getObjetivo()).getArea());
		}
		return aux;
	}

	public void guardarIndicador(Indicador indicador) {
		indicadorDao.guardarIndicador(indicador);
	}

	public List<Indicador> getListaIndicadoresPendientes() {
		List<Indicador> lista = getListaIndicadores("pendAprobacion");
		lista.addAll(getListaIndicadores("pendUpdate"));
		lista.addAll(getListaIndicadores("pendBaja"));
		return lista;		
	}
	
	public boolean isRepeatNombre(String nombre,
			Integer codigoIndicador) {
		return indicadorDao.isRepeatNombre(nombre, codigoIndicador);
	}
	
	public boolean isRepeatDescripcion(String descripcion,
			Integer codigoIndicador) {
		return indicadorDao.isRepeatDescription(descripcion, codigoIndicador);
	}

}