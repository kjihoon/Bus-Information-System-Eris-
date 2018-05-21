package second.bus.service;

import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import second.sample.dao.BusDAO;
 
@Service("BusService")
public class BusServiceImpl implements BusService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Autowired
    private BusDAO BusDAO;
     
    @Override
    public List<Map<String, Object>> selectBusList(Map<String, Object> map) throws Exception {    	
       	log.debug("in service");
        return BusDAO.selectBusList(map);
    }
    
    @Override
    public Map<String, Object> selectBusOne(Map<String, Object> map) throws Exception {
    	log.debug("in service");
        return BusDAO.selectBusOne(map);
    }

	@Override
	public void insertBus(Map<String, Object> map) throws Exception {
		log.debug("in service");
		BusDAO.insertBus(map);
	}
	@Override
	public void updateBus(Map<String, Object> map) throws Exception{
		log.debug("in service");
		BusDAO.updateBus(map);
	}

 
}