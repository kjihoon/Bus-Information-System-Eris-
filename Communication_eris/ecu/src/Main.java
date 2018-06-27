public class Main {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SerialCan serialCan = null;
		AwtView awtView;
		try {
			serialCan = new SerialCan("COM7");
			
			awtView = new AwtView(serialCan);
			awtView.makeUI();

			Serial serial = new Serial(serialCan, awtView);
			serial.connect("COM6");
			
		} catch (Exception e) {
			System.out.println("can connect fail");
			e.printStackTrace();
		}
	}
}
