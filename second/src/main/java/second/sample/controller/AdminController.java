package second.sample.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
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

@Controller
public class AdminController {

	Logger log = Logger.getLogger(this.getClass());
	
	
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BusService busService;
	
	// list 0 - lat
	// list 1 - lon
	// list 2~ 14 - temp
	// list 15~27 - humid 
	private static Map <String,List<String>> map = new HashMap<>();
	
	
	//최초 요청시 초기화
	private void initData(String busidx) {
		List<String> list = new ArrayList<>();
		list.add("37");list.add("127");
		for (int i =2;i<=27;i++) {
			if (i<=14) {
				list.add("20");
			}else {
				list.add("30");
			}
		}
		map.put(busidx, list);
	}
	
	@RequestMapping("/admin/relocation.do")
	public void relocation(@RequestParam("busidx")String busidx,@RequestParam("lat")String lat,@RequestParam("lon")String lon) {
		map.get(busidx).set(0,lat);
		map.get(busidx).set(1,lon);
	}
	
	//real-time location
		@RequestMapping("/admin/location.do")
		@ResponseBody
		public String location(@RequestParam("busidx") String busidx) throws Exception {
			
			
			
			//random data for test
			JSONObject jo = new JSONObject();
			double lat = 37.4999072;;
			double lng = 127.0373932;
			double rand = Math.random()*0.01;
			lat = lat-rand;
			lng = lng-rand;
			
			jo.put("lat", lat);
			jo.put("lng", lng);
			System.out.println(jo.toJSONString());
			
			//actual data
			JSONObject location = new JSONObject();
			
			location.put("lat",map.get(busidx).get(0));
			location.put("lng", map.get(busidx).get(1));
			System.out.println(location.toJSONString());
			//location 보내야함		
			
			return location.toJSONString();
		}
		//real-time humid & temperature
		@RequestMapping("/admin/temperature.do")
		@ResponseBody
		public String realtime(@RequestParam("busidx") String busidx) throws Exception {
			
			//radom test
			JSONObject jo = new JSONObject();
			List<Integer> list = new ArrayList<>();
			for (int i =0;i<13;i++) {
				list.add((int) (Math.random()*30)+1 );
			}
			jo.put("list", list);
			System.out.println(jo.toJSONString());
			
			//actual value
			JSONObject tempjo = new JSONObject();
			CommandMap cmd = new CommandMap();
			cmd.put("BUSIDX", busidx);
			Map map = busService.selectBusOne(cmd.getMap());
			//tempjo.put("temp", value)
			
			
			return jo.toJSONString();
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
			
		session.removeAttribute("busInfo");
		List<Map<String, Object>> allbus =busService.selectBusList(cmd.getMap());
		model.addAttribute("allbus",allbus);			

		return "admin/main";
	}
	

	
	
	
	//move each bus information
	@RequestMapping("/admin/dash.do")
	public String admindash(Model model,@RequestParam("busidx") String busidx,HttpSession session) throws Exception {
		initData(busidx);
		model.addAttribute("center","testdash");			
		session.setAttribute("busidx", busidx);		
		CommandMap check = new CommandMap();		
		check.put("BUSIDX", busidx);			
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
			log.debug("==="+cmd.get("id")+"login fail===");
		}else {
			log.debug("==="+cmd.get("id")+"login Success===");
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
		cmd.put("SERVICE","1");
		busService.updateBus(cmd.getMap());
		return "busOn";
	}
	
	//Driver 운행 종료
	@RequestMapping("admin/busoff.do")
	@ResponseBody
	public String busoff(CommandMap cmd) throws Exception {
		cmd.put("SERVICE","0");
		cmd.put("LAT", "0");
		cmd.put("LON", "0");
		cmd.put("TEMP", "0");
		cmd.put("HUMID", "0");
		cmd.put("DRIVERIDX", "0");
		busService.updateBus(cmd.getMap());
		return "busOFF";
	}
	
	@RequestMapping("admin/busrealtime.do")
	@ResponseBody
	public String busrealtime(CommandMap cmd) throws Exception {
		cmd.put("realtime","on");
		busService.updateBus(cmd.getMap());
		return "busOn";
	}
	//////////////////////////////////////////////////////////////////////////////////////
	
	
	

	@RequestMapping("admin/testmap.do")
	public String adminforgot() {
		return "admin/testmap";
	}
	
	@RequestMapping("admin/tables.do")
	public String admintables() {
		return "admin/tables";
	}
	@RequestMapping("admin/register.do")
	public String adminregister() {
		return "admin/register";
	}
	
	@RequestMapping("admin/blank.do")
	public String adminblank() {
		return "admin/blank";
	}
	@RequestMapping("admin/charts.do")
	public String admincharts() {
		return "admin/charts";
	}
	@RequestMapping("admin/cards.do")
	public String admincards() {
		return "admin/cards";
	}
	// 내림차순
	class Descending implements Comparator<Integer> {	 
	    @Override
	    public int compare(Integer o1, Integer o2) {
	        return o2.compareTo(o1);
	    }	 
	}
	 
	// 오름차순
	class Ascending implements Comparator<Integer> {	 
	    @Override
	    public int compare(Integer o1, Integer o2) {
	        return o1.compareTo(o2);
	    }	 
	}
	/////////////////////////////////bus
	


}
