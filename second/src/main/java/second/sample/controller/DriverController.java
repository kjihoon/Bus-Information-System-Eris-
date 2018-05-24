package second.sample.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import second.bus.service.BusService;
import second.common.common.CommandMap;
import second.driver.service.DriverService;

@Controller
public class DriverController {
	
	@Autowired
	private DriverService driverService;
	
	@Autowired
	private BusService busService;
	
		@RequestMapping(value="/driver/login.do", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public String adminloginimp(Model model,HttpSession session,CommandMap cmd) throws Exception {
			Map<String,Object> map = new HashMap<String,Object>();
			map= driverService.selectDriverOne(cmd.getMap());
			JSONObject result= new JSONObject();
			if (map==null) {
				result.put("driverinfo", map);
				result.put("result_login","success");
			}else {
				result.put("result_login","success");
			}		
			return result.toJSONString();
		}
		
		/*http://localhost/first/driver/driverinfo.do?id=kwak&pwd=123*/		
		@RequestMapping(value="/driver/driverinfo.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String driverinfo(CommandMap cmd,Model model,HttpSession session) throws Exception {
			Map<String,Object> map= driverService.selectDriverOne(cmd.getMap());
			session.setAttribute("driverInfo", map);
			return "driver/main";
		}
	
}
