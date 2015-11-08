class Circle {
  String id        = "";  // unique id
  float  x         = 0.5; // x coordinate
  float  y         = 0.5; // y coordinate
  int    timestamp = 0;   // last update millis time
  color  c;               // this circle color
  int    radius;          // this circle radius
  Circle(String _id, int _timestamp) {
    id         = _id;
    timestamp  = _timestamp;
    c          = color(int(random(255)), int(random(255)), int(random(255)));
    radius     = int(random(30)) + 30;
  };
  
  void draw() {
    fill(c);
    ellipse(int(x*width), int(y*height), radius, radius);
  }
};

