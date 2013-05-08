package org.ge.dao.impl;

import java.util.List;

import org.ge.dao.PlanAccionDao;
import org.ge.model.PlanAccion;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.stereotype.Repository;

@Repository
public class PlanAccionDaoImpl implements PlanAccionDao {
	
	private HibernateTemplate hibernateTemplate;
	@SuppressWarnings("unused")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public PlanAccionDaoImpl(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
		this.jdbcTemplate = new JdbcTemplate(
				SessionFactoryUtils.getDataSource(sessionFactory));
	}
	
	@SuppressWarnings("unchecked")	
	public List<PlanAccion> getListaPlanesAccion(String estado) {
		StringBuffer query = new StringBuffer(" from PlanAccion ");
		if (estado != null) {
			query.append(" where upper(estado) = '")
					.append(estado.toUpperCase()).append("'");
		}
		List<PlanAccion> list = (List<PlanAccion>) hibernateTemplate.find(query.toString());
		return list;
	}
	
	public PlanAccion getPlanAccionPorCodigo(Integer codigoPlanAccion) {
		PlanAccion planAccion = (PlanAccion) hibernateTemplate.get(PlanAccion.class,codigoPlanAccion);
		return planAccion;
	}
	
	public void guardarPlanAccion(PlanAccion planAccion) {
		hibernateTemplate.saveOrUpdate(planAccion);
	}
	
}