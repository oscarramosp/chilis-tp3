package org.ge.model;

public class ObjetivoFuncional extends Objetivo implements java.io.Serializable {

	private static final long serialVersionUID = -5761195424101845110L;
	private ObjetivoFuncional objetivoEfecto;
	private Area area;
	private ObjetivoGeneral objetivoVinculado;
	
	public ObjetivoFuncional(){
	}
	
	public ObjetivoFuncional(String descripcion, Area area, ObjetivoGeneral objetivoVinculado, String comentarios) {
		super(descripcion, comentarios);
		this.area = area;
		this.tipoObjetivo = "Funcional";
		this.objetivoVinculado = objetivoVinculado;
	}

	public ObjetivoFuncional getObjetivoEfecto() {
		return objetivoEfecto;
	}

	public void setObjetivoEfecto(ObjetivoFuncional objetivoEfecto) {
		this.objetivoEfecto = objetivoEfecto;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public ObjetivoGeneral getObjetivoVinculado() {
		return objetivoVinculado;
	}

	public void setObjetivoVinculado(ObjetivoGeneral objetivoVinculado) {
		this.objetivoVinculado = objetivoVinculado;
	}


	
}
