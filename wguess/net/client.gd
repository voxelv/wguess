extends Node
class_name Client
signal connection_status

var socket := WebSocketClient.new()
var peer_id := -1

func _ready():
	socket.connect("connection_closed", self, "closed")
	socket.connect("connection_error", self, "error")
	socket.connect("connection_established", self, "connected")
	socket.connect("data_received", self, "data")
	
	var err = socket.connect_to_url("%s:%d" % ["73.96.232.30", 9080])
	if err == OK:
		emit_signal("connection_status", OK)

func closed(was_clean:bool=false):
	print("Connection Closed (%d), clean: %s" % [peer_id, was_clean])

func connected(proto:String):
	print("Connected: (%s)" % proto)

func error():
	print("Connection Error")

func data():
	var data := socket.get_peer(1).get_var() as Dictionary
	handle(data)

func handle(data:Dictionary):
	print(str(data))
