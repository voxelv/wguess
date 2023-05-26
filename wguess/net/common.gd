extends Node
class_name Common

func handle(id, data:Dictionary)->bool:
	var handled := false
	match data['type']:
		Format.TYPE.PRINT_STRING:
			print("[%d]: %s" % [id, str(data['data'])])
			handled = true
	return handled
