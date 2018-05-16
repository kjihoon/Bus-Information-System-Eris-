package second.admin.service;

import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import second.sample.dao.AdminDAO;
 
@Service("AdminService")
public class AdminServiceImpl implements AdminService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Autowired
    private AdminDAO adminDAO;
     
    @Override
    public List<Map<String, Object>> selectAdminList(Map<String, Object> map) throws Exception {    	
       	log.debug("in service");
        return adminDAO.selectAdminList(map);
    }
    
    @Override
    public Map<String, Object> selectAdminOne(Map<String, Object> map) throws Exception {
    	log.debug("in service");
        return adminDAO.selectAdminOne(map);
    }
 
}