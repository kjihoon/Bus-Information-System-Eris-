package second.sample.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminBusController {

	@RequestMapping("admin/busContoll.do")
	public String busContoll() {
		return "admin/busContoll";
	}
}
