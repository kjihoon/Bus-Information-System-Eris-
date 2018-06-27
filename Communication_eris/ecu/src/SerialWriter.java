import java.io.IOException;
import java.io.OutputStream;

public class SerialWriter extends Thread {
	OutputStream out;
	char preC = ' ';
	char c = ' ';
	SerialCan serialCan;

	public SerialWriter(OutputStream out) {
		this.out = out;
	}

	public SerialWriter(OutputStream out, SerialCan serialCan) {
		this.out = out;
		this.serialCan = serialCan;
	}

	public void setC(char c) {
		this.c = c;
	}

	public void run() {

		System.out.println("SerialWriter Start");
		System.out.println("=================");
		try {

			while (true) {
				
				String ss = serialCan.getCommand();
				if (!ss.equals("") && ss.length() > 20 ) {
					String PID;
					System.out.println("writer ss = " + ss);
					
					PID = ss.substring(16,18);
					System.out.println("PID = " + PID);
					
					if(PID.equals("01")) {
						out.write('b');
					}
					
					serialCan.setCommand("");
					
				}
				
				try {
					Thread.sleep(200);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
