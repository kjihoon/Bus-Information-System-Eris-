package second.sample.controller;



import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import second.admin.service.AdminService;
import second.bus.service.BusService;
import second.common.common.CommandMap;

@Controller
public class AdminRegisterController {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BusService busService;
	
	
	@RequestMapping("admin/registerbus.do")
	public String registerbus(Model model) {
		model.addAttribute("center","register_bus");
		return "admin/main";
	}
	
	@RequestMapping(value="admin/registerbusimp.do", method=RequestMethod.POST)
	public String registerbusimp(CommandMap cmd,Model model) throws Exception {
		System.out.println(cmd.getMap().toString());
		Map<String,Object> map = new HashMap<String,Object>();
		map= adminService.selectAdminOne(cmd.getMap());
		if (map==null) {
			map = new HashMap<String,Object>();
			model.addAttribute("result","관리자의 ID 또는 PWD가 잘못되었습니다.");
		}else {
			//register new bus code
			busService.insertBus(cmd.getMap());
			System.out.println(map.toString());
			model.addAttribute("result","등록을 성공하였습니다.");		
		}
		model.addAttribute("center","register_bus");
		return "admin/main";
	}
	
	@RequestMapping("admin/registerdriver.do")
	public String registerdriver(Model model) {
		model.addAttribute("center","register_driver");		
		return "admin/main";
	}
	
	@RequestMapping(value="admin/registerdriverimp.do", method=RequestMethod.POST)
	public String registerdriverimp(CommandMap cmd,Model model) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map= adminService.selectAdminOne(cmd.getMap());
		if (map==null) {
			map = new HashMap<String,Object>();
			
			model.addAttribute("result","관리자의 ID 또는 PWD가 잘못되었습니다.");
		}else {
			//register new bus code
			System.out.println(map.toString());
			model.addAttribute("result","등록을 성공하였습니다.");		
		}	
		model.addAttribute("center","register_driver");
		return "admin/main";
	}
}
