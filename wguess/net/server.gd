extends Common
class_name Server

var socket := WebSocketServer.new()
var clients := {}

func _ready():
	socket.connect("client_close_request", self, "client_closed")
	socket.connect("client_disconnected", self, "client_disconnected")
	socket.connect("client_connected", self, "client_connected")
	socket.connect("data_received", self, "data")
	
	var port = 9080
	var err = socket.listen(port, ["godot"])
	if err != OK:
		print("Server could not listen on port %d ..." % port)
	else:
		print("Server listening on port %d" % port)

func _process(delta):
	socket.poll()

func client_closed(id, code, reason):
	var s := "Client %d disconnecting with code: %d, reason: %s" % [id, code, reason]

func client_connected(id, proto):
	print("Client %d connected with protocol: %s" % [id, proto])
	clients[id] = "UNKNOWN"
	send(id, Format.your_uid(id))
	send(id, Format.print_string("ID: %d assigned by server" % id))

func client_disconnected(id, was_clean = false):
	var s := "Client %d disconnected, clean: %s" % [id, str(was_clean)]

func data(id):
	var data := socket.get_peer(id).get_var() as Dictionary
	handle(id, data)

func remove_client(id):
	clients.erase(id)

func handle(id, data:Dictionary):
	if .handle(id, data):
		return

func send(id, data:Dictionary):
	socket.get_peer(id).put_var(data)

func broadcast(data:Dictionary):
	if data.empty():
		return
	
	for id in clients.keys():
		send(id, data)
