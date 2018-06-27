
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;

public class Client {
	SerialCan serialCan;
	
	static String ID, PID, A, B, C, D;
	static boolean flag = true;

	Client() {

	}

	Client(SerialCan serialCan) {
		this.serialCan = serialCan;
	}


	public void start() {
		Socket socket = null;

		try {
			String serverIp = "70.12.241.78";
			socket = new Socket(serverIp, 8888);
			System.out.println("connected Server");

			ReceiverThread receiverThread = new ReceiverThread(socket, serialCan);
			SenderThread senderThread = new SenderThread(socket, serialCan);

			receiverThread.start();
			senderThread.start();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	static class SenderThread extends Thread {
		Socket socket;
		DataOutputStream out;
		SerialCan serialCan;

		SenderThread(Socket socket, SerialCan serialCan) {
			this.socket = socket;
			this.serialCan = serialCan;
			
			try {
				out = new DataOutputStream(socket.getOutputStream());
				System.out.println("Sender Start");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		public int calEngineLoadValue(String a) {
			int engineLoadValue = Integer.parseInt(a, 16) * 100 / 255;
			return engineLoadValue;
		}
		public int calEngineCoolantTemperature(String a) {
			int engineCoolantTemperature = Integer.parseInt(a, 16) - 40;
			return engineCoolantTemperature;
		}
		public double calEnginRPM(String a, String b) {
			int enginRPM = (Integer.parseInt(a, 16)*256 + Integer.parseInt(b, 16))/4;
			return enginRPM;
		}
		public double calMAF(String a, String b) {
			double MAF = (Integer.parseInt(a, 16)*256 + Integer.parseInt(b, 16))/100;
			return MAF;
		}
		public int calThrottlePosition(String a) {
			int throttlePosition = Integer.parseInt(a, 16) * 100 / 255;
			return throttlePosition;
		}

		public void run() {
			try {
				while (out != null) {
					
					if(flag) {
						out.writeUTF("ecu");
						flag = false;
					}
					
					String ss = serialCan.getCommand();	// 캔에서 받은 값을 
					String sendMsgToServer = "";
					
					//    :U280000ABCD0201045555555555
					//	  0123456789012345678901234567	
					if(ss.length() > 20) {
					ID = ss.substring(4,12);
					PID = ss.substring(16,18);
					A = ss.substring(18,20);
					B = ss.substring(20,22);
					C = ss.substring(22,24);
					D = ss.substring(24,26);
					}
					
					if(!ss.equals("")) {
						if(PID.equals("04")) {
							int engineLoadValue = calEngineLoadValue(A);
							sendMsgToServer = "can engineLoadValue " + engineLoadValue;
						}else if(PID.equals("05")) {
							int engineCoolantTemperature = calEngineCoolantTemperature(A);
							sendMsgToServer = "can engineCoolantTemperature " + engineCoolantTemperature;
						}else if(PID.equals("0C")) {
							double enginRPM = calEnginRPM(A,B);
							sendMsgToServer = "can enginRPM " + enginRPM;
						}else if(PID.equals("0D")) {
							sendMsgToServer = "can vehicleSpeed " + Integer.parseInt(A, 16);
						}else if(PID.equals("10")) {
							double MAF = calMAF(A,B); 
							sendMsgToServer = "can MAF " + MAF;
						}else if(PID.equals("11")) {
							int throttlePosition = calThrottlePosition(A);
							sendMsgToServer = "can throttlePosition " + throttlePosition;
						}else if(PID.equals("00")) {
							sendMsgToServer = "can Humidity " + Integer.parseInt(A, 16) + " temperature " + Integer.parseInt(B, 16);
						}/*else if(PID.equals("01")) {
							sendMsgToServer = "can bell on";
						}*/
						System.out.println("send to server = " + sendMsgToServer);
						out.writeUTF(sendMsgToServer);				// TCP 소켓을 통해 서버로 전송
						serialCan.setCommand("");	// 초기화
					}
					
					try {
						Thread.sleep(200);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
			} catch (IOException e) {

			} finally {
				try {
					socket.close();
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	static class ReceiverThread extends Thread {
		Socket socket;
		DataInputStream in;
		SerialCan serialCan;

		ReceiverThread(Socket socket, SerialCan serialCan) {
			this.socket = socket;
			this.serialCan = serialCan;
			try {
				in = new DataInputStream(socket.getInputStream());
				System.out.println("Receiver Start");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		public void run() {
			while (in != null) {
				try {
					String command = in.readUTF(); // tcp/ip 소켓으로 받은 값을

					
					System.out.println("Receive form server1 = " + command);
					
					if(command.equals("engineLoadValue")) {
						command = "W280000ABCD0201045555555555";
					}else if(command.equals("engineCoolantTemperature")) {
						command = "W280000ABCD0201055555555555";
					}else if(command.equals("enginRPM")) {
						command = "W280000ABCD02010C5555555555";
					}else if(command.equals("vehicleSpeed")) {
						command = "W280000ABCD02010D5555555555";
					}else if(command.equals("MAF")) {
						command = "W280000ABCD0201105555555555";
					}else if(command.equals("throttlePosition")) {
						command = "W280000ABCD0201115555555555";
					}else if(command.equals("H&T")) {
						command = "W280000ABCD0201005555555555";
					}else if(command.equals("bell")) {
						command = "W280000ABCD0201015555555555";
					}else if(command.substring(0,2).equals("RT")) {
						command = "W280000ABCD020102"+command.substring(3,5)+"55555555";
					}else if(command.substring(0,2).equals("dn")) {
						command = "W280000ABCD020103"+command.substring(2,4)+"55555555";
					}
					System.out.println("Receive form server2 = " + command);
					serialCan.sendMsg(command);	// 캔으로 전달
					
				} catch (IOException e) {

				}
			}
		}
	}
}
