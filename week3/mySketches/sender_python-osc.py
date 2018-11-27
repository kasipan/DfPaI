from  pythonosc import udp_client

ip,port = '192.168.43.61',5000

client = udp_client.SimpleUDPClient(ip,port)

msg = input()
client.send_message("/position", msg)
print('sent {} to {}'.format(msg,ip))
