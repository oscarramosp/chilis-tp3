package org.ge.dao.impl;

import java.util.List;

import org.ge.dao.IndicadorDao;
import org.ge.model.Indicador;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.stereotype.Repository;

@Repository
public class IndicadorDaoImpl implements IndicadorDao {
	
	private HibernateTemplate hibernateTemplate;
	@SuppressWarnings("unused")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public IndicadorDaoImpl(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
		this.jdbcTemplate = new JdbcTemplate(
				SessionFactoryUtils.getDataSource(sessionFactory));
	}
	
	@SuppressWarnings("unchecked")	
	public List<Indicador> getListaIndicadores(String estado) {
		StringBuffer query = new StringBuffer(" from Indicador ");
		if (estado != null) {
			query.append(" where upper(estado) = '")
					.append(estado.toUpperCase()).append("'");
		}
		List<Indicador> list = (List<Indicador>) hibernateTemplate.find(query.toString());
		return list;
	}
	
	public Indicador getIndicadorPorCodigo(Integer codigoIndicador) {
		Indicador indicador = (Indicador) hibernateTemplate.get(Indicador.class,codigoIndicador);
		return indicador;
	}
	
	public void guardarIndicador(Indicador indicador) {
		hibernateTemplate.saveOrUpdate(indicador);
	}
	
}