/**
 * 
 */
package egovframework.example.country.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.common.Criteria;
import egovframework.example.country.service.CountryVO;

/**
 * @author user
 *
 */
@Mapper
public interface CountryMapper {
	public List<?> selectCountryList(Criteria criteria); // 전체조회
	public int selectCountryListTotCnt(Criteria criteria); // 총 개수 구하기
	public int insert(CountryVO countryVO); // insert
	public CountryVO selectCountry (String uuid); //상세조회
	public int delete(CountryVO countryVO); // delete 메소드
	public int update(CountryVO countryVO); // update 메소드
	public List<CountryVO> selectCountryCategories(); //국가별
	public List<CountryVO> selectIngredientCategories(); //재료별
	public List<CountryVO> selectSituationCategories(); // 상황별
    public int updateLikeCount(@Param("uuid") String uuid, @Param("likeCount") int likeCount);  // 좋아요 수
    public String getCategoryNameById(int categoryId); //카테고리 id조회
}
