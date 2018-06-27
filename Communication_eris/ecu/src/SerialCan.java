import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Random;

import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;
import gnu.io.NoSuchPortException;
import gnu.io.SerialPort;
import gnu.io.SerialPortEvent;
import gnu.io.SerialPortEventListener;

public class SerialCan implements SerialPortEventListener {

	private BufferedInputStream bin;
	private InputStream in;
	private OutputStream out;
	private SerialPort serialPort;
	private CommPortIdentifier portIdentifier;
	private CommPort commPort;
	private String command = "";
	static String ht = "W280000ABCD" + "020100" + "0000555555";
	static String speed = "W280000ABCD" + "02010D" + "0055555555";
	static int engineLoadValue = 0;
	static int engineCoolant = 0;
	static int engineRPM = 0;
	static double MAF = 0;
	static int throttle = 0;
	static int seat[] = new int [16];
	//static String msg = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
	static String msg = "온도요청 들어왔습니다 37";
	
	
	Random random = new Random();

	public SerialCan() {
	}

	public SerialCan(String portName) throws NoSuchPortException {

		portIdentifier = CommPortIdentifier.getPortIdentifier(portName);
		System.out.println("connect comport");
		try {
			connectSerial();
			System.out.println("COnnectOK");
			(new Thread(new SerialCanWriter())).start();
		} catch (Exception e) {
			System.out.println("COnnectFail");
			e.printStackTrace();
		}

	}

	public void connectSerial() throws Exception {

		if (portIdentifier.isCurrentlyOwned()) {
			System.out.println("Error: Port is currently in use");
		} else {
			commPort = portIdentifier.open(this.getClass().getName(), 5000);
			if (commPort instanceof SerialPort) {
				serialPort = (SerialPort) commPort;
				serialPort.addEventListener(this);
				serialPort.notifyOnDataAvailable(true);
				serialPort.setSerialPortParams(921600, 
						SerialPort.DATABITS_8, 
						SerialPort.STOPBITS_1, 
						SerialPort.PARITY_NONE); 
				in = serialPort.getInputStream();
				bin = new BufferedInputStream(in);
				out = serialPort.getOutputStream();
			} else {
				System.out.println("Error: Only serial ports are handled by this example.");
			}
		}
	}

	public void sendMsg(String msg) {
		// W28 00000000 000000000000
		System.out.println("ECU send msg to communicationModule = " + msg);
		SerialCanWriter scw = new SerialCanWriter(msg);
		new Thread(scw).start();
	}

	private class SerialCanWriter implements Runnable {
		String data;

		public SerialCanWriter() {
			this.data = ":G11A9\r";
		}

		public SerialCanWriter(String serialData) {
			// W28 00000000 000000000000
			// :W28 00000000 000000000000 53 /r 

			String sdata = sendDataFormat(serialData);
			this.data = sdata;
		}

		public String sendDataFormat(String serialData) {
			serialData = serialData.toUpperCase();
			char c[] = serialData.toCharArray();
			int cdata = 0;
			for (char cc : c) {
				cdata += cc;
			}
			cdata = (cdata & 0xFF);

			String returnData = ":";
			returnData += serialData + Integer.toHexString(cdata).toUpperCase();
			returnData += "\r";
			System.out.println("returnData = " + returnData);
			return returnData;
		}

		public void run() {
			try {

				byte[] inputData = data.getBytes();
				
				//System.out.println("inputdata = " + inputData);
				out.write(inputData); 
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	@Override
	public void serialEvent(SerialPortEvent event) {
		switch (event.getEventType()) {
		case SerialPortEvent.BI:
		case SerialPortEvent.OE:
		case SerialPortEvent.FE:
		case SerialPortEvent.PE:
		case SerialPortEvent.CD:
		case SerialPortEvent.CTS:
		case SerialPortEvent.DSR:
		case SerialPortEvent.RI:
		case SerialPortEvent.OUTPUT_BUFFER_EMPTY:
			break;
		case SerialPortEvent.DATA_AVAILABLE:
			byte[] readBuffer = new byte[128];

			try {

				while (bin.available() > 0) {
					int numBytes = bin.read(readBuffer);
				}

				String ss = new String(readBuffer).trim();
				if(ss.charAt(1) == 'U' && ss.substring(4, 12).equals("0000ABCD")) {
					String str = "";
					String PID;
					PID = ss.substring(16,18);
					
					if(PID.equals("04")) {
						str = makeEngineLode();
						setEngineLode(str);
					}else if(PID.equals("05")) {
						str = makeEngineCoolant();
						setEngineCoolant(str);
					}else if(PID.equals("0C")) {
						str = makeEngineRPM();
						setEngineRPM(str);
					}else if(PID.equals("10")) {
						str = makeMAF();
						setMAF(str);
					}else if(PID.equals("11")) {
						str = makeThrottle();
						setThrottle(str);
					}else if(PID.equals("0D")) {
						str = this.getSpeed();
					}else if(PID.equals("00")) {
						str = this.getHT();
					}else if(PID.equals("01")) {
						command = ss;
					}else if(PID.equals("02")) {
						setRTMsg(ss);
						System.out.println("온도요청 들어왔습니다 " + str.substring(18,20));
					}
					
					this.sendMsg(str);
					
					System.out.println("Receive Low Data:" + ss + "||");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		}
	}
	public void setRTMsg(String str) {
		msg = "온도요청 들어왔습니다 " + str.substring(18,20) + "도";
	}

	public String getMsg() {
		return msg;
	}
	public void setSeat(String str) {
		int num = 0;
		String snum = str.substring(4,5);
		if(snum.equals("a") || snum.equals("b") || snum.equals("c") || snum.equals("d") || snum.equals("e") || snum.equals("f")) {
			num = Integer.parseInt(snum,16);
		}else {
			num = Integer.parseInt(snum);
		}
		if(seat[num] == 0) {
			seat[num] = 1;
		}else {
			seat[num] = 0;
		}
		
	}
	public int[] getSeat() {
		return seat;
	}
	
	public String makeEngineLode() {
		String PID;
		String A = "";
		String B = "55";
		String C = "55";
		String D = "55";
		PID = "04";
		
		int per;
		per = random.nextInt(99) + 1;
		if(per <= 85) {
			A = Integer.toHexString(random.nextInt(90));
		}else if(per <= 95) {
			A = Integer.toHexString(random.nextInt(75) + 91);
		}else if(per <= 100) {
			A = Integer.toHexString(random.nextInt(88) + 167);
		}
		
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}
	
	public void setEngineLode(String str) {
		engineLoadValue = Integer.parseInt(str.substring(18, 20),16) * 100 / 255;
	}
	
	public int getEngineLodeValue(){
		return engineLoadValue;
	}

	public String makeEngineCoolant() {
		String PID;
		String A = "";
		String B = "55";
		String C = "55";
		String D = "55";
		
		PID = "05";
		int per;
		per = random.nextInt(99) + 1;
		if(per <= 94) {
			A = Integer.toHexString(random.nextInt(14) + 136);
		}else if(per <= 97) {
			A = Integer.toHexString(random.nextInt(15) + 150);
		}else if(per <= 100) {
			A = Integer.toHexString(random.nextInt(15) + 121);
		}
		
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}
	
	public void setEngineCoolant(String str) {
		engineCoolant = Integer.parseInt(str.substring(18, 20),16) - 40;
	}
	public int getEngineCoolant() {
		return engineCoolant;
	}

	public String makeEngineRPM() {
		String PID;
		String A;
		String B;
		String C = "55";
		String D = "55";
		PID = "0C";
		A = Integer.toHexString(random.nextInt(255));
		B = Integer.toHexString(random.nextInt(255));
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}
	
	public void setEngineRPM(String str) {
		engineRPM = (Integer.parseInt(str.substring(18, 20),16)*256 + Integer.parseInt(str.substring(20, 22),16))/4;
	}
	public int getEngineRPM() {
		return engineRPM;
	}

	public String makeMAF() {
		String PID;
		String A;
		String B;
		String C = "55";
		String D = "55";
		PID = "10";
		A = Integer.toHexString(random.nextInt(255));
		B = Integer.toHexString(random.nextInt(255));
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}
	
	public void setMAF(String str) {
		MAF = (Integer.parseInt(str.substring(18, 20),16)*256 + Integer.parseInt(str.substring(20, 22),16))/100;
	}
	public double getMAF() {
		return MAF;
	}

	public String makeThrottle() {
		String PID;
		String A;
		String B = "55";
		String C = "55";
		String D = "55";
		PID = "11";
		A = Integer.toHexString(random.nextInt(255));
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}
	public void setThrottle(String str) {
		throttle = Integer.parseInt(str.substring(18, 20),16) * 100 / 255;
	}
	public int getThrottle() {
		return throttle;
	}
	public void setSpeed(String s) {
		
		String A;
		String B = "55";
		String C = "55";
		String D = "55";
		//System.out.println(Integer.parseInt(s.substring(2, s.length())));
		//if(s.charAt(0) != 'v') {
			A = Integer.toHexString(Integer.parseInt(s.substring(2, s.length())));
		//}
		speed = "W280000ABCD" + "02010D" + A + B + C + D + "55";
	}

	public String getSpeed() {
		return speed;
	}
	
	public void setHT(String humidity, String temperature) {
		
		humidity = Integer.toHexString(Integer.parseInt(humidity));
		temperature = Integer.toHexString(Integer.parseInt(temperature));
		//System.out.println("humidity = " + humidity + ", temperature = " + temperature);
		while (humidity.length() < 2) {
			humidity = "0" + humidity;
		}
		while (temperature.length() < 2) {
			temperature = "0" + temperature;
		}
		ht = "W280000ABCD" + "020100" + humidity + temperature + "55" + "55" + "55";
	}
	
	public String getHT() {
		return ht;
	}
	
	public void setCommand(String ss) {
		command = ss;
	}
	public String getCommand() {
		return command;
	}

}
