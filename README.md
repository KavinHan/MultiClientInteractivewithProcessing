# MultiClientInteractivewithProcessing
Multi client interactive with processing websocket server

## Introduction
- **Http server** and **websocket server** all run in processing
- http url is ``` http://IP:PORT ```
- websocket url is ``` http://IP:PORT/p5websocket ```, default channel is ```p5websocket```

## Run step:
- copy ```project\libraries\websocketP5``` folder to ```C:\Users\username\Documents\Processing\libraries\```
- open and run server file: ``` MultiClientInteractive.pde ```
- client url is : ``` http://IP:PORT ```
- check IP: ``` cmd => ipconfig /all ```
- check port: *(open MultiClientInteractive.pde file)*
 ```
  void setup() {
    size(480, 640);
    socket = new WebSocketP5(this, 8080); // 8080 is port number
  }
  ```
- open client url in browser
- click connect button on browser
- touch move or mouse click move on black area.

## Error
- if port number already use, change port number at ``` MultiClientInteractive.pde ``` file and change ``` http://IP:PORT ``` port number.

## Websocket library for processing
- [WebSocketP5](https://github.com/muthesius/WebSocketP5)
