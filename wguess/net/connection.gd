extends Node

var client:Client = null
var server:Server = null

func _ready():
	if "SERVER" in OS.get_cmdline_args():
		print("Server starting...")
		server = Server.new()
		add_child(server)
	else:
		client = Client.new()
		print("Client starting...")
		add_child(client)

