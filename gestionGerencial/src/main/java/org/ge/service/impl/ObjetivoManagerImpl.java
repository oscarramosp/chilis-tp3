package org.ge.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.ge.dao.ObjetivoDao;
import org.ge.model.Area;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.model.ObjetivoGeneral;
import org.ge.service.ObjetivoManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ObjetivoManagerImpl implements ObjetivoManager {
	@Autowired
	private ObjetivoDao objetivoDao;

	public List<ObjetivoFuncional> getListaObjetivosFuncionales(
			ObjetivoFuncional objetivoFuncional) {
		return objetivoDao.getListaObjetivosFuncionales(objetivoFuncional);
	}

	public List<ObjetivoGeneral> getListaObjetivosGenerales(
			ObjetivoGeneral objetivoGeneral) {
		return objetivoDao.getListaObjetivosGenerales(objetivoGeneral);
	}

	public void guardarObjetivoGeneral(ObjetivoGeneral objetivo) {
		objetivoDao.guardarObjetivoGeneral(objetivo);

	}

	public void guardarObjetivoFuncional(ObjetivoFuncional objetivo) {
		objetivoDao.guardarObjetivoFuncional(objetivo);

	}

	public boolean isRepeatDescription(String descripcion,
			Integer codigoObjetivo) {
		return objetivoDao.isRepeatDescription(descripcion, codigoObjetivo);
	}

	public Objetivo getObjetivoPorCodigo(Integer codigoObjetivo) {
		return objetivoDao.getObjetivoPorCodigo(codigoObjetivo);
	}

	public ObjetivoGeneral getObjetivoGeneralPorCodigo(Integer codigoObjetivo) {
		return objetivoDao.getObjetivoGeneralPorCodigo(codigoObjetivo);
	}

	public ObjetivoFuncional getObjetivoFuncionalPorCodigo(
			Integer codigoObjetivo) {
		return objetivoDao.getObjetivoFuncionalPorCodigo(codigoObjetivo);
	}

	public List<Objetivo> getListaObjetivos(String estado) {
		return objetivoDao.getListaObjetivos(estado);
	}

	public List<Objetivo> getListaObjetivosPendientes() {
		List<Objetivo> lista = getListaObjetivos("pendAprobacion");
		lista.addAll(getListaObjetivos("pendUpdate"));
		lista.addAll(getListaObjetivos("pendBaja"));
		return lista;
	}

	public List<Objetivo> getListaObjetivosPendientesPorArea(Area area) {
		List<Objetivo> lista = getListaObjetivosPendientes();
		List<Objetivo> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("General")) {aux.add(objetivo);
				}
			}
		}
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("Funcional")) {
					if (objetivo.getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) objetivo).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(objetivo);

					}
				}
			}
		return aux;
	}
	
	public List<Objetivo> getListaObjetivosPendientesAprobacionPorArea(Area area) {
		List<Objetivo> lista = getListaObjetivos("pendAprobacion");
		List<Objetivo> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("General")) {aux.add(objetivo);
				}
			}
		}
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("Funcional")) {
					if (objetivo.getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) objetivo).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(objetivo);

					}
				}
			}
		return aux;
	}
	
	public List<Objetivo> getListaObjetivosPendientesActualizacionPorArea(Area area) {
		List<Objetivo> lista = getListaObjetivos("pendUpdate");
		List<Objetivo> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("General")) {aux.add(objetivo);
				}
			}
		}
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("Funcional")) {
					if (objetivo.getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) objetivo).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(objetivo);

					}
				}
			}
		return aux;
	}
	
	public List<Objetivo> getListaObjetivosPendientesBajaPorArea(Area area) {
		List<Objetivo> lista = getListaObjetivos("pendBaja");
		List<Objetivo> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("General")) {aux.add(objetivo);
				}
			}
		}
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("Funcional")) {
					if (objetivo.getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) objetivo).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(objetivo);

					}
				}
			}
		return aux;
	}
	
	public List<Objetivo> getListaObjetivosHabilesPorArea(Area area) {
		List<Objetivo> lista = getListaObjetivos("registrado");
		lista.addAll(getListaObjetivos("pendUpdate"));
		lista.addAll(getListaObjetivos("pendBaja"));
		List<Objetivo> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("General")) {aux.add(objetivo);
				}
			}
		}
			for (Objetivo objetivo : lista) {
				if (objetivo.getTipoObjetivo().equals("Funcional")) {
					if (objetivo.getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) objetivo).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(objetivo);

					}
				}
			}
		return aux;
	}
	
	public List<ObjetivoFuncional> getListaObjetivosFuncionalesHabiles() {
		List<Objetivo> lista = getListaObjetivos("registrado");
		lista.addAll(getListaObjetivos("pendUpdate"));
		lista.addAll(getListaObjetivos("pendBaja"));
		List<ObjetivoFuncional> aux = new ArrayList<>();
		for (Objetivo objetivo : lista) {
			if (objetivo.getTipoObjetivo().equals("Funcional")){
				aux.add((ObjetivoFuncional) objetivo);
			}
		}
		return aux;
	}
}