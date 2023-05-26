extends Node

const valid_keys = [
"joy cuddlebug newborn",
"wonder blessing arrival",
"arrival cuddlebug snuggles",
"newborn joy treasure",
"cuddlebug wonder cutie",
"cutie wonder bundle",
"precious cutie snuggles",
"blessing cutie wonder",
"cutie miracle cuddlebug",
"precious snuggles sweetheart",
"newborn snuggles cutie",
"treasure joy arrival",
"wonder blessing treasure",
"wonder bundle miracle",
"wonder joy cuddlebug",
"miracle joy cuddlebug",
"treasure miracle arrival",
"arrival cutie wonder",
"newborn cutie wonder",
"treasure blessing joy",
"bundle cutie snuggles",
"blessing bundle newborn",
"blessing miracle snuggles",
"bundle wonder sweetheart",
"snuggles joy blessing",
"arrival bundle treasure",
"sweetheart cutie wonder",
"cuddlebug joy snuggles",
"precious wonder arrival",
"snuggles wonder cuddlebug",
"arrival bundle snuggles",
"miracle wonder sweetheart",
"blessing miracle arrival",
"arrival cutie blessing",
"cutie bundle treasure"
]
var key_to_id := {}

onready var key_input : LineEdit = $"%key_input"
onready var result : Label = $"%result"
onready var send_hello_btn : Button = $"%send_hello_btn"

func _ready():
	for i in range(len(valid_keys)):
		key_to_id[valid_keys[i]] = i
	key_input.connect("text_entered", self, "_on_key_entered")
	send_hello_btn.connect("pressed", self, "_on_send_hello_btn_pressed")
	if Connection.client != null:
		Connection.client.connect("connection_status", self, "set_connection_status")

func _on_key_entered(key:String):
	if key in valid_keys:
		result.text = "SUCCESS"
	else:
		result.text = "FAILURE"

func set_connection_status(status):
	if status == OK:
		$"%connection_status".color = Color.green
	else:
		$"%connection_status".color = Color.red

func _on_send_hello_btn_pressed():
	if Connection.client != null:
		Connection.client.send_print_string("HELLO")
