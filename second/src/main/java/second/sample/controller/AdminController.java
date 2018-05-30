package second.sample.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import second.admin.service.AdminService;
import second.bus.service.BusService;
import second.common.common.CommandMap;
import second.driver.service.DriverService;

@Controller
public class AdminController {

	Logger log = Logger.getLogger(this.getClass());
	
	
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BusService busService;
	
	@Autowired
	private DriverService driverService;
	

	private static Map <String,List<String>> map = new HashMap<>();
	
	// list 0 - lat
	// list 1 - lon
	// list 2 - temp
	// list 3 - humid
	// list 4 - distance
	// list 5 - xx
	//최초 요청시 초기화
	private void initData(String busidx) {
		System.out.println(busidx+"운행 시작");
		List<String> list = new ArrayList<>();
		list.add("37");list.add("127");
		list.add("20");list.add("30");
		list.add("0");list.add("0");
		list.add("0");list.add("0");
		list.add("0");list.add("0");
		list.add("0");list.add("0");
		
		map.put(busidx, list);
	}
	//http://localhost/first/admin/driverlogin.do?id=kwak&pwd=123&busidx=5
	@RequestMapping("/admin/driverlogin.do")
	@ResponseBody
	public String driverlogin(CommandMap cmd,HttpSession session) throws Exception {
		//get BUSIDX ID PWD
		System.out.println(cmd.getMap().toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map= driverService.selectDriverOne(cmd.getMap());
		JSONObject result= new JSONObject();
		if (map==null) {
			result.put("result_login","fail");
		}else {
			//result.put("driverinfo", map);
			initData((String)cmd.get("busidx"));
			result.put("result_login","success");
			cmd.put("service", "1");
			cmd.put("driveridx",map.get("DRIVERIDX"));			
			
			busService.updateBus(cmd.getMap());
		}		
		return cmd.toString()+map.toString();		
	}
	
	
	@RequestMapping("/admin/driverlogout.do")
	@ResponseBody
	public String driverlogout(@RequestParam("busidx")String busidx) throws Exception{
		CommandMap cmd = new CommandMap();
		cmd.put("busidx", busidx);
		cmd.put("driveridx","0");
		cmd.put("service", "0");
		busService.updateBus(cmd.getMap());
		map.remove(busidx);
		return map.toString();
	}
	
	
	
	
	
	@RequestMapping(value="/admin/retemp.do", method=RequestMethod.GET)
	@ResponseBody
	public String retemp(@RequestParam("busidx")String busidx,@RequestParam("temp")String temp,@RequestParam("humid")String humid) {
		System.out.println("busidx: "+busidx+" temp: "+temp+" humid: "+humid);
		map.get(busidx).set(2,temp);
		map.get(busidx).set(3,humid);
		return "success";
	}
	@RequestMapping(value= "/admin/relocation.do", method=RequestMethod.POST)
	@ResponseBody
	public String relocation(@RequestParam("busidx")String busidx,@RequestParam("lat")String lat,@RequestParam("lon")String lon) {
		System.out.println("busidx: "+busidx+" lat: "+lat+" lon: "+lon);
		
		map.get(busidx).set(0,lat);
		map.get(busidx).set(1,lon);
		return "success";
	}
	
	@RequestMapping(value="/admin/recandata.do", method=RequestMethod.GET)
	@ResponseBody
	public String recandata(@RequestParam("busidx")String busidx,@RequestParam("distance")String distance) {
		map.get(busidx).set(4,distance);
		return "success";
	}
	@RequestMapping("/admin/candata.do")
	@ResponseBody
	public String candata(@RequestParam("busidx") String busidx) {
		JSONObject jo = new JSONObject();
		return "admin/temp";
		
	}
	//real-time location
		@RequestMapping("/admin/location.do")
		@ResponseBody
		public String location(@RequestParam("busidx") String busidx) throws Exception {
			
			//actual data
			JSONObject location = new JSONObject();
			
			location.put("lat",map.get(busidx).get(0));
			location.put("lng", map.get(busidx).get(1));
			System.out.println("BUS"+busidx+location.toJSONString());
			//location 보내야함		
			
			return location.toJSONString();
		}
		//real-time humid & temperature
		@RequestMapping("/admin/temperature.do")
		@ResponseBody
		public String realtime(@RequestParam("busidx") String busidx) throws Exception {
			
			//actual
			JSONObject temphumid = new JSONObject();			
			temphumid.put("humid",map.get(busidx).get(2));
			temphumid.put("temp", map.get(busidx).get(3));
			System.out.println(temphumid.toJSONString());
			
			
			
			return temphumid.toJSONString();
		}
	
	//after login.., directly view
	@RequestMapping("/admin/allbus.do")
	public String allbus(CommandMap cmd,Model model) throws Exception {
		List<Map<String, Object>> allbus =busService.selectBusList(cmd.getMap());
		model.addAttribute("allbus",allbus);
		return "admin/main";
	}
	//after login.. click main view
	@RequestMapping("/admin/main.do")
	public String adminmain(Model model,HttpSession session,CommandMap cmd) throws Exception {
		log.debug("메인을 누르셨습니다.");
		session.removeAttribute("busInfo");
		List<Map<String, Object>> allbus =busService.selectBusList(cmd.getMap());
		model.addAttribute("allbus",allbus);			

		return "admin/main";
	}
	//move each bus information
	@RequestMapping("/admin/dash.do")
	public String admindash(Model model,@RequestParam("busidx") String busidx,HttpSession session) throws Exception {
		
		model.addAttribute("center","testdash");			
		session.setAttribute("busidx", busidx);		
		CommandMap check = new CommandMap();		
		check.put("busidx", busidx);			
		Map map = busService.selectBusOne(check.getMap());
		session.setAttribute("busInfo",map);	
		return "admin/main";
	}
	
	//just login
	@RequestMapping("/admin/login.do")
	public String adminlogin(HttpSession session,Model model,CommandMap cmd2) throws Exception {
		System.out.println(cmd2.toString());
		Map adminInfo = (Map) session.getAttribute("adminInfo");
		String out = "admin/login";
		if (adminInfo!=null) {
			CommandMap cmd = new CommandMap();
			List<Map<String, Object>> allbus =busService.selectBusList(cmd.getMap());
			model.addAttribute("allbus",allbus);
			out = "admin/main";
		}
		return out;
	}
	@RequestMapping("/admin/logout.do")
	public String adminlogout(HttpSession session) {
		session.invalidate();
		return "admin/login";
	}
	@RequestMapping(value="/admin/loginimp.do", method=RequestMethod.POST)
	public String adminloginimp(Model model,HttpSession session,CommandMap cmd) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map= adminService.selectAdminOne(cmd.getMap());
		String result="admin/login"; 
		if (map==null) {
			model.addAttribute("result","관리자의 ID 또는 PWD가 잘못되었습니다.");
		}else {
			session.setAttribute("adminInfo", map);
			System.out.println(cmd.getMap());
			List<Map<String, Object>> allbus =busService.selectBusList(cmd.getMap());
			model.addAttribute("allbus",allbus);			
			result = "admin/main";
		}		
		return result;
	}
	
	//Each bus msg
	@RequestMapping("/admin/eachbus.do")
	public String data(Model model) {

		model.addAttribute("center","testdash");
		return "admin/main";
	}
	//Driver 운행 시작
	@RequestMapping("admin/buson.do")
	@ResponseBody
	public String buson(CommandMap cmd) throws Exception {
		cmd.put("DRIVERIDX","1");
		cmd.put("SERVICE","1");
		cmd.put("BUSIDX","1");
		busService.updateBus(cmd.getMap());
		return "busOn";
	}
	
	//Driver 운행 종료
	@RequestMapping("admin/busoff.do")
	@ResponseBody
	public String busoff(CommandMap cmd) throws Exception {
		cmd.put("DRIVERIDX","0");
		cmd.put("BUSIDX","1");
		cmd.put("SERVICE","0");
		busService.updateBus(cmd.getMap());
		return "busOFF";
	}
	@RequestMapping("admin/testmap.do")
	public String adminforgot() {
		return "admin/testmap";
	}

	


}
