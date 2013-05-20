package org.ge.web.controller;

import java.util.Date;
import java.util.List;

import org.ge.model.Area;
import org.ge.model.Indicador;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.service.IndicadorManager;
import org.ge.service.ObjetivoManager;
import org.ge.service.OrganizacionManager;
import org.ge.service.mail.MailService;
import org.ge.util.IndicadorUtil;
import org.ge.web.validator.IndicadorValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

@Controller
public class GestionarIndicadores {
	
	@Autowired
	private IndicadorManager indicadorManager;
	@Autowired
	private ObjetivoManager objetivoManager;
	@Autowired
	private OrganizacionManager organizacionManager;
	@Autowired
	private IndicadorValidator indicadorValidator;
	@Autowired
	private MailService mailService;
	
	@RequestMapping(value = "/consultaIndicadores.htm", method = RequestMethod.GET)
	public void ConsultarIndicador(Model model,
			@ModelAttribute("indicadorBusqueda") IndicadorUtil indicadorBusqueda) {
		if(indicadorBusqueda.getTipoObjetivo() == null){
			indicadorBusqueda.setTipoObjetivo("General");
			model.addAttribute("indicadorBusqueda", indicadorBusqueda);
			model.addAttribute("visibilidadGeneralIndicador", "block");
		}
	}
	
	@RequestMapping(value = "/consultaIndicadores.htm", method = RequestMethod.POST)
	public String verListaConsulta(Model model,
			@ModelAttribute("indicadorBusqueda") IndicadorUtil indicadorBusqueda,
			BindingResult result) {
		indicadorValidator.validarBusqueda(indicadorBusqueda, result);
		if (result.hasErrors()) {
			return "consultaIndicadores";
		}
		Indicador aux = new Indicador();
		aux = indicadorBusqueda;
		if(indicadorBusqueda.getTipoObjetivo().equals("General")){
			aux.setObjetivo(indicadorBusqueda.getObjetivoGeneral());
		}
		List<Indicador> indicadores = indicadorManager.getListaIndicadores(aux);
		model.addAttribute("indicadores", indicadores);
		indicadorValidator.validarLista(indicadores, result);
		model.addAttribute("indicadorBusqueda", indicadorBusqueda);
		return "consultaIndicadores";
	}

	@RequestMapping(value = "/registroIndicador.htm", method = RequestMethod.GET)
	public @ModelAttribute("indicadorNuevo") IndicadorUtil registrarIndicador (Model model, @RequestParam(value = "codigoIndicador", required = false) Integer codigoIndicador) {
		if (codigoIndicador == null){
			IndicadorUtil indicadorNuevo = new IndicadorUtil();
			indicadorNuevo.setTipoObjetivo("General");
			model.addAttribute("tipoOperacion","Registrar");
			model.addAttribute("visibilidadFuncionalIndicador", "none");
			model.addAttribute("visibilidadGeneralIndicador", "block");
			return indicadorNuevo;
		} else {
			String visibilidadFuncional = "block";
			String visibilidadGeneral = "none";
			model.addAttribute("visibilidadFuncionalIndicador", visibilidadFuncional);
			model.addAttribute("visibilidadGeneralIndicador", visibilidadGeneral);
			IndicadorUtil indicadorNuevo = (IndicadorUtil) indicadorManager.getIndicadorPorCodigo(codigoIndicador);
			model.addAttribute("tipoOperacion","Actualizar");
			return indicadorNuevo;
		}
	}
	
	@RequestMapping(value = "/registroIndicador.htm", method = RequestMethod.POST)
	public String saveIndicador(Model model, @ModelAttribute("indicadorNuevo") IndicadorUtil indicadorNuevo,
			BindingResult result, SessionStatus status) {
		try {
			indicadorValidator.validate(indicadorNuevo, result);
			if (result.hasErrors()) {
				return "registroIndicador";
			}
			if(indicadorNuevo.getCodigo()==null){
				Indicador aux = new Indicador();
				aux.setComentarios(indicadorNuevo.getComentarios());
				aux.setDescripcion(indicadorNuevo.getDescripcion());
				aux.setEstado("pendAprobacion");
				aux.setFechaRegistro(new Date());
				aux.setNombre(indicadorNuevo.getNombre());
				if(indicadorNuevo.getTipoObjetivo().equals("General")){
					 aux.setObjetivo(indicadorNuevo.getObjetivoGeneral());
					 indicadorManager.guardarIndicador(aux);
					 mailService.mandarAlerta(organizacionManager.getEmpleadoPorCodigo(4), aux);
				} else {
					aux.setObjetivo(indicadorNuevo.getObjetivo());
					indicadorManager.guardarIndicador(aux);
					mailService.mandarAlerta(organizacionManager.getEmpleadoPorCodigo(indicadorNuevo.getArea().getCodigo()), aux);
				}
				model.addAttribute("mensajeConfirmacion", "PendRegistroIndicador");
			} else {
//				if(objetivoNuevo.getTipoObjetivo().equals("General")){
//					objetivoNuevo.setFechaRegistro(objetivoManager.getObjetivoGeneralPorCodigo(objetivoNuevo.getCodigo()).getFechaRegistro());
//					 ObjetivoGeneral aux = objetivoManager.getObjetivoGeneralPorCodigo(objetivoNuevo.getCodigo());
//					 aux.setEstado("pendUpdate");
//					 aux.setDescripcion(objetivoNuevo.getDescripcion());
//					 aux.setComentarios(objetivoNuevo.getComentarios());
//					objetivoManager.guardarObjetivoGeneral(aux);
//					mailService.mandarAlerta(organizacionManager.getEmpleadoPorCodigo(4), aux);
//				} else {
//					ObjetivoFuncional aux = objetivoManager.getObjetivoFuncionalPorCodigo(objetivoNuevo.getCodigo());
//					aux.setArea(objetivoNuevo.getArea());
//					aux.setObjetivoVinculado(objetivoNuevo.getObjetivoVinculado());
//					aux.setEstado("pendUpdate");
//					aux.setDescripcion(objetivoNuevo.getDescripcion());
//					aux.setComentarios(objetivoNuevo.getComentarios());
//					aux.setFechaRegistro(objetivoManager.getObjetivoFuncionalPorCodigo(objetivoNuevo.getCodigo()).getFechaRegistro());
//					objetivoManager.guardarObjetivoFuncional(aux);
//					mailService.mandarAlerta(organizacionManager.getResponsableArea(aux.getArea()), aux);
//				}
//				model.addAttribute("mensajeConfirmacion", "PendActualizacionIndicador");
//				
			}
			return "consultaIndicadores";
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return "registroIndicador";
		}
	}
	
//	@RequestMapping("/bajaEstrategia.htm")
//	public String darBajaObjetivo(Model model,
//			@RequestParam(value = "codigoEstrategia", required = false) Integer codigoEstrategia) {
//		Estrategia estrategia = estrategiaManager.getObjetivoPorCodigo(codigoObjetivo);		
//		if(objetivo.getTipoObjetivo().equals("General")){
//			ObjetivoGeneral aux = estrategiaManager.getObjetivoGeneralPorCodigo(codigoObjetivo);
//			aux.setEstado("pendBaja");
//			estrategiaManager.guardarObjetivoGeneral(aux);
//		} else {
//			ObjetivoFuncional aux = estrategiaManager.getObjetivoFuncionalPorCodigo(codigoObjetivo);
//			aux.setEstado("pendBaja");
//			estrategiaManager.guardarObjetivoFuncional(aux);
//		}
//		model.addAttribute("mensajeConfirmacion", "PendBajaIndicador");
//		return "consultaObjetivos";
//	}
	
	
	@ModelAttribute("listaAreas")
	public List<Area> listarAreas() {
		List<Area> listaAreas = organizacionManager.getListaAreas();
		listaAreas.remove(4);
		return listaAreas;
	}
	
	@ModelAttribute("visibilidadFuncionalIndicador")
	public String visibilidadFuncionalIndicador(@ModelAttribute("indicadorBusqueda") IndicadorUtil indicadorBusqueda) {
		 if(indicadorBusqueda.getTipoObjetivo() != null && indicadorBusqueda.getTipoObjetivo().equals("Funcional")){
			 return "block";
		 } else {
			 return "none";
		 }
	}
	
	@ModelAttribute("visibilidadGeneralIndicador")
	public String visibilidadGeneralIndicador(@ModelAttribute("indicadorBusqueda") IndicadorUtil indicadorBusqueda) {
		 if(indicadorBusqueda.getTipoObjetivo() != null && indicadorBusqueda.getTipoObjetivo().equals("General")){
			 return "block";
		 } else {
			 return "none";
		 }
	}
	
	@RequestMapping(value= "/listaObjetivosAreaIndicador.htm", method = RequestMethod.GET)
	public @ResponseBody List<Objetivo> listarObjetivosFuncionales(@ModelAttribute("indicadorBusqueda") IndicadorUtil indicadorBusqueda, 
			@RequestParam(value="searchId") Integer searchId) {
		if(searchId == null){
			return null;
		}
		Area area = organizacionManager.getAreaPorCodigo(searchId);
		List<Objetivo> listaObjetivos = objetivoManager.getListaObjetivosHabilesPorArea(area);
		System.out.println(listaObjetivos.size());
		return listaObjetivos;
	}
	
	@ModelAttribute("listaObjetivosGenerales")
	public List<Objetivo> listarObjetivosGenerales() {
		Area area = organizacionManager.getAreaPorCodigo(5);
		List<Objetivo> listaObjetivos = objetivoManager.getListaObjetivosHabilesPorArea(area);
		return listaObjetivos;
	}
	
	@ModelAttribute("listaObjetivosFuncionales")
	public List<ObjetivoFuncional> listarObjetivosFuncionalesAux() {
		List<ObjetivoFuncional> listaObjetivos = objetivoManager.getListaObjetivosFuncionalesHabiles();
		return listaObjetivos;
	}
}