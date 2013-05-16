package org.ge.web.controller;

import org.ge.service.EstrategiaManager;
import org.ge.service.OrganizacionManager;
import org.ge.service.mail.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class DefinirEstrategias {
	
	@Autowired
	private EstrategiaManager estrategiaManager;
	@Autowired
	private OrganizacionManager organizacionManager;
	@Autowired
	private MailService mailService;
}