package org.ge.dao.impl;

import java.util.List;

import org.ge.dao.EstrategiaDao;
import org.ge.model.Estrategia;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.stereotype.Repository;

@Repository
public class EstrategiaImpl implements EstrategiaDao {
	
	private HibernateTemplate hibernateTemplate;
	@SuppressWarnings("unused")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public EstrategiaImpl(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
		this.jdbcTemplate = new JdbcTemplate(
				SessionFactoryUtils.getDataSource(sessionFactory));
	}
	
	@SuppressWarnings("unchecked")	
	public List<Estrategia> getListaEstrategias(String estado) {
		StringBuffer query = new StringBuffer(" from Estrategia ");
		if (estado != null) {
			query.append(" where upper(estado) = '")
					.append(estado.toUpperCase()).append("'");
		}
		List<Estrategia> list = (List<Estrategia>) hibernateTemplate.find(query.toString());
		return list;
	}
	
	public Estrategia getEstrategiaPorCodigo(Integer codigoEstrategia) {
		Estrategia estrategia = (Estrategia) hibernateTemplate.get(Estrategia.class,codigoEstrategia);
		return estrategia;
	}
	
	public void guardarEstrategia(Estrategia estrategia) {
		hibernateTemplate.saveOrUpdate(estrategia);
	}
	
}