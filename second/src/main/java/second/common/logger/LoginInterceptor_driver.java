package second.common.logger;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor_driver extends HandlerInterceptorAdapter{
	protected Log log = LogFactory.getLog(LoggerInterceptor.class); 
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { 
		String path = request.getServletPath();
		if(path.equals("/driver/login.do") || path.equals("/driver/loginimp.do")) {
			return true;
		}else {  
			@SuppressWarnings("unchecked") 
			Map<String, Object> userMap = (Map<String, Object>) request.getSession().getAttribute("driverInfo");	 	 
			if(userMap == null) {
				log.debug("==========Detect Abnormal Approach==============");
				response.sendRedirect("login.do");  
				return false;  
			} else {   
				return true;  
			}
		}
	}	
}
