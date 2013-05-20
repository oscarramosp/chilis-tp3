package org.ge.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.ge.model.Area;
import org.ge.model.Empleado;
import org.ge.model.Estrategia;
import org.ge.service.EstrategiaManager;
import org.ge.util.FormUtil;
import org.ge.web.validator.EstrategiaValidator;
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
public class AprobarEstrategias {

	@Autowired
	private EstrategiaManager estrategiaManager;
	@Autowired
	private EstrategiaValidator estrategiaValidator;

	@RequestMapping(value = "/aprobacionEstrategias.htm", method = RequestMethod.GET)
	public void ConsultarAprobacionesEstrategias(HttpSession sesion, Model model,
			@ModelAttribute("formUtil") FormUtil formUtil) {
	}

	@RequestMapping(value = "/aprobacionEstrategias.htm", method = RequestMethod.POST)
	public void BuscarEstrategiasPendientes(HttpSession sesion, Model model,
			@ModelAttribute("formUtil") FormUtil formUtil,
			BindingResult result, @RequestParam String action) {
		Area area = ((Empleado) sesion.getAttribute("usuario")).getArea();
		if (action.equals("Buscar")) {
			if (formUtil.getTipoOperacion() != null) {	
					List<Estrategia> estrategias = null;
					switch (formUtil.getTipoOperacion()) {
					case "Todos":
						estrategias = estrategiaManager.getListaEstrategiasPendientesPorArea(area);
						break;
					case "PendientesRegistro":
						estrategias = estrategiaManager.getListaEstrategiasPendientesAprobacionPorArea(area);
						break;
					case "PendientesActualizacion":
						estrategias = estrategiaManager.getListaEstrategiasPendientesActualizacionPorArea(area);
						break;
					case "PendientesBaja":
						estrategias = estrategiaManager.getListaEstrategiasPendientesBajaPorArea(area);
						break;
					}					
					model.addAttribute("estrategias", estrategias);
					estrategiaValidator.validarLista(estrategias, result);
				model.addAttribute("formUtil", formUtil);
				
			}
		}
		if (action.equals("Aprobar")) {
				Estrategia estrategia = estrategiaManager.getEstrategiaPorCodigo(formUtil.getCodigo());
				estrategia.setComentarios(formUtil.getComentarios());
				if (estrategia.getEstado().equals("pendBaja")) {
					//TODO: validación pendiente
					estrategia.setEstado("baja");
					model.addAttribute("mensajeConfirmacion", "BajaEstrategia");
				} else {
					estrategia.setEstado("registrado");
					model.addAttribute("mensajeConfirmacion", "RegistradoEstrategia");
				}				
				estrategiaManager.guardarEstrategia(estrategia);
				
				
		} else {
			if (action.equals("Rechazar")) {
					Estrategia estrategia = estrategiaManager.getEstrategiaPorCodigo(formUtil.getCodigo());
					estrategia.setComentarios(formUtil.getComentarios());
					if (estrategia.getEstado().equals("pendBaja")) {
						estrategia.setEstado("registrado");
						model.addAttribute("mensajeConfirmacion", "RestauradoEstrategia");
					} else {
						estrategia.setEstado("rechazado");
						model.addAttribute("mensajeConfirmacion", "RechazadoEstrategia");
					}
					estrategiaManager.guardarEstrategia(estrategia);					
			}
		}
	}

	@RequestMapping(value = "/visualizarElementoEstrategia.htm")
	public ModelAndView VisualizarElemento(Model model,
			@RequestParam(value = "codigo") String codigo) {
			return new ModelAndView("redirect:/registroEstrategia.htm?codigoOEstrategia=" + codigo);
	}
	
}
