extends Node

var client:Client = null
var server:Server = null

func _ready():
	if "SERVER" in OS.get_cmdline_args():
		print("Server starting...")
		server = Server.new()

