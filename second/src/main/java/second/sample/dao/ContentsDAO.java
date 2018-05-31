package second.sample.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.common.logger.AbstractDAO;

@Repository("ContentsDAO")
public class ContentsDAO extends AbstractDAO{

		@SuppressWarnings("unchecked")
	    public List<Map<String, Object>> selectContentsList(Map<String, Object> map) throws Exception{
			log.debug("in dao");
	        return (List<Map<String, Object>>) selectList("contents.selectContentsList", map);
	    }
		
		
		@SuppressWarnings("unchecked")
	    public Map<String, Object> selectContentsOne(Map<String, Object> map) throws Exception{
			log.debug("in dao");
	        return (Map<String, Object>) selectOne("contents.selectContentsOne", map);
	    	
	}
}
