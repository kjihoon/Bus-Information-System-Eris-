package second.sample.controller;

import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import second.common.common.CommandMap;

@Controller
public class TestController {

	
	@RequestMapping("admin/testchart.do")
	public String testChart() {
		return "admin/charts";
	}
	
	@RequestMapping(value="/user/login.do", method=RequestMethod.POST)
	@ResponseBody
	public String login(CommandMap cmd) {
		cmd.put("sdf", "sdf");
		System.out.println(cmd.getMap().toString());
		
		
		/*Random rand = new Random();
		double sd = 1.5;
		double mean = 50;
		double rand2 = rand.nextGaussian()*sd+mean;*/
		
		return  cmd.toString();
	}
}
