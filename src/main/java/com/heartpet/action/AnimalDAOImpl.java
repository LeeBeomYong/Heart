package com.heartpet.action;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.heartpet.model.AnimalDTO;
import com.heartpet.model.DogDTO;

@Repository
public class AnimalDAOImpl implements AnimalDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insert(AnimalDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(AnimalDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<AnimalDTO> list() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("list", sqlSession);
	}

	@Override
	public AnimalDTO content(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AnimalDTO> search() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
}