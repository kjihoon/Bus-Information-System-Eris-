import java.io.InputStream;
import java.io.OutputStream;

import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;
import gnu.io.SerialPort;

public class Serial {
	SerialCan serialCan;
	AwtView awtView;
	//SerialTest serialTest;
	public Serial() {
		super();
	}
	public Serial(SerialCan serialcan , AwtView awtView) {
		this.serialCan = serialcan;
		this.awtView = awtView;
		
	}
	
	void connect(String portName) throws Exception{
		CommPortIdentifier portIdentifier = CommPortIdentifier.getPortIdentifier(portName);
		if(portIdentifier.isCurrentlyOwned()) {
			System.out.println("Error: Port is currently in use");
		}else {
			CommPort commPort = portIdentifier.open(this.getClass().getName(), 2000);
			
			if(commPort instanceof SerialPort) {
				SerialPort serialPort = (SerialPort) commPort;
				serialPort.setSerialPortParams(115200, SerialPort.DATABITS_8, SerialPort.STOPBITS_1,SerialPort.PARITY_NONE);
				
				InputStream in = serialPort.getInputStream();
				OutputStream out = serialPort.getOutputStream();
				
				SerialWriter sw = new SerialWriter(out,serialCan);
				SerialReader sr = new SerialReader(in,serialCan,awtView);	
				
				sr.start();
				sw.start();
				
				System.out.println("Serial start");
				
			}else {
				System.out.println("Error: Only serial ports are handled by this example.");
			}
		}
	}
}
