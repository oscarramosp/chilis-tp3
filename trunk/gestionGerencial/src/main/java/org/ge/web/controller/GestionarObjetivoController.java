package org.ge.web.controller;

import java.util.List;

import org.ge.model.Area;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.model.ObjetivoGeneral;
import org.ge.service.ObjetivoManager;
import org.ge.service.OrganizacionManager;
import org.ge.service.mail.MailService;
import org.ge.web.validator.ObjetivoValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

@Controller
public class GestionarObjetivoController {
	@Autowired
	private ObjetivoManager objetivoManager;
	@Autowired
	private OrganizacionManager organizacionManager;
	@Autowired
	private ObjetivoValidator objetivoValidator;
	@Autowired
	private MailService mailService;	

	@RequestMapping(value = "/consultaObjetivos.htm", method = RequestMethod.GET)
	public void ConsultarObjetivo(Model model,
			@ModelAttribute("objetivoBusqueda") ObjetivoFuncional objetivoBusqueda) {
		if(objetivoBusqueda.getTipoObjetivo()== null){
			objetivoBusqueda.setTipoObjetivo("General");
		}			
	}
	
	@RequestMapping(value = "/consultaObjetivos.htm", method = RequestMethod.POST)
	public void verListaConsulta(Model model,
			@ModelAttribute("objetivoBusqueda") ObjetivoFuncional objetivoBusqueda, BindingResult result) {
		if(objetivoBusqueda.getTipoObjetivo().equals("Funcional")){
			List<ObjetivoFuncional> objetivos = objetivoManager.getListaObjetivosFuncionales(objetivoBusqueda);
			model.addAttribute("objetivos", objetivos);
			objetivoValidator.validarLista(objetivos, result);
		} else {
			ObjetivoGeneral aux = new ObjetivoGeneral(objetivoBusqueda.getDescripcion(), "");
			aux.setEstado(objetivoBusqueda.getEstado());
			List<ObjetivoGeneral> objetivos = objetivoManager.getListaObjetivosGenerales(aux);
			model.addAttribute("objetivos", objetivos);
			objetivoValidator.validarLista(objetivos, result);
		}
		model.addAttribute("objetivoBusqueda", objetivoBusqueda);
		model.addAttribute("tipoObjetivo", "General");
	}

	
	@RequestMapping(value = "/registroObjetivo.htm", method = RequestMethod.GET)
	public @ModelAttribute("objetivoNuevo") Objetivo registrarObjetivo (Model model, @RequestParam(value = "codigoObjetivo", required = false) Integer codigoObjetivo) {
		if (codigoObjetivo == null){
			Objetivo objetivoNuevo = new ObjetivoFuncional();
			objetivoNuevo.setTipoObjetivo("General");
			model.addAttribute("tipoOperacion","Registrar");
			String visibilidadFuncional = "none";	
			model.addAttribute("visibilidadFuncional", visibilidadFuncional);
			return objetivoNuevo;
		} else {
			String visibilidadFuncional = "block";	
			model.addAttribute("visibilidadFuncional", visibilidadFuncional);
			Objetivo objetivoNuevo = objetivoManager.getObjetivoPorCodigo(codigoObjetivo);
			model.addAttribute("tipoOperacion","Actualizar");
//			if(objetivoNuevo.getTipoObjetivo().equals("General")){
//				model.addAttribute("tipoOperacion","Actualizar");
//			} else {
//				model.addAttribute("tipoOperacion","Actualizar");
//			}
			return objetivoNuevo;
		}		
		
	}
	
	@RequestMapping(value = "/registroObjetivo.htm", method = RequestMethod.POST)
	public String saveObjetivo(Model model, @ModelAttribute("objetivoNuevo") ObjetivoFuncional objetivoNuevo,
			BindingResult result, SessionStatus status) {
		try {
			objetivoValidator.validate(objetivoNuevo, result);
			if (result.hasErrors()) {
				if(objetivoNuevo.getCodigo()==null){
					model.addAttribute("tipoOperacion","Registrar");
					
				} else {
					model.addAttribute("tipoOperacion","Actualizar");
				}
				return "registroObjetivo";
				
			}
			if(objetivoNuevo.getCodigo()==null){
				if(objetivoNuevo.getTipoObjetivo().equals("General")){			
					 ObjetivoGeneral aux = new ObjetivoGeneral(objetivoNuevo.getDescripcion(),objetivoNuevo.getComentarios());
					 objetivoManager.guardarObjetivoGeneral(aux);
					 mailService.mandarAlerta(organizacionManager.getEmpleadoPorCodigo(4), aux);
				} else {
					ObjetivoFuncional aux = new ObjetivoFuncional(objetivoNuevo.getDescripcion(), ((ObjetivoFuncional) objetivoNuevo).getArea(), ((ObjetivoFuncional) objetivoNuevo).getObjetivoVinculado(), objetivoNuevo.getComentarios());
					objetivoManager.guardarObjetivoFuncional(aux);
					mailService.mandarAlerta(organizacionManager.getResponsableArea(aux.getArea()), aux);
					
				}
				model.addAttribute("mensajeConfirmacion", "PendRegistro");
			} else {				
				if(objetivoNuevo.getTipoObjetivo().equals("General")){
					objetivoNuevo.setFechaRegistro(objetivoManager.getObjetivoGeneralPorCodigo(objetivoNuevo.getCodigo()).getFechaRegistro());
					 ObjetivoGeneral aux = objetivoManager.getObjetivoGeneralPorCodigo(objetivoNuevo.getCodigo());
					 aux.setEstado("pendUpdate");
					 aux.setDescripcion(objetivoNuevo.getDescripcion());
					 aux.setComentarios(objetivoNuevo.getComentarios());
					objetivoManager.guardarObjetivoGeneral(aux);
					mailService.mandarAlerta(organizacionManager.getEmpleadoPorCodigo(4), aux);
				} else {
					ObjetivoFuncional aux = objetivoManager.getObjetivoFuncionalPorCodigo(objetivoNuevo.getCodigo());
					aux.setArea(objetivoNuevo.getArea());
					aux.setObjetivoVinculado(objetivoNuevo.getObjetivoVinculado());
					aux.setEstado("pendUpdate");
					aux.setDescripcion(objetivoNuevo.getDescripcion());
					aux.setComentarios(objetivoNuevo.getComentarios());
					aux.setFechaRegistro(objetivoManager.getObjetivoFuncionalPorCodigo(objetivoNuevo.getCodigo()).getFechaRegistro());
					objetivoManager.guardarObjetivoFuncional(aux);
					mailService.mandarAlerta(organizacionManager.getResponsableArea(aux.getArea()), aux);
				}
				model.addAttribute("mensajeConfirmacion", "PendActualizacion");
				
			}
			return "consultaObjetivos";
		} catch (Exception e) {
			return "registroObjetivo";
		}
	}
	
	@RequestMapping("/bajaObjetivo.htm")
	public String darBajaObjetivo(Model model,
			@RequestParam(value = "codigoObjetivo", required = false) Integer codigoObjetivo) {
		Objetivo objetivo = objetivoManager.getObjetivoPorCodigo(codigoObjetivo);		
		if(objetivo.getTipoObjetivo().equals("General")){
			ObjetivoGeneral aux = objetivoManager.getObjetivoGeneralPorCodigo(codigoObjetivo);
			aux.setEstado("pendBaja");
			objetivoManager.guardarObjetivoGeneral(aux);
		} else {
			ObjetivoFuncional aux = objetivoManager.getObjetivoFuncionalPorCodigo(codigoObjetivo);
			aux.setEstado("pendBaja");
			objetivoManager.guardarObjetivoFuncional(aux);
		}
		model.addAttribute("mensajeConfirmacion", "PendBaja");
		return "consultaObjetivos";
	}
	
	@ModelAttribute("listaAreas")
	public List<Area> listarAreas() {
		List<Area> listaAreas = organizacionManager.getListaAreas();
		listaAreas.remove(4);
		return listaAreas;
	}
	
	@ModelAttribute("visibilidadFuncional")
	public String visibilidadFuncional(@ModelAttribute("objetivoBusqueda") ObjetivoFuncional objetivoBusqueda) {
		 if(objetivoBusqueda.getTipoObjetivo()!= null && objetivoBusqueda.getTipoObjetivo().equals("Funcional")){
			 return "block";
		 } else {
			 return "none";
		 }
	}
	
	@ModelAttribute("listaObjetivosGenerales")
	public List<ObjetivoGeneral> listarObjetivosGenerales() {
		List<ObjetivoGeneral> listaObjetivos = objetivoManager.getListaObjetivosGenerales(null);
		return listaObjetivos;
	}

}
