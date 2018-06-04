package second.sample.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import second.common.common.CommandMap;

@Controller
public class ClientController {
	private static Map <String,String> map = new HashMap<>();
	private static Map <String,String> map2 = new HashMap<>();
	private static Map <String,String> map3 = new HashMap<>();
	
	@RequestMapping("/admin/clientmsg.do")
	public String clientmsg() {
		return "admin/clientcard";
	}
	
	@RequestMapping("/admin/clientcard.do")
	@ResponseBody
	public String clientcard(@RequestParam("busidx") String busidx) {
		String msg = map.get(busidx);
		
		JSONObject jo = new JSONObject();
		
		if (map2.get(busidx)!=map3.get(busidx)) {	
			jo.put("msg",msg);
			System.out.println("new msg");
			map3.put(busidx, map2.get(busidx));
		}else {
			System.out.println("이전 메세지");
			jo.put("msg", "5");
			map.replace(busidx,"5");			
		}
		
		
		
		
		return jo.toString();
	}
	
	@RequestMapping("/admin/cardfromclient.do")
	@ResponseBody
	public void cardfromclient(CommandMap cmd) {	
		System.out.println(cmd.getMap().toString());
		String busidx= (String) cmd.get("busidx");
		if (map.get(busidx)!= null) {
			map.replace(busidx,(String) cmd.get("msg"));
			map2.replace(busidx, (String) cmd.get("msgidx"));
		}else {			
			map.put(busidx,(String) cmd.get("msg"));
			map2.put(busidx, (String) cmd.get("msgidx"));
			map3.put(busidx, (String) cmd.get("0"));
		}
	}
	
	@RequestMapping("/admin/cardfromadmin.do")
	public void cardfromadmin(CommandMap cmd) {
		System.out.println(cmd.getMap().toString());
		
		
	}
}
