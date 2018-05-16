package second.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public interface AdminService {
	
	List<Map<String, Object>> selectAdminList(Map<String, Object> map) throws Exception;
	Map<String, Object> selectAdminOne(Map<String, Object> map) throws Exception;
	
	
}