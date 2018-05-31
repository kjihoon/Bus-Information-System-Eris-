package second.contents.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import second.sample.dao.ContentsDAO;

@Service("ContentsService")
public class ContentsServiceImpl implements ContentsService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Autowired
    private ContentsDAO contentsDAO;
     
    @Override
    public List<Map<String, Object>> selectContentsList(Map<String, Object> map) throws Exception {
    	log.debug("in service");
        return contentsDAO.selectContentsList(map);
    }
    
    @Override
    public Map<String, Object> selectContentsOne(Map<String, Object> map) throws Exception {
    	log.debug("in service");
        return contentsDAO.selectContentsOne(map);
    }
 
}