import java.awt.Button;
import java.awt.Checkbox;
import java.awt.Color;
import java.awt.Font;
import java.awt.Frame;
import java.awt.GridLayout;
import java.awt.Panel;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import javax.swing.JLabel;

public class AwtView {
	static String msg;
	Frame mainFrame = new Frame();
	Panel infoPanel = new Panel();
	Panel tempPanel = new Panel();
	Panel bottomPanel = new Panel();
	
	Panel msgPanel = new Panel();
	Panel chkPanel = new Panel();
	Panel chkP1 = new Panel();
	Panel chkP2 = new Panel();
	Panel chkP3 = new Panel();
	Panel chkP4 = new Panel();
	
	Button bt[] = new Button[9]; 
	SerialCan serialCan;
	
	
	Checkbox chk[] = new Checkbox[16];
	
	JLabel reqLabel = new JLabel();
	JLabel resLabel = new JLabel();
	JLabel seatLabel = new JLabel();
	static int seatinfo[];
	
	AwtView(SerialCan serialCan){
		this.serialCan = serialCan;
		seatinfo = new int [16];
		bt[0] = new Button("Speed : " + Integer.parseInt(serialCan.getSpeed().substring(17, 19)) +"Km/h");
		bt[1] = new Button("Humidity : " + Integer.parseInt(serialCan.getHT().substring(17, 19)) +"%");
		bt[2] = new Button("온도: " + Integer.parseInt(serialCan.getHT().substring(19, 21)) +"C");
		bt[3] = new Button("요청받은 온도: " + "x");
		bt[4] = new Button("RPM : " + serialCan.getEngineRPM() + "rpm");
		bt[5] = new Button("Engine Load Value : " + serialCan.getEngineLodeValue() + "%");
		bt[6] = new Button("Coolant Temperature : " + serialCan.getEngineCoolant() + "C");
		bt[7] = new Button("MAF : " + serialCan.getMAF());
		bt[8] = new Button("Throttle Position : " + serialCan.getThrottle());
		
		seatLabel.setText("Seat Information");
		seatLabel.setHorizontalAlignment(JLabel.CENTER);
		
		reqLabel.setText("request message");
		reqLabel.setHorizontalAlignment(JLabel.CENTER);
		resLabel.setText("response message");
		resLabel.setHorizontalAlignment(JLabel.CENTER);
	}
	
	public void makeUI() {
		for(int i=0; i< bt.length; i++) {
			bt[i].setBackground(Color.black);
			bt[i].setForeground(Color.white);
			bt[i].setFont(new Font("Consolas",Font.BOLD,20));
		}
		for(int i=0; i< chk.length; i++) {
			chk[i] = new Checkbox("");
		}
		//chk[0].setState(true);
		chkP1.add(chk[0]);
		chkP1.add(chk[1]);
		chkP1.add(chk[2]);
		chkP1.add(chk[3]);
		chkP2.add(chk[4]);
		chkP2.add(chk[5]);
		chkP2.add(chk[6]);
		chkP2.add(chk[7]);
		chkP3.add(chk[8]);
		chkP3.add(chk[9]);
		chkP3.add(chk[10]);
		chkP3.add(chk[11]);
		chkP4.add(chk[12]);
		chkP4.add(chk[13]);
		chkP4.add(chk[14]);
		chkP4.add(chk[15]);
		
		

		mainFrame.setLayout(new GridLayout(2,1));
		infoPanel.setLayout(new GridLayout(2,4));
		tempPanel.setLayout(new GridLayout(2,1));
		bottomPanel.setLayout(new GridLayout(1,2));
		msgPanel.setLayout(new GridLayout(2,1));
		chkPanel.setLayout(new GridLayout(5,1));
		chkPanel.add(seatLabel);
		chkPanel.add(chkP1);
		chkPanel.add(chkP2);
		chkPanel.add(chkP3);
		chkPanel.add(chkP4);
		infoPanel.add(bt[0]);
		infoPanel.add(bt[1]);
		tempPanel.add(bt[2]);
		tempPanel.add(bt[3]);
		infoPanel.add(tempPanel);
		infoPanel.add(bt[4]);
		infoPanel.add(bt[5]);
		infoPanel.add(bt[6]);
		infoPanel.add(bt[7]);
		infoPanel.add(bt[8]);
		msgPanel.add(reqLabel);
		msgPanel.add(resLabel);
		bottomPanel.add(msgPanel);
		bottomPanel.add(chkPanel);
		mainFrame.add(infoPanel);
		mainFrame.add(bottomPanel);
		
		mainFrame.setLocation(0, 0);
		mainFrame.setSize(1000, 600);
		mainFrame.setVisible(true);
		
		mainFrame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				mainFrame.dispose();
				System.exit(0);
			}
		});
	}

	public void update() {
		seatinfo = serialCan.getSeat();
		for(int i=0; i<seatinfo.length; i++) {
			if(seatinfo[i] == 1) {
				chk[i].setState(true);
			}else {
				chk[i].setState(false);
			}
		}
		msg = serialCan.getMsg();
		reqLabel.setText(msg);
		if(Integer.parseInt(msg.substring(12, 14)) < Integer.parseInt(serialCan.getHT().substring(19, 21),16)) {
			resLabel.setText("에어컨 가동하겠습니다.");
		}else if(Integer.parseInt(msg.substring(12, 14)) > Integer.parseInt(serialCan.getHT().substring(19, 21),16)) {
			resLabel.setText("온풍기 가동하겠습니다.");
		}else {
			reqLabel.setText("request message");
			resLabel.setText("response message");
		}
		
		bt[0].setLabel("Speed : " + Integer.parseInt(serialCan.getSpeed().substring(17, 19),16) +"Km/h");
		bt[1].setLabel("Humidity : " + Integer.parseInt(serialCan.getHT().substring(17, 19),16) +"%");
		bt[2].setLabel("온도: " + Integer.parseInt(serialCan.getHT().substring(19, 21),16) +"C");
		bt[3].setLabel("요청받은 온도: " + msg.substring(12,14) + "C");
		bt[4].setLabel("RPM : " + serialCan.getEngineRPM() + "rpm");
		bt[5].setLabel("Engine Load Value : " + serialCan.getEngineLodeValue() + "%");
		bt[6].setLabel("Coolant Temperature : " + serialCan.getEngineCoolant() + "C");
		bt[7].setLabel("MAF : " + serialCan.getMAF());
		bt[8].setLabel("Throttle Position : " + serialCan.getThrottle());
	}

}
