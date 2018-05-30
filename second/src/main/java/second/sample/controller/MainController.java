package second.sample.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping("main.do")
	public String main() {
		log.debug("메인점디오");
		return "admin/main";
	}
}
