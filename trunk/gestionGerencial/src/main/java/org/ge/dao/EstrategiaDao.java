package org.ge.dao;

import java.util.List;

import org.ge.model.Estrategia;
import org.ge.model.ObjetivoFuncional;

public interface EstrategiaDao {
	
	public List<Estrategia> getListaEstrategias(String estado);
	
	public List<Estrategia> getListaEstrategias(Estrategia estrategia);

	public Estrategia getEstrategiaPorCodigo(Integer codigoEstrategia);

	public void guardarEstrategia(Estrategia estrategia);

	public boolean isRepeatDescription(String descripcion, Integer codigoEstrategia);
}