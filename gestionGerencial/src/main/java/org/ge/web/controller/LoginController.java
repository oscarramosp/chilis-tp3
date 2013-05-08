package org.ge.web.controller;

import javax.servlet.http.HttpSession;

import org.ge.model.Area;
import org.ge.model.Empleado;
import org.ge.service.OrganizacionManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/inicio.htm")	
@Controller
public class LoginController {

	@Autowired
	private OrganizacionManager organizacionManager;
		
	@RequestMapping(method = RequestMethod.GET)
    public String inicio(HttpSession sesion){
       Empleado usuario = organizacionManager.getEmpleadoPorCodigo(1);
       sesion.setAttribute("usuario", usuario);
       
       return "inicio";
    }

}
