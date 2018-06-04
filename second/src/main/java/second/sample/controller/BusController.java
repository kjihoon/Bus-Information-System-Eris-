package second.sample.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import second.bus.service.BusService;
import second.common.common.CommandMap;

@Controller
public class BusController {

	@Autowired
	private BusService busService;
	
	JSONObject jo = new JSONObject();
	Map<String,JSONObject> map = new HashMap<>();
	
	
	
	@RequestMapping("/bus/can.do")
	public String bustest(CommandMap cmd) {
		return "bus/can";
	}
	
	@RequestMapping(value="/admin/recontroltemp.do",method=RequestMethod.POST)
	@ResponseBody
	public String recontrol(@RequestParam("busidx") String busidx) {
		JSONObject jo = null;
		if (map.get(busidx)!=null) {
			jo = new JSONObject();
			if (!map.get(busidx).get("control").equals("0")) {
				System.out.println(map.get(busidx).toJSONString());
				System.out.println(map.get(busidx).get("control"));
				jo.put("control", map.get(busidx).get("control"));				
			}else {
				jo.put("control", "0");
				map.put(busidx, jo);
			}			
		}else {
			jo = new JSONObject();
			jo.put("control", "0");
			map.put(busidx,jo);
		}
		JSONArray jr = new JSONArray();
		jr.add(jo);
		return jr.toJSONString();
	}
	
	@RequestMapping("/admin/selfcontroll.do")
	@ResponseBody
	public String selfcontroll(@RequestParam("busidx") String busidx,@RequestParam("temp") String temp) {
		JSONObject jo = new JSONObject();
		System.out.println("요청"+temp+"온도"+busidx);
		 
		if (map.get(busidx)!=null) {
			jo.put("control", temp);
			map.put(busidx, jo);
		}else {
			jo.put("controll", "운행중이 아닙니다.");
			System.out.println("(self control)해당 버스가 운행중이 아닙니다.");
		}
		
		return jo.toJSONString();
	}
}
