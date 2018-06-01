package function;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class usingR {
	
	public static void useR(List<String> fileList){
		FileReader filereader = null;
        BufferedReader bufreader =null;
        Map<String,List<String>> map=null;
        Map<String,Map<String,List<String>>> result =new HashMap<>();
        try{        	
        	for (int i =0;i<fileList.size();i++) {
        		map= new HashMap<>(); 
        		File file = new File("C:\\LOG\\"+fileList.get(i)+".txt");
	            if (file.exists()) {
	            	 filereader = new FileReader(file);
	                 bufreader = new BufferedReader(filereader);
	                 String log ="";
	                 String line ="";
	                 List<String> tmp;
	                 
	                 List<String> var1= new ArrayList<String>();
	                 List<String> var2= new ArrayList<String>();
	                 List<String> var3= new ArrayList<String>();
	                 List<String> var4= new ArrayList<String>();
	                 
	                 while((line = bufreader.readLine())!=null) {
	                	tmp = new ArrayList<String>();
	     				String arr[] = line.split(",");
	     				tmp = Arrays.asList(arr);
	     				if (tmp.size()<2) {
	     					break;
	     				}
	     				var1.add("'"+tmp.get(0)+"'");
	     				var2.add("'"+tmp.get(1)+"'");
	     				var3.add("'"+tmp.get(2)+"'");
	     				var4.add("'"+tmp.get(3)+"'");
	                 }
	                 map.put("V1",var1);
	                 map.put("V2",var2);
	                 map.put("V3",var3);
	                 map.put("V4",var4);
	                 
	                 result.put(fileList.get(i), map);
	            }	            
        	}         	
        }catch(Exception e) {
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
		
		String v1 = map.get("V1").toString();
		String v2 = map.get("V2").toString();
		String v3 = map.get("V3").toString();
		String v4 = map.get("V4").toString();
		
		v1 = v1.replace("[","");
		v1 = v1.replace("]","");
		v1 = "c("+v1+")";
		
		v2 = v2.replace("[","");
		v2 = v2.replace("]","");
		v2 = "c("+v2+")";
		
		v3 = v3.replace("[","");
		v3 = v3.replace("]","");
		v3 = "c("+v3+")";
		
		v4 = v4.replace("[","");
		v4 = v4.replace("]","");
		v4 = "c("+v4+")";
		
             //////////////////////////////////////Connect R
		RConnection rconn = null;
			try {
				rconn = new RConnection("localhost",6311);
				rconn.eval("V1<-"+v1);
				rconn.eval("V2<-"+v2);
				rconn.eval("V3<-"+v3);
				rconn.eval("V4<-"+v4);
				
				rconn.eval("data<-data.frame(V1,V2,V3,V4)");
				rconn.eval(" source('~/Rjihoon/eris.R')");
				rconn.eval("readData(data)");
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rconn!=null) {
					rconn.close();
				}			
			}
		
	}
	public static void main(String [] args) {
		List<String> fileList = new ArrayList<>();
		fileList.add("busInformation_idx506-01-04");
		fileList.add("busInformation_idx506-01-05");
		useR(fileList);
	}
}
