package org.ge.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.ge.model.Area;
import org.ge.model.Empleado;
import org.ge.model.Estrategia;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.service.EstrategiaManager;
import org.ge.service.ObjetivoManager;
import org.ge.service.OrganizacionManager;
import org.ge.service.mail.MailService;
import org.ge.util.EstrategiaUtil;
import org.ge.web.validator.EstrategiaValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

@Controller
public class DefinirEstrategias {
	
	@Autowired
	private EstrategiaManager estrategiaManager;
	@Autowired
	private ObjetivoManager objetivoManager;
	@Autowired
	private OrganizacionManager organizacionManager;
	@Autowired
	private EstrategiaValidator estrategiaValidator;
	@Autowired
	private MailService mailService;
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	    dateFormat.setLenient(true);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping(value = "/consultaEstrategias.htm", method = RequestMethod.GET)
	public void ConsultarEstrategia(Model model,
			@ModelAttribute("estrategiaBusqueda") EstrategiaUtil estrategiaBusqueda) {
		if(estrategiaBusqueda.getTipoObjetivo() == null){
			estrategiaBusqueda.setTipoObjetivo("General");
			model.addAttribute("visibilidadGeneralEstrategia", "block");
		}
	}
	
	@RequestMapping(value = "/consultaEstrategias.htm", method = RequestMethod.POST)
	public String verListaConsulta(Model model,
			@ModelAttribute("estrategiaBusqueda") @Valid EstrategiaUtil estrategiaBusqueda,
			BindingResult result) {
		estrategiaValidator.validarBusqueda(estrategiaBusqueda, result);
		if (result.hasErrors()) {
			return "consultaEstrategias";
		}
		Estrategia aux = new Estrategia();
		aux = estrategiaBusqueda;
		if(estrategiaBusqueda.getTipoObjetivo().equals("General")){
			aux.setObjetivoEstrategia(estrategiaBusqueda.getObjetivoGeneral());
		}
		List<Estrategia> estrategias = estrategiaManager.getListaEstrategiasPorFechas(aux);
		model.addAttribute("estrategias", estrategias);
		estrategiaValidator.validarLista(estrategias, result);
		model.addAttribute("estrategiaBusqueda", estrategiaBusqueda);
		return "consultaEstrategias";
	}

	@RequestMapping(value = "/registroEstrategia.htm", method = RequestMethod.GET)
	public @ModelAttribute("estrategiaNueva") EstrategiaUtil registrarEstrategia (Model model, @RequestParam(value = "codigoEstrategia", required = false) Integer codigoEstrategia) {
		if (codigoEstrategia == null){
			EstrategiaUtil estrategiaNueva = new EstrategiaUtil();
			estrategiaNueva.setTipoObjetivo("General");
			model.addAttribute("tipoOperacion","Registrar");
			model.addAttribute("visibilidadFuncionalEstrategia", "none");
			model.addAttribute("visibilidadGeneralEstrategia", "block");
			return estrategiaNueva;
		} else {
			String visibilidadFuncional = "block";
			String visibilidadGeneral = "none";
			model.addAttribute("visibilidadFuncionalEstrategia", visibilidadFuncional);
			model.addAttribute("visibilidadGeneralEstrategia", visibilidadGeneral);
			EstrategiaUtil estrategiaNueva = (EstrategiaUtil) estrategiaManager.getEstrategiaPorCodigo(codigoEstrategia);
			model.addAttribute("tipoOperacion","Actualizar");
			return estrategiaNueva;
		}		
		
	}
	
	@RequestMapping(value = "/registroEstrategia.htm", method = RequestMethod.POST)
	public String saveEstrategia(Model model, @ModelAttribute("estrategiaNueva") EstrategiaUtil estrategiaNueva,
			BindingResult result, SessionStatus status) {
		try {
			estrategiaValidator.validate(estrategiaNueva, result);
			if (result.hasErrors()) {
				if(estrategiaNueva.getCodigo()==null){
					System.out.println("Validacion en Registro");
					model.addAttribute("tipoOperacion","Registrar");
				} else {
					System.out.println("Validacion en Update");
					model.addAttribute("tipoOperacion","Actualizar");
				}
				return "registroEstrategia";
			}
			if(estrategiaNueva.getCodigo()==null){
				Estrategia aux = new Estrategia();
				aux.setComentarios(estrategiaNueva.getComentarios());
				aux.setDescripcion(estrategiaNueva.getDescripcion());
				aux.setEstado("pendAprobacion");
				aux.setFechaFin(estrategiaNueva.getFechaFin());
				aux.setFechaInicio(estrategiaNueva.getFechaInicio());
				aux.setFechaRegistro(new Date());
				aux.setNombre(estrategiaNueva.getNombre());
				if(estrategiaNueva.getTipoObjetivo().equals("General")){
					 aux.setObjetivoEstrategia(estrategiaNueva.getObjetivoGeneral());
					 aux.setResponsableEstrategia(estrategiaNueva.getEmpleadoGeneral());
					 estrategiaManager.guardarEstrategia(aux);
					 mailService.mandarAlerta(organizacionManager.getEmpleadoPorCodigo(4), aux);
				} else {
					aux.setObjetivoEstrategia(estrategiaNueva.getObjetivoEstrategia());
					aux.setResponsableEstrategia(estrategiaNueva.getResponsableEstrategia());
					estrategiaManager.guardarEstrategia(aux);
					mailService.mandarAlerta(organizacionManager.getEmpleadoPorCodigo(estrategiaNueva.getArea().getCodigo()), aux);
				}
				model.addAttribute("mensajeConfirmacion", "PendRegistroEstrategia");
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
//				model.addAttribute("mensajeConfirmacion", "PendActualizacion");
//				
			}
			return "consultaEstrategias";
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error en DefinirEstrategias");
			return "registroEstrategia";
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
//		model.addAttribute("mensajeConfirmacion", "PendBaja");
//		return "consultaObjetivos";
//	}
	
	
	@ModelAttribute("listaAreas")
	public List<Area> listarAreas() {
		List<Area> listaAreas = organizacionManager.getListaAreas();
		listaAreas.remove(4);
		return listaAreas;
	}
	
	@ModelAttribute("visibilidadFuncionalEstrategia")
	public String visibilidadFuncionalEstrategia(@ModelAttribute("estrategiaBusqueda") EstrategiaUtil estrategiaBusqueda) {
		 if(estrategiaBusqueda.getTipoObjetivo() != null && estrategiaBusqueda.getTipoObjetivo().equals("Funcional")){
			 return "block";
		 } else {
			 return "none";
		 }
	}
	
	@ModelAttribute("visibilidadGeneralEstrategia")
	public String visibilidadGeneralEstrategia(@ModelAttribute("estrategiaBusqueda") EstrategiaUtil estrategiaBusqueda) {
		 if(estrategiaBusqueda.getTipoObjetivo() != null && estrategiaBusqueda.getTipoObjetivo().equals("General")){
			 return "block";
		 } else {
			 return "none";
		 }
	}
	
	@RequestMapping(value= "/listaObjetivosArea.htm", method = RequestMethod.GET)
	public @ResponseBody List<Objetivo> listarObjetivosFuncionales(@ModelAttribute("estrategiaBusqueda") EstrategiaUtil estrategiaBusqueda, 
			@RequestParam(value="searchId") Integer searchId) {
		if(searchId == null){
			return null;
		}
		Area area = organizacionManager.getAreaPorCodigo(searchId);
		List<Objetivo> listaObjetivos = objetivoManager.getListaObjetivosHabilesPorArea(area);
		System.out.println("TamañoLista:"+ listaObjetivos.size());
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
	
	@ModelAttribute("listaEmpleados")
	public List<Empleado> listarEmpleados() {
		List<Empleado> listaEmpleados = organizacionManager.getListaEmpleados();
		return listaEmpleados;
	}
}