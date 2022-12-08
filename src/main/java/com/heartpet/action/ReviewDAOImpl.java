package com.heartpet.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.heartpet.model.ReviewDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<ReviewDTO> listReview(int startNo, int endNo, String field, String keyword) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("startNo", startNo);
    	map.put("endNo", endNo);
    	map.put("field", field);
    	map.put("keyword", keyword);
        return this.sqlSession.selectList("review_list", map);
	}

	@Override
	public int listReviewCount(String field, String keyword) {
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("field", field);
    	map.put("keyword", keyword);
		return this.sqlSession.selectOne("review_count", map);
	}

	@Override
	public int insertReview(ReviewDTO dto) {		
		return this.sqlSession.insert("review_insert", dto);
	}

	@Override
	public ReviewDTO contentReview(int review_no) {
		return this.sqlSession.selectOne("review_content", review_no);
	}

	@Override
	public int hitReview(int review_no) {		
		return this.sqlSession.selectOne("review_hit", review_no);
	}

	@Override
	public int updateReview(ReviewDTO dto) {
		return this.sqlSession.update("review_update", dto);
	}

	@Override
	public int deleteReview(int review_no) {
		return this.sqlSession.delete("review_delete", review_no);
	}

	@Override
	public List<Map<String, String>> animalReview(int[] animalNo) {
		return this.sqlSession.selectList("review_animal", animalNo);
	}


}