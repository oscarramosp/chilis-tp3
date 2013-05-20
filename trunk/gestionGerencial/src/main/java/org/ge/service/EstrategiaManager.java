package org.ge.service;

import java.util.List;

import org.ge.model.Area;
import org.ge.model.Estrategia;

public interface EstrategiaManager {

	public List<Estrategia> getListaEstrategias(String estado);
	
	public List<Estrategia> getListaEstrategias(Estrategia estrategia);
	
	public List<Estrategia> getListaEstrategiasPorFechas(Estrategia estrategia);

	public Estrategia getEstrategiaPorCodigo(Integer codigoEstrategia);

	public void guardarEstrategia(Estrategia estrategia);
	
	public List<Estrategia> getListaEstrategiasPendientes();
	
	public List<Estrategia> getListaEstrategiasPendientesPorArea(Area area);
	
	public List<Estrategia> getListaEstrategiasPendientesAprobacionPorArea(Area area);
	
	public List<Estrategia> getListaEstrategiasPendientesActualizacionPorArea(Area area);
	
	public List<Estrategia> getListaEstrategiasPendientesBajaPorArea(Area area);
	
	public boolean isRepeatNombre(String descripcion,Integer codigoEstrategia);
}
