package org.ge.dao.impl;

import java.util.List;

import org.ge.dao.MapaEstrategicoDao;
import org.ge.model.MapaEstrategico;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.stereotype.Repository;

@Repository
public class MapaEstrategicoImpl implements MapaEstrategicoDao {
	
	private HibernateTemplate hibernateTemplate;
	@SuppressWarnings("unused")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public MapaEstrategicoImpl(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
		this.jdbcTemplate = new JdbcTemplate(
				SessionFactoryUtils.getDataSource(sessionFactory));
	}
	
	@SuppressWarnings("unchecked")	
	public List<MapaEstrategico> getListaMapasEstrategicos(String estado) {
		StringBuffer query = new StringBuffer(" from MapaEstrategico ");
		if (estado != null) {
			query.append(" where upper(estado) = '")
					.append(estado.toUpperCase()).append("'");
		}
		List<MapaEstrategico> list = (List<MapaEstrategico>) hibernateTemplate.find(query.toString());
		return list;
	}
	
	public MapaEstrategico getMapaEstrategicoPorCodigo(Integer codigoMapaEstrategico) {
		MapaEstrategico mapaEstrategico = (MapaEstrategico) hibernateTemplate.get(MapaEstrategico.class,codigoMapaEstrategico);
		return mapaEstrategico;
	}
	
	public void guardarMapaEstrategico(MapaEstrategico mapaEstrategico) {
		hibernateTemplate.saveOrUpdate(mapaEstrategico);
	}
	
}