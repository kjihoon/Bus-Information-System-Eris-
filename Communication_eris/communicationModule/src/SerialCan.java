import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

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

	public SerialCan() {
	}

	public SerialCan(String portName) throws NoSuchPortException {
		
		System.out.println("portName = " + portName);

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
				serialPort.setSerialPortParams(921600, // ��żӵ�
						SerialPort.DATABITS_8, // ������ ��Ʈ
						
						SerialPort.STOPBITS_1, // stop ��Ʈ
						SerialPort.PARITY_NONE); // �и�Ƽ
				in = serialPort.getInputStream();
				bin = new BufferedInputStream(in);
				out = serialPort.getOutputStream();
			} else {
				System.out.println("Error: Only serial ports are handled by this example.");
			}
		}
	}
	
	public void sendMsg(String msg) {
		SerialCanWriter sw = new SerialCanWriter(msg);
		new Thread(sw).start();
	}


	private class SerialCanWriter implements Runnable {
		String data;

		public SerialCanWriter() {
			this.data = ":G11A9\r";		// ���ݺ��� ĵ �����͸� �����Ŷ�� ��
		}

		public SerialCanWriter(String serialData) {
			// W28 00000000 0000000000000000
			// :W28 00000000 0000000000000000 53
			String sdata = sendDataFormat(serialData);
			System.out.println("send msg = " + sdata);
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
			return returnData;
		}

		public void run() {
			try {

				byte[] inputData = data.getBytes();

				out.write(inputData); 	// �ξƿ�ǲ ��Ʈ���� ����ϴ� ������ ���� ���α׷��� �������� �𸣱� ������
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

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
				if(ss.charAt(1) == 'U') {
					command = ss;
					System.out.println("Receive Low Data:" + ss + "||");
				}
				//String ss = new String(readBuffer);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		}
	}
	public void setCommand(String ss) {
		command = ss;
	}
	public String getCommand() {
		return command;
	}
	
}
