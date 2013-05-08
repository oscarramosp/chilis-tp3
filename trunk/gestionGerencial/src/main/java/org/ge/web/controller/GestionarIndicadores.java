package org.ge.web.controller;

import org.ge.mail.MailService;
import org.ge.service.IndicadorManager;
import org.ge.service.OrganizacionManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class GestionarIndicadores {
	
	@Autowired
	private IndicadorManager indicadorManager;
	@Autowired
	private OrganizacionManager organizacionManager;
	@Autowired
	private MailService mailService;
}
