package org.ge.web.controller;

import org.ge.mail.MailService;
import org.ge.service.MapaEstrategicoManager;
import org.ge.service.OrganizacionManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class AdministrarMapasEstrategicos {

	@Autowired
	private MapaEstrategicoManager mapaEstrategicoManager;
	@Autowired
	private OrganizacionManager organizacionManager;
	@Autowired
	private MailService mailService;
}
