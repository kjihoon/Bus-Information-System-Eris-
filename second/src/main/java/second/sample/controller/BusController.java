package second.sample.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import second.bus.service.BusService;
import second.common.common.CommandMap;

@Controller
public class BusController {

	@Autowired
	private BusService busService;
	
	
	@RequestMapping("bustest.do")
	@ResponseBody
	public String bustest(CommandMap cmd) throws Exception {
		List<Map<String, Object>> map =busService.selectBusList(cmd.getMap());
		return map.toString();
	}
	
	
}
