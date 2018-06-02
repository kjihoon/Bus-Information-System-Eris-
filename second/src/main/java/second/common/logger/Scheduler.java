package second.common.logger;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import function.usingR;

@Component
public class Scheduler {
	  protected Log log = LogFactory.getLog(this.getClass());
	/*@Scheduled(cron="0 58 * * * *")
	public void savelogFile() {
		FileReader filereader = null;
        BufferedReader bufreader =null;
        PrintWriter out = null;
        
        Date dt = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-HH"); 
        try{
        	List<String> fileList = new ArrayList<>();
       
        	fileList.add("busInformation_idx5");
        	fileList.add("busInformation_idx4");
        	for (int i =0;i<fileList.size();i++) {
        		File file = new File("C:\\LOG\\"+fileList.get(i)+".log");
	            if (file.exists()) {
	            	 filereader = new FileReader(file);
	                 bufreader = new BufferedReader(filereader);
	                 String log ="";
	                 String line ="";
	                 while((line = bufreader.readLine())!=null) {
	                 	log += line+"\n";
	                 }
	                 out = new PrintWriter("C:\\LOG\\"+fileList.get(i)+sdf.format(dt).toString()+".txt");
	                 out.println(log);
	                 out.close();
	            }           	 
        	}
        	
        }catch(Exception e) {
        	log.debug("logfile 저장 실패");
        }finally {
        	
        	if (filereader!=null) {
        		try {
					filereader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
        	}
        	if (bufreader!=null) {
        		try {
					bufreader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
        	}
        	
        }
		
	}*/
	
	@Scheduled(cron="0 59 * * * *")
	public void anlCanData() {
		log.debug("schedule 실행");
		usingR useR = new usingR();
		List<String> fileList = new ArrayList<>();
		 Date dt = new Date();
	     SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-HH"); 
		
		fileList.add("busInformation_idx4");
		fileList.add("busInformation_idx5");
		useR.useR(fileList);
		
	}
}
