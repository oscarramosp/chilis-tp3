package org.ge.dao;

import java.util.List;

import org.ge.model.Indicador;

public interface IndicadorDao {
	
	public List<Indicador> getListaIndicadores(String estado);

	public Indicador getIndicadorPorCodigo(Integer codigoObjetivo);

	public void guardarIndicador(Indicador indicador);
	
	public List<Indicador> getListaIndicadores(Indicador indicador);
	
	public boolean isRepeatNombre(String nombre, Integer codigoIndicador);
	
	public boolean isRepeatDescription(String descripcion, Integer codigoIndicador);

}