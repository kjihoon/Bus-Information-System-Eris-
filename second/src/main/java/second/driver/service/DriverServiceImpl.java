package second.driver.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import second.sample.dao.DriverDAO;

@Service("DriverService")
public class DriverServiceImpl implements DriverService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Autowired
    private DriverDAO driverDAO;
     
    @Override
    public List<Map<String, Object>> selectDriverList(Map<String, Object> map) throws Exception {
    	
    	
    	log.debug("in service");
        return driverDAO.selectDriverList(map);
    }
    
    @Override
    public Map<String, Object> selectDriverOne(Map<String, Object> map) throws Exception {
    	
    	
    	log.debug("in service");
        return driverDAO.selectDriverOne(map);
    }
 
}