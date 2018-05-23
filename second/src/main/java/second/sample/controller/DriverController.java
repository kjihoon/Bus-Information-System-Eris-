package second.sample.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import second.bus.service.BusService;
import second.common.common.CommandMap;
import second.driver.service.DriverService;

@Controller
public class DriverController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private DriverService driverService;
	
	@Autowired
	private BusService busService;
	
	
	@RequestMapping("/driver/main.do")
	public String main(){
		return "driver/main";
	}
	
	//just login
		@RequestMapping("/driver/login.do")
		//@ResponseBody
		public String driverlogin(HttpSession session,Model model) throws Exception {
			Map adminInfo = (Map) session.getAttribute("driverInfo");
			String out = "driver/login";
			if (adminInfo!=null) { //login.do 재요청 왔을때
				CommandMap cmd = new CommandMap();
				out = "driver/main";
			}
			return out;
		}
		@RequestMapping("/driver/logout.do")
		public String driverlogout(HttpSession session) {
			session.invalidate();
			return "driver/login";
		}
		@RequestMapping(value="/driver/loginimp.do", method=RequestMethod.POST)
		//@ResponseBody
		public String adminloginimp(Model model,HttpSession session,CommandMap cmd) throws Exception {
			Map<String,Object> map = new HashMap<String,Object>();
			map= driverService.selectDriverOne(cmd.getMap());
			String result="driver/login"; 
			if (map==null) {
				model.addAttribute("login_result","Driver의 ID 또는 PWD가 잘못되었습니다.");
			}else {
				
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd-hh:mm");
				String currtime = sdf.format(cal.getTime());
				System.out.println(currtime);
				map.put("currtime", currtime);
				session.setAttribute("driverInfo", map); //login session 유지
				result = "driver/main";
			}		
			return result;
		}
	
}
