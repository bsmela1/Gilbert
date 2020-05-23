extends Node2D

export (PackedScene) onready var gilbert
var instancjaGilberta

func do_maina():
	$Gilbert.queue_free()
	
func hitted_by_mob():
	$Gilbert.queue_free()
	"""
	if instancjaGilberta:
		instancjaGilberta.queue_free()
	instancjaGilberta = gilbert.instance()
	instancjaGilberta.position = $PozycjaRespa.position
	add_child(instancjaGilberta)
	"""
