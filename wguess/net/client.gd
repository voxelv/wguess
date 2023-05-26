extends Common
class_name Client
signal connection_status

const SERVER_IP := "73.96.232.30"
#const SERVER_IP := "localhost"

var socket := WebSocketClient.new()
var peer_id := -1

func _ready():
	print("Client setup")
	socket.connect("connection_closed", self, "closed")
	socket.connect("connection_error", self, "error")
	socket.connect("connection_established", self, "connected")
	socket.connect("data_received", self, "data")
	
	var url = "%s:%d" % [SERVER_IP, 9080]
	print("Connecting to: %s" % url)
	var err = socket.connect_to_url(url, ["godot"])
	if err != OK:
		print("Error: %d" % err)
	else:
		print("Connection started")

func _process(delta):
	socket.poll()

func closed(was_clean:bool=false):
	print("Connection Closed (%d), clean: %s" % [peer_id, was_clean])

func connected(proto:String):
	print("Connected with protocol: %s" % proto)
	call_deferred("emit_signal", "connection_status", OK)

func error():
	print("Connection Error")

func data():
	var data := socket.get_peer(1).get_var() as Dictionary
	handle_client_data(data)

func handle_client_data(data:Dictionary):
	if .handle(0, data):
		return
	
	match(data['type']):
		Format.TYPE.YOUR_UID:
			peer_id = data['id']

func send(id, data):
	socket.get_peer(id).put_var(data)

func send_print_string(s:String):
	send(1, Format.print_string("HELLO"))
