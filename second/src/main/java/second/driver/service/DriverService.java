package second.driver.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public interface DriverService {
	
	List<Map<String, Object>> selectDriverList(Map<String, Object> map) throws Exception;
	Map<String, Object> selectDriverOne(Map<String, Object> map) throws Exception;
	
	
}