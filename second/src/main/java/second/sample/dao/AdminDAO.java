package second.sample.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.common.logger.AbstractDAO;

@Repository("AdminDAO")
public class AdminDAO extends AbstractDAO{

		@SuppressWarnings("unchecked")
	    public List<Map<String, Object>> selectAdminList(Map<String, Object> map) throws Exception{
			log.debug("in dao");
	        return (List<Map<String, Object>>) selectList("admin.selectAdminList", map);
	    }
		
		
		@SuppressWarnings("unchecked")
	    public Map<String, Object> selectAdminOne(Map<String, Object> map) throws Exception{
			log.debug("in dao");
	        return (Map<String, Object>) selectOne("admin.selectAdminOne", map);
	    	
	}
}
