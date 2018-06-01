package second.sample.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Qualifier;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
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

		
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BusService busService;
	
	@Autowired
	private DriverService driverService;
	
	//Logger log = Logger.getLogger("rollingFile");
    //private Logger log = Logger.getLogger("rolling5");

	private static Map <String,List<String>> map = new HashMap<>();
	private static Map <String,Logger> logmap = new HashMap<>();
	// list 0 - lat
	// list 1 - lon
	// list 2 - temp
	// list 3 - humid
	// list 4~10 - candata
	//최초 요청시 초기화
	private void initData(String busidx) {
		System.out.println(busidx+"운행 시작");
		List<String> list = new ArrayList<>();
		list.add("37");list.add("127");
		list.add("20");list.add("30");
		list.add("0");list.add("0");
		list.add("0");list.add("0");
		list.add("0");list.add("0");
		list.add("0");
		
		map.put(busidx, list);
		logmap.put("rolling"+busidx, Logger.getLogger("rolling"+busidx));
	}
	//http://localhost/first/admin/driverlogin.do?id=kwak&pwd=123&busidx=5
	@RequestMapping(value="/admin/driverlogin.do" ,method=RequestMethod.POST)
	@ResponseBody
	public String driverlogin(CommandMap cmd,HttpSession session) throws Exception {
		//get BUSIDX ID PWD
		System.out.println(cmd.getMap().toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map= driverService.selectDriverOne(cmd.getMap());
		JSONObject result= new JSONObject();
		JSONArray jr= new JSONArray();
		if (map==null) {
			result.put("result_login","fail");
			jr.add(result);
		}else {
			initData((String)cmd.get("busidx"));
			result.put("result_login","success");
			result.putAll(map);
			result.remove("D_REGISTERDATE");
			jr.add(result);
			cmd.put("service", "1");
			cmd.put("driveridx",map.get("DRIVERIDX"));			
			busService.updateBus(cmd.getMap());
			Map businfo =busService.selectBusOne(cmd.getMap());
			JSONObject busjson = new JSONObject();
			busjson.putAll(businfo);
			busjson.remove("REGIDATE");
			jr.add(busjson);
		}		
		return jr.toJSONString();		
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
		if (map.get(busidx)!=null) {
			map.get(busidx).set(2,temp);
			map.get(busidx).set(3,humid);
			logmap.get("rolling"+busidx).debug("temp,"+busidx+","+temp+"/"+humid);
		}else {
			System.out.println("드라이버 로그인 필요");
		}
		
		return "success";
	}
	@RequestMapping(value= "/admin/relocation.do", method=RequestMethod.POST)
	@ResponseBody
	public String relocation(@RequestParam("busidx")String busidx,@RequestParam("lat")String lat,@RequestParam("lon")String lon) {
		System.out.println("busidx: "+busidx+" lat: "+lat+" lon: "+lon);
		if (map.get(busidx)!=null) {
			
			map.get(busidx).set(0,lat);
			map.get(busidx).set(1,lon);
			logmap.get("rolling"+busidx).debug("location,"+busidx+","+lat+"/"+lon);
		}else {
			System.out.println("드라이버 로그인 필요");
		}
		return "success";
	}
	
	@RequestMapping(value="/admin/recandata.do", method=RequestMethod.GET)
	@ResponseBody
	public String recandata(CommandMap cmd) {
		
		System.out.println(cmd.getMap().toString());
		String engineLoadValue = (String) cmd.get("engineLoadValue");
		String engineCoolantTemperature = (String) cmd.get("engineCoolantTemperature");
		String enginRPM = (String) cmd.get("enginRPM");
		String MAF = (String) cmd.get("MAF");
		String throttlePosition = (String) cmd.get("throttlePosition");
		String busidx = (String) cmd.get("busidx");
		map.get(busidx).set(4, engineLoadValue);
		map.get(busidx).set(5, engineCoolantTemperature);
		map.get(busidx).set(6, enginRPM);
		map.get(busidx).set(8, MAF);
		map.get(busidx).set(9, throttlePosition);
		logmap.get("rolling"+busidx).debug("candata,"+busidx+","+engineLoadValue+"/"+engineCoolantTemperature+"/"+enginRPM+"/"+MAF+"/"+throttlePosition);
		return cmd.getMap().toString();		
	}
	
	@RequestMapping(value="/admin/respeed.do", method=RequestMethod.GET)
	@ResponseBody
	public String respeed(CommandMap cmd) {
		map.get(cmd.get("busidx")).set(10, (String) cmd.get("vehiclespeed"));
		System.out.println(cmd.getMap().toString());
		return "success";
	}
	
	/*@RequestMapping(value="/admin/recandata.do", method=RequestMethod.POST)
	@ResponseBody
	public String recandata(String engineLoadValue,String engineCoolantTemperature,String enginRPM,String vehicleSpeed,String MAF,String throttlePosition,String busidx ) {
		
		System.out.println(cmd.getMap().toString());
		String engineLoadValue = (String) cmd.get("engineLoadValue");
		String engineCoolantTemperature = (String) cmd.get("engineCoolantTemperature");
		String enginRPM = (String) cmd.get("enginRPM");
		String vehicleSpeed = (String) cmd.get("vehicleSpeed");
		String MAF = (String) cmd.get("MAF");
		String throttlePosition = (String) cmd.get("throttlePosition");
		String busidx = (String) cmd.get("busidx");
		map.get(busidx).set(4, engineLoadValue);
		map.get(busidx).set(5, engineCoolantTemperature);
		map.get(busidx).set(6, enginRPM);
		map.get(busidx).set(7, vehicleSpeed);
		map.get(busidx).set(8, MAF);
		map.get(busidx).set(9, throttlePosition);
		logmap.get("rolling"+busidx).debug("temp,"+busidx+","+engineLoadValue+"/"+engineCoolantTemperature+"/"+enginRPM+"/"+vehicleSpeed+"/"+MAF+"/"+throttlePosition);
		return "success";		
	}*/
	
	
	@RequestMapping("/admin/candata.do")
	@ResponseBody
	public String candata(@RequestParam("busidx") String busidx) {
		//actual data
		JSONObject can = new JSONObject();
		can.put("engineLoadValue",map.get(busidx).get(4));
		can.put("engineCoolantTemperature", map.get(busidx).get(5));
		can.put("enginRPM", map.get(busidx).get(6));
		can.put("vehicleSpeed", map.get(busidx).get(7));
		can.put("MAF", map.get(busidx).get(8));
		can.put("throttlePosition", map.get(busidx).get(9));
		System.out.println("BUS"+busidx+can.toJSONString());
		return can.toJSONString();
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
