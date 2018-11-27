# from pythonosc import dispatcher
# from pythonosc import osc_server
#
# def position_func(addr,msg):
#     print(addr,msg)
#
# dispatch = dispatcher.Dispatcher()
# dispatch.map("/position", position_func)
#
# addr=("0.0.0.0", 5000)
#
# server = osc_server.ForkingOSCUDPServer(addr,dispatch)
# server.serve_forever()



from pythonosc import dispatcher
from pythonosc import osc_server
from gpiozero import LED
from time import sleep

led_1 = LED(26)
led_2 = LED(13)
led_3 = LED(6)

def position_func(addr,msg):
    if msg == 'a':
        led_1.on()
        sleep(0.3)
        led_1.off()
        sleep(0.3)
    elif msg == 's':
        led_2.on()
        sleep(0.3)
        led_2.off()
        sleep(0.3)
    elif msg == 'd':
        led_3.on()
        sleep(0.3)
        led_3.off()
        sleep(0.3)
    else:
        led_1.off()
        sleep(0.3)
        led_2.off()
        sleep(0.3)
        led_3.off()
        sleep(0.3)

    print(addr,msg)

dispatch = dispatcher.Dispatcher()
dispatch.map("/position", position_func)

addr=("0.0.0.0", 5000)

server = osc_server.ForkingOSCUDPServer(addr,dispatch)
server.serve_forever()
