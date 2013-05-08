package org.ge.dao.impl;

import java.util.List;

import org.ge.dao.OrganizacionDao;
import org.ge.model.Area;
import org.ge.model.Cargo;
import org.ge.model.Empleado;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DataAccessUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.stereotype.Repository;

@Repository
public class OrganizacionDaoImpl implements OrganizacionDao {
	
	private HibernateTemplate hibernateTemplate;
	@SuppressWarnings("unused")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public OrganizacionDaoImpl(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
		this.jdbcTemplate = new JdbcTemplate(
				SessionFactoryUtils.getDataSource(sessionFactory));
	}

	@SuppressWarnings("unchecked")
	public List<Area> getListaAreas() {
		List<Area> list = (List<Area>) hibernateTemplate.find(" from Area ");
		return list;
	}

	public Area getAreaPorCodigo(Integer codigoArea) {
		Area area = hibernateTemplate.get(Area.class,codigoArea);
		return area;
	}

	public Empleado getEmpleadoPorCodigo(Integer codigoEmpleado) {
		Empleado empleado = hibernateTemplate.get(Empleado.class,codigoEmpleado);
		hibernateTemplate.initialize(empleado);
		return empleado;
	}

	public Cargo getCargoPorCodigo(Integer codigoCargo) {
		Cargo cargo = hibernateTemplate.get(Cargo.class,codigoCargo);
		return cargo;
	}
	
	@SuppressWarnings("unchecked")
	public Cargo getCargoPorDescripcion(String descripcion) {
	     DetachedCriteria criteria = DetachedCriteria.forClass(Cargo.class);     
	     criteria.add(Restrictions.eq("descripcion", descripcion));     
	     return (Cargo) DataAccessUtils.uniqueResult(hibernateTemplate.findByCriteria(criteria));
	}
	
	@SuppressWarnings("unchecked")
	public Empleado getResponsableArea(Area area){
		DetachedCriteria criteria = DetachedCriteria.forClass(Empleado.class);     
	     criteria.add(Restrictions.eq("area.codigo", area.getCodigo()));
	     criteria.add(Restrictions.eq("cargo.codigo", 1));
	     return (Empleado) DataAccessUtils.uniqueResult(hibernateTemplate.findByCriteria(criteria));
	}
	
	
}