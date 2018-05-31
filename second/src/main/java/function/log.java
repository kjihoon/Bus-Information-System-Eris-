package function;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.parser.ParseException;

public class log {
	public static void main(String [] args) throws ParseException, IOException {
		/*JSONParser jsonParser = new JSONParser();
		String can = "{'name': 38}";
		 FileReader reader = new FileReader(can);
		JSONObject jo =(JSONObject) jsonParser.parse(reader);
		reader.close();
		System.out.println(jo.toString());*/
		
		ObjectMapper mapper = new ObjectMapper(); 
		String json = "{\"name\":\"mkyong\", \"age\":29}";
		Map<String, Object> map = new HashMap<String, Object>();
		map = mapper.readValue(json, new TypeReference<Map<String, String>>(){});
		System.out.println(map.toString());
	}
}
