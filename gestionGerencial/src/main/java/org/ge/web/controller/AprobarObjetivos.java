package org.ge.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.ge.model.Area;
import org.ge.model.Empleado;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.model.ObjetivoGeneral;
import org.ge.service.ObjetivoManager;
import org.ge.util.FormUtil;
import org.ge.web.validator.ObjetivoValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AprobarObjetivos {

	@Autowired
	private ObjetivoManager objetivoManager;
	@Autowired
	private ObjetivoValidator objetivoValidator;

	@RequestMapping(value = "/aprobacionObjetivos.htm", method = RequestMethod.GET)
	public void ConsultarAprobaciones(HttpSession sesion, Model model,
			@ModelAttribute("formUtil") FormUtil formUtil) {
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/aprobacionObjetivos.htm", method = RequestMethod.POST)
	public String BuscarPendientes(HttpSession sesion, Model model,
			@ModelAttribute("formUtil") FormUtil formUtil,
			BindingResult result, @RequestParam String action) {
		Area area = ((Empleado) sesion.getAttribute("usuario")).getArea();
		if (action.equals("Buscar")) {
			if (formUtil.getTipoOperacion() != null) {				
				if(area.getCodigo().equals(5)){
					List<ObjetivoGeneral> objetivos = null;
					switch (formUtil.getTipoOperacion()) {
					case "Todos":
						objetivos = (List<ObjetivoGeneral>)(Object)objetivoManager.getListaObjetivosPendientesPorArea(area);
						break;
					case "PendientesRegistro":
						objetivos = (List<ObjetivoGeneral>)(Object)objetivoManager.getListaObjetivosPendientesAprobacionPorArea(area);
						break;
					case "PendientesActualizacion":
						objetivos = (List<ObjetivoGeneral>)(Object)objetivoManager.getListaObjetivosPendientesActualizacionPorArea(area);
						break;
					case "PendientesBaja":
						objetivos = (List<ObjetivoGeneral>)(Object)objetivoManager.getListaObjetivosPendientesBajaPorArea(area);
						break;
					}					
					model.addAttribute("objetivos", objetivos);
					objetivoValidator.validarListaObjetivoGeneral(objetivos, result);
				} else {
					List<ObjetivoFuncional> objetivos = null;
					switch (formUtil.getTipoOperacion()) {
					case "Todos":
						objetivos = (List<ObjetivoFuncional>)(Object)objetivoManager.getListaObjetivosPendientesPorArea(area);
						break;
					case "PendientesRegistro":
						objetivos = (List<ObjetivoFuncional>)(Object)objetivoManager.getListaObjetivosPendientesAprobacionPorArea(area);
						break;
					case "PendientesActualizacion":
						objetivos = (List<ObjetivoFuncional>)(Object)objetivoManager.getListaObjetivosPendientesActualizacionPorArea(area);
						break;
					case "PendientesBaja":
						objetivos = (List<ObjetivoFuncional>)(Object)objetivoManager.getListaObjetivosPendientesBajaPorArea(area);
						break;
					}
					model.addAttribute("objetivos", objetivos);
					objetivoValidator.validarListaObjetivoFuncional(objetivos, result);
				}
				
				model.addAttribute("formUtil", formUtil);
				
			}
		}
		if (action.equals("Aprobar")) {
				objetivoValidator.validarSeleccionAprobacion(formUtil, result);
				if (result.hasErrors()) {
					return "aprobacionObjetivos";
					
				}
				Objetivo objetivo = objetivoManager.getObjetivoPorCodigo(formUtil.getCodigo());
				objetivo.setComentarios(formUtil.getComentarios());				
				if (objetivo.getEstado().equals("pendBaja")) {
					//TODO: validación pendiente
					objetivo.setEstado("baja");
					model.addAttribute("mensajeConfirmacion", "Baja");
				} else {
					objetivo.setEstado("registrado");
					model.addAttribute("mensajeConfirmacion", "Registrado");
				}
				if (objetivo.getTipoObjetivo().equals("General")) {
					objetivoManager.guardarObjetivoGeneral((ObjetivoGeneral) objetivo);
				} else {
					objetivoManager.guardarObjetivoFuncional((ObjetivoFuncional) objetivo);
				}
				
		} else {
			if (action.equals("Rechazar")) {
					objetivoValidator.validarSeleccionAprobacion(formUtil, result);
					if (result.hasErrors()) {
						return "aprobacionObjetivos";
						
					}
					Objetivo objetivo = objetivoManager.getObjetivoPorCodigo(formUtil.getCodigo());
					objetivo.setComentarios(formUtil.getComentarios());					
					if (objetivo.getEstado().equals("pendBaja")) {
						objetivo.setEstado("registrado");
						model.addAttribute("mensajeConfirmacion", "Restaurado");
					} else {
						objetivo.setEstado("rechazado");
						model.addAttribute("mensajeConfirmacion", "Rechazado");
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
		return "aprobacionObjetivos";
	}

	@RequestMapping(value = "/visualizarElemento.htm")
	public ModelAndView VisualizarElemento(Model model,
			@RequestParam(value = "codigo") String codigo) {
			return new ModelAndView("redirect:/registroObjetivo.htm?codigoObjetivo=" + codigo);
	}
	
}
