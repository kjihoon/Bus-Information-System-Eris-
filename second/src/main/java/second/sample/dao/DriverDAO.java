package second.sample.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.common.logger.AbstractDAO;

@Repository("DriverDAO")
public class DriverDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectDriverList(Map<String, Object> map) throws Exception{
		log.debug("in dao");
        return (List<Map<String, Object>>) selectList("driver.selectDriverList", map);
    }
	
	
	@SuppressWarnings("unchecked")
    public Map<String, Object> selectDriverOne(Map<String, Object> map) throws Exception{
		log.debug("in dao");
        return (Map<String, Object>) selectOne("driver.selectDriverOne", map);
    }
 
	
	
}
