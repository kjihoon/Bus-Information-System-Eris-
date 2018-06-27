import java.io.IOException;
import java.io.InputStream;
import java.util.Random;

public class SerialReader extends Thread {
	InputStream in;
	String str;
	String humidity;
	String temperature;
	SerialCan serialCan;
	String v;
	String PID;
	String A;
	String B = "55";
	String C = "55";
	String D = "55";
	Random random = new Random();
	AwtView awtView;

	public SerialReader(InputStream in, SerialCan serialCan, AwtView awtView) {
		this.in = in;
		this.serialCan = serialCan;
		this.awtView = awtView;
	}

	public void run() {
		byte[] buffer = new byte[1024];
		int len = -1;
		System.out.println("SerialReader Start");
		System.out.println("=================");

		try {
			while ((len = this.in.read(buffer)) > -1) {
				if (len != 0) {
					str = new String(buffer, 0, len).trim();	

					if (!str.equals("")) {

						if (str.charAt(0) == 'h') {
							humidity = str.substring(2, 4);
							temperature = str.substring(6, 8);
							serialCan.setHT(humidity, temperature);
						}
						else if (str.charAt(0) == 'v') {
							serialCan.setSpeed(str);
							awtView.update();
						}else if (str.charAt(0) == 'k') {
							System.out.println(str);
							serialCan.setSeat(str);
						}
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String makeEngineLode() {
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

	public String makeEngineCoolant() {
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
		
		//A = Integer.toHexString(random.nextInt(255));
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}

	public String makeEngineRPM() {
		PID = "0C";
		A = Integer.toHexString(random.nextInt(255));
		B = Integer.toHexString(random.nextInt(255));
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}

	public String makeSpeed(String s) {
		PID = "0D";
		A = Integer.toHexString(Integer.parseInt(s.substring(2, s.length())));
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}

	public String makeMAF() {
		PID = "10";
		A = Integer.toHexString(random.nextInt(255));
		B = Integer.toHexString(random.nextInt(255));
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}

	public String makeThrottle() {
		PID = "11";
		A = Integer.toHexString(random.nextInt(255));
		return "W280000ABCD" + "0201" + PID + A + B + C + D + "55";
	}

}
