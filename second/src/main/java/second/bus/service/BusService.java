package second.bus.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public interface BusService {
	
	List<Map<String, Object>> selectBusList(Map<String, Object> map) throws Exception;
	Map<String, Object> selectBusOne(Map<String, Object> map) throws Exception;
	void insertBus(Map<String, Object> map) throws Exception;
	
}