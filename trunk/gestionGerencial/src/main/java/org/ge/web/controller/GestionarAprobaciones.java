package org.ge.web.controller;

import javax.servlet.http.HttpSession;

import org.ge.util.FormUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GestionarAprobaciones {

//	@Autowired
//	private ObjetivoManager objetivoManager;
//	@Autowired
//	private OrganizacionManager organizacionManager;
//	@Autowired
//	private IndicadorManager indicadorManager;
//	@Autowired
//	private EstrategiaManager estrategiaManager;
//	@Autowired
//	private PlanAccionManager planAccionManager;
//	@Autowired
//	private MapaEstrategicoManager mapaEstrategicoManager;
//	@Autowired
//	private GestionarObjetivoController objetivoController;

	@RequestMapping(value = "/aprobaciones.htm", method = RequestMethod.GET)
	public void AprobarElementos(HttpSession sesion, Model model,
			@ModelAttribute("formUtil") FormUtil formUtil) {
	}
	
//	@RequestMapping(value = "/aprobacionObjetivos.htm", method = RequestMethod.POST)
//	public void BuscarPendientes(HttpSession sesion, Model model,
//			@ModelAttribute("formUtil") FormUtil formUtil,
//			@RequestParam String action) {
//		Area area = ((Empleado) sesion.getAttribute("usuario")).getArea();
//		if (action.equals("Buscar")) {
//			if (formUtil.getTipoElemento() != null) {
//				Object elementos = null;
//				switch (formUtil.getTipoElemento()) {
//				case "Objetivo":
//					elementos = (List<Objetivo>) objetivoManager
//							.getListaObjetivosPendientesPorArea(area);
//					break;
//				case "Estrategia":
//					elementos = (List<Estrategia>) estrategiaManager
//							.getListaEstrategiasPendientes();
//					break;
//				case "PlanAccion":
//					elementos = (List<PlanAccion>) planAccionManager
//							.getListaPlanesAccionPendientes();
//					break;
//				case "Indicador":
//					elementos = (List<PlanAccion>) planAccionManager
//							.getListaPlanesAccionPendientes();
//					break;
//				case "MapaEstrategico":
//					elementos = (List<MapaEstrategico>) mapaEstrategicoManager
//							.getListaMapasEstrategicosPendientes();
//					break;
//				}
//				model.addAttribute("formUtil", formUtil);
//				model.addAttribute("elementos", elementos);
//
//			}
//		}
//		if (action.equals("Aprobar")) {
//			switch (formUtil.getTipoElemento()) {
//			case "Objetivo":
//				Objetivo objetivo = objetivoManager
//						.getObjetivoPorCodigo(formUtil.getCodigo());
//				objetivo.setComentarios(formUtil.getComentarios());
//				if (objetivo.getEstado().equals("pendBaja")) {
//					objetivo.setEstado("baja");
//				} else {
//					objetivo.setEstado("registrado");
//				}
//				if (objetivo.getTipoObjetivo().equals("General")) {
//					objetivoManager
//							.guardarObjetivoGeneral((ObjetivoGeneral) objetivo);
//				} else {
//					objetivoManager
//							.guardarObjetivoFuncional((ObjetivoFuncional) objetivo);
//				}
//				break;
//			case "Estrategia":
//				Estrategia estrategia = estrategiaManager
//						.getEstrategiaPorCodigo(formUtil.getCodigo());
//				estrategia.setComentarios(formUtil.getComentarios());
//				if (estrategia.getEstado().equals("pendBaja")) {
//					estrategia.setEstado("baja");
//				} else {
//					estrategia.setEstado("registrado");
//				}
//				estrategiaManager.guardarEstrategia(estrategia);
//				break;
//			case "PlanAccion":
//				PlanAccion plan = planAccionManager
//						.getPlanAccionPorCodigo(formUtil.getCodigo());
//				plan.setComentarios(formUtil.getComentarios());
//				if (plan.getEstado().equals("pendBaja")) {
//					plan.setEstado("baja");
//				} else {
//					plan.setEstado("registrado");
//				}
//				planAccionManager.guardarPlanAccion(plan);
//				break;
//			case "Indicador":
//				Indicador indicador = indicadorManager
//						.getIndicadorPorCodigo(formUtil.getCodigo());
//				indicador.setComentarios(formUtil.getComentarios());
//				if (indicador.getEstado().equals("pendBaja")) {
//					indicador.setEstado("baja");
//				} else {
//					indicador.setEstado("registrado");
//				}
//				indicadorManager.guardarIndicador(indicador);
//				break;
//			case "MapaEstrategico":
//				MapaEstrategico mapaEstrategico = mapaEstrategicoManager
//						.getMapaEstrategicoPorCodigo(formUtil.getCodigo());
//				mapaEstrategico.setComentarios(formUtil.getComentarios());
//				if (mapaEstrategico.getEstado().equals("pendBaja")) {
//					mapaEstrategico.setEstado("baja");
//				} else {
//					mapaEstrategico.setEstado("registrado");
//				}
//				mapaEstrategicoManager.guardarMapaEstrategico(mapaEstrategico);
//				break;
//			}
//		} else {
//			if (action.equals("Rechazar")) {
//				switch (formUtil.getTipoElemento()) {
//				case "Objetivo":
//					Objetivo objetivo = objetivoManager
//							.getObjetivoPorCodigo(formUtil.getCodigo());
//					objetivo.setComentarios(formUtil.getComentarios());
//					if (objetivo.getEstado().equals("pendBaja")) {
//						objetivo.setEstado("registrado");
//					} else {
//						objetivo.setEstado("rechazado");
//					}
//					if (objetivo.getTipoObjetivo().equals("General")) {
//						objetivoManager
//								.guardarObjetivoGeneral((ObjetivoGeneral) objetivo);
//					} else {
//						objetivoManager
//								.guardarObjetivoFuncional((ObjetivoFuncional) objetivo);
//					}
//					break;
//				case "Estrategia":
//					Estrategia estrategia = estrategiaManager
//							.getEstrategiaPorCodigo(formUtil.getCodigo());
//					estrategia.setComentarios(formUtil.getComentarios());
//					if (estrategia.getEstado().equals("pendBaja")) {
//						estrategia.setEstado("registrado");
//					} else {
//						estrategia.setEstado("rechazado");
//					}
//					estrategiaManager.guardarEstrategia(estrategia);
//					break;
//				case "PlanAccion":
//					PlanAccion plan = planAccionManager
//							.getPlanAccionPorCodigo(formUtil.getCodigo());
//					plan.setComentarios(formUtil.getComentarios());
//					if (plan.getEstado().equals("pendBaja")) {
//						plan.setEstado("registrado");
//					} else {
//						plan.setEstado("rechazado");
//					}
//					planAccionManager.guardarPlanAccion(plan);
//					break;
//				case "Indicador":
//					Indicador indicador = indicadorManager
//							.getIndicadorPorCodigo(formUtil.getCodigo());
//					indicador.setComentarios(formUtil.getComentarios());
//					if (indicador.getEstado().equals("pendBaja")) {
//						indicador.setEstado("registrado");
//					} else {
//						indicador.setEstado("rechazado");
//					}
//					indicadorManager.guardarIndicador(indicador);
//					break;
//				case "MapaEstrategico":
//					MapaEstrategico mapaEstrategico = mapaEstrategicoManager
//							.getMapaEstrategicoPorCodigo(formUtil.getCodigo());
//					mapaEstrategico.setComentarios(formUtil.getComentarios());
//					if (mapaEstrategico.getEstado().equals("pendBaja")) {
//						mapaEstrategico.setEstado("registrado");
//					} else {
//						mapaEstrategico.setEstado("rechazado");
//					}
//					mapaEstrategicoManager
//							.guardarMapaEstrategico(mapaEstrategico);
//					break;
//				}
//			}
//		}
//	}
//
//	@RequestMapping(value = "/visualizarElemento.htm")
//	public ModelAndView VisualizarElemento(Model model,
//			@RequestParam(value = "codigo") String codigo,
//			@RequestParam(value = "tipo") String tipoElemento) {
//		switch (tipoElemento) {
//		case "Objetivo":
//			return new ModelAndView(
//					"redirect:/registroObjetivo.htm?codigoObjetivo=" + codigo);
//		case "Estrategia":
//			return new ModelAndView(
//					"redirect:/registroEstrategia.htm?codigoEstrategia="
//							+ codigo);
//		case "PlanAccion":
//			return new ModelAndView(
//					"redirect:/registroPlanAccion.htm?codigoPlanAccion="
//							+ codigo);
//		case "Indicador":
//			return new ModelAndView(
//					"redirect:/registroIndicador.htm?codigoIndicador=" + codigo);
//		case "MapaEstrategico":
//			return new ModelAndView(
//					"redirect:/registroMapaEstrategico.htm?codigoMapaEstrategico="
//							+ codigo);
//		}
//		return null;
//	}

	// @RequestMapping(value = "/aprobarElemento.htm", method =
	// RequestMethod.POST)
	// public String aprobarElemento(Model model,
	// @ModelAttribute("formUtil") FormUtil formUtil,
	// BindingResult result, SessionStatus status) {
	// System.out.println(formUtil.getCodigo());
	// System.out.println(formUtil.getComentarios());
	// switch (formUtil.getTipoElemento()) {
	// case "Objetivo":
	// Objetivo objetivo = objetivoManager.getObjetivoPorCodigo(formUtil
	// .getCodigo());
	// objetivo.setComentarios(formUtil.getComentarios());
	// if (objetivo.getEstado().equals("pendBaja")) {
	// objetivo.setEstado("baja");
	// } else {
	// objetivo.setEstado("registrado");
	// }
	// if (objetivo.getTipoObjetivo().equals("General")) {
	// objetivoManager
	// .guardarObjetivoGeneral((ObjetivoGeneral) objetivo);
	// } else {
	// objetivoManager
	// .guardarObjetivoFuncional((ObjetivoFuncional) objetivo);
	// }
	// case "Estrategia":
	// Estrategia estrategia = estrategiaManager
	// .getEstrategiaPorCodigo(formUtil.getCodigo());
	// estrategia.setComentarios(formUtil.getComentarios());
	// if (estrategia.getEstado().equals("pendBaja")) {
	// estrategia.setEstado("baja");
	// } else {
	// estrategia.setEstado("registrado");
	// }
	// estrategiaManager.guardarEstrategia(estrategia);
	// case "PlanAccion":
	// PlanAccion plan = planAccionManager.getPlanAccionPorCodigo(formUtil
	// .getCodigo());
	// plan.setComentarios(formUtil.getComentarios());
	// if (plan.getEstado().equals("pendBaja")) {
	// plan.setEstado("baja");
	// } else {
	// plan.setEstado("registrado");
	// }
	// planAccionManager.guardarPlanAccion(plan);
	// case "Indicador":
	// Indicador indicador = indicadorManager
	// .getIndicadorPorCodigo(formUtil.getCodigo());
	// indicador.setComentarios(formUtil.getComentarios());
	// if (indicador.getEstado().equals("pendBaja")) {
	// indicador.setEstado("baja");
	// } else {
	// indicador.setEstado("registrado");
	// }
	// indicadorManager.guardarIndicador(indicador);
	// case "MapaEstrategico":
	// MapaEstrategico mapaEstrategico = mapaEstrategicoManager
	// .getMapaEstrategicoPorCodigo(formUtil.getCodigo());
	// mapaEstrategico.setComentarios(formUtil.getComentarios());
	// if (mapaEstrategico.getEstado().equals("pendBaja")) {
	// mapaEstrategico.setEstado("baja");
	// } else {
	// mapaEstrategico.setEstado("registrado");
	// }
	// mapaEstrategicoManager.guardarMapaEstrategico(mapaEstrategico);
	// }
	// return "consultaAprobaciones";
	// }
	//
	// @RequestMapping(value = "/rechazarElemento.htm", method =
	// RequestMethod.POST)
	// public String RechazarElemento(Model model,
	// @ModelAttribute("formUtil") FormUtil formUtil) {
	// switch (formUtil.getTipoElemento()) {
	// case "Objetivo":
	// Objetivo objetivo = objetivoManager.getObjetivoPorCodigo(formUtil
	// .getCodigo());
	// objetivo.setComentarios(formUtil.getComentarios());
	// if (objetivo.getEstado().equals("pendBaja")) {
	// objetivo.setEstado("registrado");
	// } else {
	// objetivo.setEstado("rechazado");
	// }
	// if (objetivo.getTipoObjetivo().equals("General")) {
	// objetivoManager
	// .guardarObjetivoGeneral((ObjetivoGeneral) objetivo);
	// } else {
	// objetivoManager
	// .guardarObjetivoFuncional((ObjetivoFuncional) objetivo);
	// }
	// case "Estrategia":
	// Estrategia estrategia = estrategiaManager
	// .getEstrategiaPorCodigo(formUtil.getCodigo());
	// estrategia.setComentarios(formUtil.getComentarios());
	// if (estrategia.getEstado().equals("pendBaja")) {
	// estrategia.setEstado("registrado");
	// } else {
	// estrategia.setEstado("rechazado");
	// }
	// estrategiaManager.guardarEstrategia(estrategia);
	// case "PlanAccion":
	// PlanAccion plan = planAccionManager.getPlanAccionPorCodigo(formUtil
	// .getCodigo());
	// plan.setComentarios(formUtil.getComentarios());
	// if (plan.getEstado().equals("pendBaja")) {
	// plan.setEstado("registrado");
	// } else {
	// plan.setEstado("rechazado");
	// }
	// planAccionManager.guardarPlanAccion(plan);
	// case "Indicador":
	// Indicador indicador = indicadorManager
	// .getIndicadorPorCodigo(formUtil.getCodigo());
	// indicador.setComentarios(formUtil.getComentarios());
	// if (indicador.getEstado().equals("pendBaja")) {
	// indicador.setEstado("registrado");
	// } else {
	// indicador.setEstado("rechazado");
	// }
	// indicadorManager.guardarIndicador(indicador);
	// case "MapaEstrategico":
	// MapaEstrategico mapaEstrategico = mapaEstrategicoManager
	// .getMapaEstrategicoPorCodigo(formUtil.getCodigo());
	// mapaEstrategico.setComentarios(formUtil.getComentarios());
	// if (mapaEstrategico.getEstado().equals("pendBaja")) {
	// mapaEstrategico.setEstado("registrado");
	// } else {
	// mapaEstrategico.setEstado("rechazado");
	// }
	// mapaEstrategicoManager.guardarMapaEstrategico(mapaEstrategico);
	// }
	// return "consultaAprobaciones";
	// }

}
