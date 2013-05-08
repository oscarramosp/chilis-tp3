package org.ge.mail;

import java.io.File;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.ge.model.ElementoMail;
import org.ge.model.Empleado;
import org.ge.model.Estrategia;
import org.ge.model.Indicador;
import org.ge.model.MapaEstrategico;
import org.ge.model.Objetivo;
import org.ge.model.PlanAccion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	private JavaMailSenderImpl mailSender;

	public void mandarAlerta(Empleado responsableArea, ElementoMail object) {

		logger.info("Emviando email.");

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			helper.setFrom("mmerinovega@gmail.com");
			helper.setTo(responsableArea.getEmail());
			helper.setSubject(armarTema(object));
			helper.setText(armarMensaje(object), true);
			File file = new File(
					"C:\\Users\\Warlux\\Documents\\workspace-sts-3.1.0.RELEASE\\gestionGerencial\\src\\main\\webapp\\resources\\images\\logo.jpg");
			helper.addAttachment("Logo", file);
			mailSender.send(message);
		} catch (MessagingException mx) {
			logger.error("No se ha podido enviar el email.");
			mx.printStackTrace();
		}
	}

	private String armarTema(ElementoMail object) {
		String operacion = detectarOperacion(object);
		String elemento = detectarElemento(object);
		return elemento + " " + operacion;
	}

	private String detectarOperacion(ElementoMail object) {
		String estado = object.getEstado();
		if (estado.equals("pendAprobacion")) {
			estado = "pendiente de aprobación de registro";
		} else {
			if (estado.equals("pendUpdate")) {
				estado = "pendiente de aprobación de actualización";
			} else {
				if (estado.equals("pendBaja")) {
					estado = "pendiente de aprobación de baja";
				}
			}
		}
		return estado;
	}

	private String detectarElemento(ElementoMail object) {
		String elemento = "";
		String operacion = "";
		if (object instanceof Objetivo) {
			elemento = "Objetivo Estratégico";
		} else {
			if (object instanceof Estrategia) {
				elemento = "Iniciativa Estratégica";
			} else {
				if (object instanceof PlanAccion) {
					elemento = "Plan de Acción";
				} else {
					if (object instanceof Indicador) {
						elemento = "Indicador";
					} else {
						if (object instanceof MapaEstrategico) {
							elemento = "Mapa Estratégico";
						}
					}
				}
			}
		}
		return (elemento + " " + operacion);
	}

	private String armarMensaje(ElementoMail object) {
		StringBuffer mensaje = new StringBuffer("Se comunica que existe un ");
		mensaje.append(detectarElemento(object)).append(" ");
		mensaje.append(detectarOperacion(object)).append(".");
		mensaje.append("<br>--------------------------------------------------<br>");
		mensaje.append("Descripcion: ").append(object.getDescripcion());
		mensaje.append("<br>--------------------------------------------------<br>");
		mensaje.append("Comentarios: ").append(object.getComentarios());
		mensaje.append("<br>--------------------------------------------------<br>");
		mensaje.append("Favor regularizar aprobación");
		return mensaje.toString();

	}

	public void setMailSender(JavaMailSenderImpl mailSender) {
		this.mailSender = mailSender;
	}
}
