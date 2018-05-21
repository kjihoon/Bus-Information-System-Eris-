package second.sample.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.common.logger.AbstractDAO;

@Repository("BusDAO")
public class BusDAO extends AbstractDAO{

		@SuppressWarnings("unchecked")
	    public List<Map<String, Object>> selectBusList(Map<String, Object> map) throws Exception{
			log.debug("in dao");
	        return (List<Map<String, Object>>) selectList("bus.selectBusList",map);
	    }
		
		
		@SuppressWarnings("unchecked")
	    public Map<String, Object> selectBusOne(Map<String, Object> map) throws Exception{
			log.debug("in dao");
	        return (Map<String, Object>) selectOne("bus.selectBusOne", map);
	    	
		}
		
		public void insertBus(Map<String, Object> map) throws Exception{
			log.debug("in dao");
			insert("bus.insertBus", map);	    	
		}
}
