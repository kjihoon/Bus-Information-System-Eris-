package second.sample.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import second.admin.service.AdminService;
import second.common.common.CommandMap;

@Controller
public class AdminController {

	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private AdminService adminService;
	
	@RequestMapping("admin/main.do")
	public String adminmain() {
		return "admin/main";
	}
	@RequestMapping("admin/forgot.do")
	public String adminforgot() {
		return "admin/forgot";
	}
	
	@RequestMapping("admin/tables.do")
	public String admintables() {
		return "admin/tables";
	}
	@RequestMapping("admin/register.do")
	public String adminregister() {
		return "admin/register";
	}
	
	@RequestMapping("admin/blank.do")
	public String adminblank() {
		return "admin/blank";
	}
	@RequestMapping("admin/charts.do")
	public String admincharts() {
		return "admin/charts";
	}
	@RequestMapping("admin/cards.do")
	public String admincards() {
		return "admin/cards";
	}
	
	@RequestMapping("admin/login.do")
	public String adminlogin(HttpSession session) {
		Map adminInfo = (Map) session.getAttribute("adminInfo");
		String out = "admin/login";
		if (adminInfo!=null) {
			out = "admin/main";
		}
		return out;
	}
	@RequestMapping("admin/logout.do")
	public String adminlogout(HttpSession session) {
		session.invalidate();
		return "admin/login";
	}
	
	@RequestMapping(value="admin/loginimp.do", method=RequestMethod.POST)
	public String adminloginimp(Model model,HttpSession session,CommandMap cmd) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map= adminService.selectAdminOne(cmd.getMap());
		String result="login"; 
		if (map==null) {
			map = new HashMap<String,Object>();
			map.put("result", "fail");
			model.addAttribute("result","Invalid ID or PWD, Please rewrite form");
		}else {
			map.put("result", "success");
			session.setAttribute("adminInfo", map);
			result = "main";
		}		
		return "admin/"+result;
	}
	

	
	@RequestMapping("admin/data.do")
	public String data(Model model) {
		List<Map> list = new ArrayList<>();
		
		
		Map<String,String> map = new HashMap<>();
		map.put("name", "jihoon");
		map.put("message", "12");
		map.put("time", "11:24 AM");
		list.add(map);
		list.add(map);
		list.add(map);
		list.add(map);
		list.add(map);	
		model.addAttribute("list",list);
		model.addAttribute("msgsize", list.size());// new masseage size로 변경
		System.out.println(list.toString());
		return "admin/main";
	}
	
	
	
	@RequestMapping("admin/realtime.do")
	@ResponseBody
	public String realtime() {
		JSONObject jo = new JSONObject();
		List<Integer> list = new ArrayList<>();
		for (int i =0;i<13;i++) {
			list.add((int) (Math.random()*40000) );
		}
		Descending descending = new Descending();
        Collections.sort(list, descending);

		jo.put("list", list);
		return jo.toJSONString();
	}
	// 내림차순
	class Descending implements Comparator<Integer> {	 
	    @Override
	    public int compare(Integer o1, Integer o2) {
	        return o2.compareTo(o1);
	    }	 
	}
	 
	// 오름차순
	class Ascending implements Comparator<Integer> {	 
	    @Override
	    public int compare(Integer o1, Integer o2) {
	        return o1.compareTo(o2);
	    }	 
	}	
}
