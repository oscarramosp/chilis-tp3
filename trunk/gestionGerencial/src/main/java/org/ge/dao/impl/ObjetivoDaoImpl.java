package org.ge.dao.impl;

import java.util.List;

import org.ge.dao.ObjetivoDao;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.model.ObjetivoGeneral;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.stereotype.Repository;

@Repository
public class ObjetivoDaoImpl implements ObjetivoDao {
	
	private HibernateTemplate hibernateTemplate;
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public ObjetivoDaoImpl(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
		this.jdbcTemplate = new JdbcTemplate(
				SessionFactoryUtils.getDataSource(sessionFactory));
	}
	
	@SuppressWarnings("unchecked")	
	public List<ObjetivoFuncional> getListaObjetivosFuncionales(ObjetivoFuncional objetivoFuncional) {
		StringBuffer query = new StringBuffer(" from ObjetivoFuncional ");
		if (objetivoFuncional != null) {
			query.append(" where upper(estado) = '")
					.append(objetivoFuncional.getEstado().toUpperCase()).append("' and upper(area) = '")
					.append(objetivoFuncional.getArea().getCodigo()).append("'");
		}
		List<ObjetivoFuncional> list = (List<ObjetivoFuncional>) hibernateTemplate.find(query.toString());
		return list;
	}
	
	@SuppressWarnings("unchecked")	
	public List<ObjetivoGeneral> getListaObjetivosGenerales(ObjetivoGeneral objetivoGeneral) {
		StringBuffer query = new StringBuffer(" from ObjetivoGeneral ");
		if (objetivoGeneral != null) {
			query.append(" where upper(estado) = '")
					.append(objetivoGeneral.getEstado().toUpperCase()).append("'");
		}
		List<ObjetivoGeneral> list = (List<ObjetivoGeneral>) hibernateTemplate.find(query.toString());
		return list;
	}
	
	
	public Objetivo getObjetivoPorCodigo(Integer codigoObjetivo) {
		Objetivo objetivo = (Objetivo) hibernateTemplate.get(Objetivo.class,codigoObjetivo);
		return objetivo;
	}
	
	public ObjetivoGeneral getObjetivoGeneralPorCodigo(Integer codigoObjetivo) {
		ObjetivoGeneral objetivo = hibernateTemplate.get(ObjetivoGeneral.class,codigoObjetivo);
		return objetivo;
	}
	
	public ObjetivoFuncional getObjetivoFuncionalPorCodigo(Integer codigoObjetivo) {
		ObjetivoFuncional objetivo = hibernateTemplate.get(ObjetivoFuncional.class,codigoObjetivo);
		return objetivo;
	}
	
	public void guardarObjetivoGeneral(ObjetivoGeneral objetivo) {
		hibernateTemplate.saveOrUpdate(objetivo);
	}
	
	public void guardarObjetivoFuncional(ObjetivoFuncional objetivo) {
		hibernateTemplate.saveOrUpdate(objetivo);
	}
	
	public boolean isRepeatDescription(String descripcion, Integer codigoObjetivo) {
		StringBuffer query = new StringBuffer();
		query.append("select count(*) from objetivo ");
		query.append(" where descripcion_objetivo = '")
				.append(descripcion.trim().toUpperCase()).append("' ");
		if (codigoObjetivo != null) {
			query.append(" and codigo_objetivo != ").append(codigoObjetivo);
		}
		int count = jdbcTemplate.queryForInt(query.toString());
		if (count > 0) {
			return true;
		}
		System.out.println("no es repetido");
		return false;
	}
	
	@SuppressWarnings("unchecked")	
	public List<Objetivo> getListaObjetivos(String estado) {
		StringBuffer query = new StringBuffer(" from Objetivo ");
		if (estado != null) {
			query.append(" where upper(estado) = '")
					.append(estado.toUpperCase()).append("'");
		}
		List<Objetivo> list = (List<Objetivo>) hibernateTemplate.find(query.toString());
		return list;
	}

}