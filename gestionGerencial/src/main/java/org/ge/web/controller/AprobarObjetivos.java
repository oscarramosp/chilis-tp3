package org.ge.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.ge.model.Area;
import org.ge.model.Empleado;
import org.ge.model.Estrategia;
import org.ge.model.Indicador;
import org.ge.model.MapaEstrategico;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.model.ObjetivoGeneral;
import org.ge.model.PlanAccion;
import org.ge.service.EstrategiaManager;
import org.ge.service.IndicadorManager;
import org.ge.service.MapaEstrategicoManager;
import org.ge.service.ObjetivoManager;
import org.ge.service.OrganizacionManager;
import org.ge.service.PlanAccionManager;
import org.ge.util.FormUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AprobarObjetivos {

	@Autowired
	private ObjetivoManager objetivoManager;

	@RequestMapping(value = "/aprobacionObjetivos.htm", method = RequestMethod.GET)
	public void ConsultarAprobaciones(HttpSession sesion, Model model,
			@ModelAttribute("formUtil") FormUtil formUtil) {
	}

	@RequestMapping(value = "/aprobacionObjetivos.htm", method = RequestMethod.POST)
	public void BuscarPendientes(HttpSession sesion, Model model,
			@ModelAttribute("formUtil") FormUtil formUtil,
			@RequestParam String action) {
		Area area = ((Empleado) sesion.getAttribute("usuario")).getArea();
		if (action.equals("Buscar")) {
			if (formUtil.getTipoOperacion() != null) {
				if(area.getCodigo().equals(5)){
					List<ObjetivoGeneral> objetivos = null;
					objetivos = (List<ObjetivoGeneral>)(Object)objetivoManager.getListaObjetivosPendientesPorArea(area);
					model.addAttribute("objetivos", objetivos);
				} else {
					List<ObjetivoFuncional> objetivos = null;
					objetivos = (List<ObjetivoFuncional>)(Object)objetivoManager.getListaObjetivosPendientesPorArea(area);
					model.addAttribute("objetivos", objetivos);
				}
				
				model.addAttribute("formUtil", formUtil);
				

			}
		}
		if (action.equals("Aprobar")) {
				Objetivo objetivo = objetivoManager.getObjetivoPorCodigo(formUtil.getCodigo());
				objetivo.setComentarios(formUtil.getComentarios());
				if (objetivo.getEstado().equals("pendBaja")) {
					objetivo.setEstado("baja");
				} else {
					objetivo.setEstado("registrado");
				}
				if (objetivo.getTipoObjetivo().equals("General")) {
					objetivoManager
							.guardarObjetivoGeneral((ObjetivoGeneral) objetivo);
				} else {
					objetivoManager
							.guardarObjetivoFuncional((ObjetivoFuncional) objetivo);
				}
		} else {
			if (action.equals("Rechazar")) {
					Objetivo objetivo = objetivoManager.getObjetivoPorCodigo(formUtil.getCodigo());
					objetivo.setComentarios(formUtil.getComentarios());
					if (objetivo.getEstado().equals("pendBaja")) {
						objetivo.setEstado("registrado");
					} else {
						objetivo.setEstado("rechazado");
					}
					if (objetivo.getTipoObjetivo().equals("General")) {
						objetivoManager
								.guardarObjetivoGeneral((ObjetivoGeneral) objetivo);
					} else {
						objetivoManager
								.guardarObjetivoFuncional((ObjetivoFuncional) objetivo);
				}
			}
		}
	}

	@RequestMapping(value = "/visualizarElemento.htm")
	public ModelAndView VisualizarElemento(Model model,
			@RequestParam(value = "codigo") String codigo) {
			return new ModelAndView("redirect:/registroObjetivo.htm?codigoObjetivo=" + codigo);
	}
	
}
