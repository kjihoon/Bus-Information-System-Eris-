public class Main {
	public static void main(String[] args) {
		
		SerialCan serialCan = null;
		try {
			serialCan = new SerialCan("COM3");
			
			Client client = new Client(serialCan);
			client.start();
			
			/*String msg = "W28000000000000000000000001";
			serialCan.sendMsg(msg);
			
			
			
			Thread.sleep(5000);
			serialCan.sendMsg("W28000000000000000000000010");*/
			
		} catch (Exception e) {
			System.out.println("connect fail");
			e.printStackTrace();
		}
	}
}
