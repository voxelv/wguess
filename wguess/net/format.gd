extends Node
enum TYPE {PRINT_STRING, YOUR_UID}

func print_string(s:String) -> Dictionary:
	return {'type': TYPE.PRINT_STRING, 'data': str(s)}

func your_uid(id:int) -> Dictionary:
	return {'type': TYPE.YOUR_UID, 'id': int(id)}
