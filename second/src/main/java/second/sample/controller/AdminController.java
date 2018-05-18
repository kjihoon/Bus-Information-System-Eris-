package second.sample.controller;

import java.util.ArrayList;
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
	
	@RequestMapping("admin/allbus.do")
	public String allbus(CommandMap cmd,Model model) throws Exception {
		
		List<Map<String, Object>> map =busService.selectBusList(cmd.getMap());
		model.addAttribute("allbus",map);
		return "admin/main";
	}
	@RequestMapping("admin/main.do")
	public String adminmain(Model model,HttpSession session,CommandMap cmd) throws Exception {
		String out ="admin/login";
		if (session.getAttribute("adminInfo")!=null) {
			model.addAttribute("center","testtable");
			List<Map<String, Object>> allbus =busService.selectBusList(cmd.getMap());
			model.addAttribute("allbus",allbus);			
			out ="admin/main";
		}
		return out;
	}
	

	
	//real time location
	@RequestMapping("admin/location.do")
	@ResponseBody
	public String location(@RequestParam("busidx") String busidx) throws Exception {
		
		//random data for test
		JSONObject jo = new JSONObject();
		double lat = 37.4999072;
		double lng = 127.0373932;
		double rand = Math.random()*0.01;
		lat = lat-rand;
		lng = lng-rand;
		jo.put("lat", lat);
		jo.put("lng", lng);
		System.out.println(jo.toJSONString());
		
		//actual data
		JSONObject location = new JSONObject();
		CommandMap cmd = new CommandMap();
		cmd.put("busidx", busidx);
		Map map = busService.selectBusOne(cmd.getMap());
				
		
		location.put("lat", map.get("LAT"));
		location.put("lng", map.get("LON"));
		
		System.out.println(location.toJSONString());
		
		
		return jo.toJSONString();
	}
	

	@RequestMapping("admin/dash.do")
	public String admindash(Model model,@RequestParam("busidx") String busidx,HttpSession session) throws Exception {
		if (session.getAttribute("adminInfo")!=null) {
			model.addAttribute("center","testdash");
			session.setAttribute("busidx", busidx);
			
			CommandMap check = new CommandMap();
			check.put("busidx", busidx);
			Map map = busService.selectBusOne(check.getMap());
			
			
			
			model.addAttribute("busInfo",map);
			
		}
		return "admin/main";
	}
	@RequestMapping("admin/login.do")
	public String adminlogin(HttpSession session,Model model) {
		Map adminInfo = (Map) session.getAttribute("adminInfo");
		String out = "admin/login";
		if (adminInfo!=null) {
			out = "admin/main";
		}
		return out;
	}
	@RequestMapping("admin/logout.do")
	public String adminlogout(HttpSession session) {
		session.invalidate();
		return "admin/login";
	}
	
	@RequestMapping(value="admin/loginimp.do", method=RequestMethod.POST)
	public String adminloginimp(Model model,HttpSession session,CommandMap cmd) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map= adminService.selectAdminOne(cmd.getMap());
		String result="login"; 
		if (map==null) {
			map = new HashMap<String,Object>();
			map.put("result", "fail");
			model.addAttribute("result","Invalid ID or PWD, Please rewrite form");
		}else {
			map.put("result", "success");
			session.setAttribute("adminInfo", map);
			List<Map<String, Object>> allbus =busService.selectBusList(cmd.getMap());
			model.addAttribute("allbus",allbus);			
			result = "main";
		}		
		return "admin/"+result;
	}
	

	
	
	
	//Each bus msg
	@RequestMapping("admin/eachbus.do")
	public String data(Model model) {
/*		List<Map> list = new ArrayList<>();
		
		
		Map<String,String> map = new HashMap<>();
		map.put("name", "jihoon");
		map.put("message", "12");
		map.put("time", "11:24 AM");
		list.add(map);
		list.add(map);
		list.add(map);
		list.add(map);
		list.add(map);	
		model.addAttribute("list",list);
		model.addAttribute("msgsize", list.size());// new masseage size로 변경
		System.out.println(list.toString());*/
		
		
		
		model.addAttribute("center","testdash");
		return "admin/main";
	}
	
	
	
	
	//실시간 버스 온 습도 보내기 ajax
	@RequestMapping("admin/temperature.do")
	@ResponseBody
	public String realtime() {
		JSONObject jo = new JSONObject();
		List<Integer> list = new ArrayList<>();
		for (int i =0;i<13;i++) {
			list.add((int) (Math.random()*30)+1 );
		}
		jo.put("list", list);		
		return jo.toJSONString();
	}
	
	
	
	
	

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
