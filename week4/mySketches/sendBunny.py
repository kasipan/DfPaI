from  pythonosc import udp_client

ip,port = '192.168.0.8',2345

client = udp_client.SimpleUDPClient(ip,port)

#msg = input()
msg = "[1,2,1]";
client.send_message("/position", msg)
print('sent {} to {}'.format(msg,ip))
