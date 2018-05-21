package second.sample.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {

	
	@RequestMapping("admin/testchart.do")
	public String testChart() {
		return "admin/charts";
	}
}
