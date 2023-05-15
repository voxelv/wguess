extends Node
enum TYPE {PRINT_STRING}

func print_string(s:String) -> Dictionary:
	return {'type': TYPE.STRING, 'data': str(s)}
