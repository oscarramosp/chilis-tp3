package org.ge.service;

import java.util.List;

import org.ge.model.Area;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.model.ObjetivoGeneral;

public interface ObjetivoManager {

	public List<ObjetivoFuncional> getListaObjetivosFuncionales(ObjetivoFuncional objetivoFuncional);

	public List<ObjetivoGeneral> getListaObjetivosGenerales(ObjetivoGeneral objetivoGeneral);

	public Objetivo getObjetivoPorCodigo(Integer codigoObjetivo);
	
	public ObjetivoGeneral getObjetivoGeneralPorCodigo(Integer codigoObjetivo);
	
	public ObjetivoFuncional getObjetivoFuncionalPorCodigo(Integer codigoObjetivo);

	public void guardarObjetivoGeneral(ObjetivoGeneral objetivo);
	
	public void guardarObjetivoFuncional(ObjetivoFuncional objetivo);

	public boolean isRepeatDescription(String descripcion,Integer codigoObjetivo);
	
	public List<Objetivo> getListaObjetivos(String estado);
	
	public List<Objetivo> getListaObjetivosPendientes();
	
	public List<Objetivo> getListaObjetivosPendientesPorArea(Area area);
}
