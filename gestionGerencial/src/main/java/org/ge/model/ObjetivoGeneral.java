package org.ge.model;


public class ObjetivoGeneral extends Objetivo implements java.io.Serializable {

	private static final long serialVersionUID = 6591024962560866534L;
	private ObjetivoGeneral objetivoEfecto;
	
	public ObjetivoGeneral(){
	}
	
	public ObjetivoGeneral(String descripcion, String comentarios) {
		super(descripcion, comentarios);
		this.tipoObjetivo = "General";
	}

	public ObjetivoGeneral getObjetivoEfecto() {
		return objetivoEfecto;
	}

	public void setObjetivoEfecto(ObjetivoGeneral objetivoEfecto) {
		this.objetivoEfecto = objetivoEfecto;
	}
	
}
