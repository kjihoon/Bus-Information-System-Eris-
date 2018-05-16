package second.sample.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import second.common.common.CommandMap;
import second.driver.service.DriverService;

@Controller
public class DriverController {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private DriverService driverService;
	
	@RequestMapping("driver/main.do")
	public String main() throws Exception {
		return "driver/drivermain";
	}
	
	@RequestMapping(value = "driver/login.do",  method=RequestMethod.GET)
	public String login(CommandMap cmd,Model model) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map= driverService.selectDriverOne(cmd.getMap());
		JSONObject jo = new JSONObject();
		if (map==null) {
			map = new HashMap<String,Object>();
			map.put("result", "undifined Id or invalid pwd");
		}else {
			map.put("result", "loginSucess");			
		}
		jo.putAll(map);		
		model.addAttribute("driverInfo",map);
		
		return "/driver/driverboard";
		
	}
	
	@RequestMapping("driver/driverboard.do")
	public String dirverboard() {
		return  "driverboard";
	}
}
