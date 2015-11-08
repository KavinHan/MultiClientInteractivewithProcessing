
import muthesius.net.*;
import org.webbitserver.*;

WebSocketP5 socket;

// circles will save all clients data
ArrayList<Circle> circles = new ArrayList<Circle>();

void setup() {
  size(480, 640);
  socket = new WebSocketP5(this, 8080);
}

void draw() {
  background(0);
  
  fill(255, 0, 0);
  textSize(32);
  text(frameRate, 10, 40);
  
  // get now millis time
  int timestamp = millis();
  
  // if the last time of get data from client is lessthen 1.5s
  // then draw the client
  for (int i = 0; i < circles.size (); i++) {
    Circle circle = circles.get(i);
    if (timestamp - circle.timestamp < 1500) {
      circle.draw();
    }
  }
  // send all clients data to all clients
  sendToClients();
}

void sendToClients() {
  // get now millis time
  int timestamp = millis();
  
  // valid clients array
  JSONArray datas = new JSONArray();
  
  // just send valid client data to all clients
  // if the last time of get data from client is less than 1.5s, It's invalid
  int sendObjCount = 0;
  for (int i = 0; i < circles.size (); i++) {
    Circle circle = circles.get(i);
    if (timestamp - circle.timestamp < 1500) {
      // create valid client object
      JSONObject client = new JSONObject();
      // get processing color and set to a string
      String c = "rgb("+int(red(circle.c))+","+int(green(circle.c))+","+int(blue(circle.c))+")";
      client.setString("color", c);
      // get x
      client.setFloat("x", circle.x);
      // get y
      client.setFloat("y", circle.y);
      // get radius
      client.setInt("radius", circle.radius);
      // push this client to valid clients array
      datas.setJSONObject(sendObjCount, client);
      sendObjCount++;
    }
  }
  // if valid device count greaterthan 0, send clients data to all clients
  if (sendObjCount > 0) {
    println("sen datas length: "+datas.size());
    socket.broadcast(datas.toString());
  }
}

// if get data from client
void websocketOnMessage(WebSocketConnection con, String msg) {
  // parse string to json object
  JSONObject json = parseJSONObject(msg);
  
  if (json == null) {
    // if not json object
    println("JSONObject could not be parsed");
  } else {
    // if valid json object
    // if type is "ping", mean get data from ping timer
    // if type is "draw", mean get data from mouse or touch event
    String type = json.getString("type");
    // get client unique id
    String id = json.getString("id");
    println("Get id: "+id+",,,,type:"+type);
    // now time millis time
    int timestamp = millis();
    int i;
    // push -> true: push this client to clients
    // push -> false: already update this client, this client is exist client
    boolean bPush = true;
    
    for (i = 0; i < circles.size (); i++) {
      Circle circle = circles.get(i);

      if (id.equals(circle.id)) {
        println("update timestamp success....");
        circle.timestamp = timestamp;
        if (type.equals("draw")) {
          // update current client coordinate
          circle.x = json.getFloat("x");
          circle.y = json.getFloat("y");
        }
        bPush = false; // already update, so set to false, will not push
        break;
      }
    }
    // if not exist this client then push to clients
    if (bPush) {
      println("will push new client,,,,,"+bPush);
      circles.add(new Circle(id, timestamp));
    }
  }
}

void websocketOnOpen(WebSocketConnection con) {
  println("A client joined");
}

void websocketOnClosed(WebSocketConnection con) {
  println("A client left");
}

