extends Node

signal turn_changed(team: int)
signal round_changed(round_num: int)
signal all_teams_ready

var units_azul: Array = []
var units_rojo: Array = []
var acted_this_turn: Dictionary = {}

var current_team: int = 0
var current_round: int = 1
var current_unit_idx: int = 0

func get_active_units() -> Array:
	return units_azul if current_team == 0 else units_rojo

func get_current_unit():
	var list = get_active_units()
	if current_unit_idx < list.size():
		return list[current_unit_idx]
	return null

func register_units(all_units: Array):
	units_azul.clear()
	units_rojo.clear()
	for u in all_units:
		if u.team == 0:
			units_azul.append(u)
		else:
			units_rojo.append(u)
	_clear_acted()

func _clear_acted():
	acted_this_turn = {}
	for u in units_azul + units_rojo:
		acted_this_turn[u] = false

func end_unit_turn():
	var u = get_current_unit()
	if u:
		acted_this_turn[u] = true
	current_unit_idx += 1
	if current_unit_idx >= get_active_units().size():
		_end_team_turn()

func _end_team_turn():
	current_team = 1 if current_team == 0 else 0
	current_unit_idx = 0
	_clear_acted()
	if current_team == 0:
		current_round += 1
		emit_signal("round_changed", current_round)
	emit_signal("turn_changed", current_team)

func is_team_active(team: int) -> bool:
	return team == current_team

func all_acted() -> bool:
	for u in get_active_units():
		if not acted_this_turn.get(u, false):
			return false
	return true

func is_unit_acted(u) -> bool:
	return acted_this_turn.get(u, false)
