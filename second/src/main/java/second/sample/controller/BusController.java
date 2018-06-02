package second.sample.controller;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import second.bus.service.BusService;
import second.common.common.CommandMap;

@Controller
public class BusController {

	@Autowired
	private BusService busService;
	
	JSONObject jo = new JSONObject();
	
	@RequestMapping("/bus/can.do")
	public String bustest(CommandMap cmd) {
		return "bus/can";
	}
	
	
}
