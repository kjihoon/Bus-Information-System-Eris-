package com.erise.habaak.iamgettingoffhere;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.StringTokenizer;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link HomeFragment.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link HomeFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class HomeFragment extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private Client client;

    private ImageView ivProfile;
    private TextView tvDrivaerName;
    private TextView tvDriver;
    private TextView tvBusNum;
    private TextView tvSpeed;
    private TextView tvTemp;
    private TextView tvHumi;
    private Button btnLocation;
    private TextView tvBellCtl;
    private Button btnBell;
    private TextView tvTempCtl;
    private Button btnCold;
    private Button btnHot;
    private TextView tvSpeedCtl;
    private TextView tvCarRegNum;
    private Button btnSlow;
    private Button btnFast;
    private TextView tvCrime;
    private Button btnCrime;


    private OnFragmentInteractionListener mListener;

    public HomeFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment HomeFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static HomeFragment newInstance(String param1, String param2) {
        HomeFragment fragment = new HomeFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
        try {
            client = new Client();

        } catch (IOException e) {
            e.printStackTrace();
        }
        client.start();
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_home,container,false);
        ivProfile = v.findViewById(R.id.ivProfile);
        tvDrivaerName = v.findViewById(R.id.tvDriverName);
        tvDriver = v.findViewById(R.id.tvDriver);
        tvBusNum = v.findViewById(R.id.tvBusNum);
        tvSpeed = v.findViewById(R.id.tvSpeed);
        tvTemp = v.findViewById(R.id.tvTemp);
        tvHumi = v.findViewById(R.id.tvHumi);
        tvCarRegNum = v.findViewById(R.id.tvCarRegNum);
        btnLocation = v.findViewById(R.id.btnLocation);
        tvBellCtl = v.findViewById(R.id.tvBellCtl);
        btnBell = v.findViewById(R.id.btnBell);
        tvTempCtl = v.findViewById(R.id.tvTempCtl);
        btnCold = v.findViewById(R.id.btnCold);
        btnHot = v.findViewById(R.id.btnHot);
        tvSpeedCtl = v.findViewById(R.id.tvSpeedCtl);
        //btnSlow = v.findViewById(R.id.btnSlow);
        btnFast = v.findViewById(R.id.btnFast);
        tvCrime = v.findViewById(R.id.tvCrime);
        btnCrime = v.findViewById(R.id.btnCrime);

        btnBell.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                client.sendMsg("client bell");
            }
        });
        btnCold.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                client.sendMsg("client cold");
            }
        });
        btnHot.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                client.sendMsg("client hot");
            }
        });
        btnFast.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                client.sendMsg("client fast");
            }
        });
        /*btnSlow.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                client.sendMsg("client slow");
            }
        });*/
        btnLocation.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                client.sendMsg("client location");
            }
        });
        btnCrime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                client.sendMsg("client crime");
            }
        });
        return v;
    }



    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    public void setBusAndDriverInfo(final String busNum, final String platenum, final String drivername){
        new Thread(new Runnable() {
            @Override
            public void run() {
                getActivity().runOnUiThread(new Runnable(){
                    @Override
                    public void run() {
                        tvBusNum.setText(busNum+"번");
                        tvCarRegNum.setText(platenum);
                        tvDrivaerName.setText(drivername);
                    }
                });
            }
        }).start();
    }
    public void setTempHumiInfo(final String temp, final String humi){
        new Thread(new Runnable() {
            @Override
            public void run() {
                getActivity().runOnUiThread(new Runnable(){
                    @Override
                    public void run() {
                    tvTemp.setText(temp + "°C");
                    tvHumi.setText(humi +"%");
                    }
                });
            }
        }).start();

    }
    public void setSpeedInfo(final String speed) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                getActivity().runOnUiThread(new Runnable(){
                    @Override
                    public void run() {
                        tvSpeed.setText(speed+"KM/h");
                    }
                });
            }
        }).start();
    }

    /*@Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }*/

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }

    //Client Socket Start

    public class Client extends Thread {

        boolean flag = true;
        boolean cflag = true;
        String address = "192.168.0.31";
        Socket socket;

        public Client() throws UnknownHostException, IOException {

        }

        @Override
        public void run() {
            while (cflag) { // 서버와 통신 될 때 까지 접속 시도 루프
                try {
                    socket = new Socket(address, 8888);
                    Log.d("[Connect]",address+"Connected Server...");
                    if (socket != null && socket.isConnected()) {
                        cflag = false;
                    }
                    break;
                } catch (IOException e) {
                    Log.d("[Connect Re-Try]",address+"Re-Try Connection...");
                    //Toast.makeText(MainActivity.this,"Retry",Toast.LENGTH_LONG).show();
                        try {
                        Thread.sleep(5000);
                    } catch (InterruptedException e1) {
                        e1.printStackTrace();
                    }
                }
            }
            // After Connected ...
            try {
                new Receiver(socket).start();
                client.sendMsg("client conn");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

        public void sendMsg(String msg) {
            try {
                Sender sender = new Sender(socket);
                sender.setSendMsg(msg);
                Log.d("[Server App]",sender.toString());
                new Thread(sender).start();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

        // 소켓이 만들어지

        class Sender implements Runnable { // 문자를 입력하면 Sender가 만들어지고 전송

            Socket socket;
            OutputStream os;
            DataOutputStream dos;
            String sendMsg;

            public Sender(Socket socket) throws IOException {
                this.socket = socket;
                os = socket.getOutputStream();
                dos = new DataOutputStream(os);
            }

            public void setSendMsg(String sendMsg) {
                this.sendMsg = sendMsg;
            }

            @Override
            public void run() {
                try {
                    if (dos != null) {
                        dos.writeUTF(sendMsg);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }

        class Receiver extends Thread { // 들어올때까지 기다리고 읽는다.
            Socket socket;
            InputStream is;
            DataInputStream dis;

            public Receiver() {
            }

            public Receiver(Socket socket) throws IOException {
                this.socket = socket;
                is = socket.getInputStream();
                dis = new DataInputStream(is);
            }

            @Override
            public void run() {
                try {
                    while (flag && dis != null) {

                        String str = dis.readUTF();
                        Log.d("[Client App]",str);
                        StringTokenizer st = new StringTokenizer(str, " ");
                        String[] tokenBox = new String[10];
                        for( int x = 0; st.hasMoreElements(); x++ ){
                            //Log.i("[Token]" , x + " : " + st.nextToken() );
                            tokenBox[x]=st.nextToken();
                            Log.i("[Receive MSG array]",tokenBox[x]);
                        }
                        if(tokenBox[0].equals("info")){
                            setBusAndDriverInfo(tokenBox[1],tokenBox[2],tokenBox[3]);
                        }
                        if(tokenBox[0].equals("temp")){
                            setTempHumiInfo(tokenBox[1],tokenBox[3]);
                        }
                        if(tokenBox[0].equals("speed")){
                            setSpeedInfo(tokenBox[1]);
                        }
                    }
                } catch (Exception e) {
                    Log.d("[Client App]","Server Closed");
                } finally { //while이 끝나는 시점
                    try {
                        dis.close();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }

                stopClient();
            }
        }

        public void stopClient() {
            try {
                Thread.sleep(1000);
                flag = false;
                if (socket != null) {
                    socket.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }


    //Client Socket End

}
