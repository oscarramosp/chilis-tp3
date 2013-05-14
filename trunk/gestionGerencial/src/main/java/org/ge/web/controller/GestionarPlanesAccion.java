package org.ge.web.controller;

import org.ge.service.OrganizacionManager;
import org.ge.service.PlanAccionManager;
import org.ge.service.mail.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class GestionarPlanesAccion {
	
	@Autowired
	private PlanAccionManager planAccionManager;
	@Autowired
	private OrganizacionManager organizacionManager;
	@Autowired
	private MailService mailService;
}
