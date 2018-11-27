add_library('webSockets')

WebsocketServer server  #problem


def setup():
    size(500,500)
    server = new WebsocketServer(this, 8889, "/data")

def draw():
    background(0)
  
def webSocketServerEvent(String msg):
    println(msg)
