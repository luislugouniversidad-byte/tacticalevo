extends Node3D

@export var zoom_min: float = 5.0
@export var zoom_max: float = 50.0
@export var zoom_step: float = 1.5

var cam: Camera3D
var grid: Node3D
var cursor: Node3D
var unit_scene: PackedScene
var selected_unit = null
var unit_info: CanvasLayer
var turn_manager: Node
var turn_indicator: CanvasLayer
var all_units: Array = []
var game_started: bool = false

func _ready():
	cam = $Camera3D
	cam.position = Vector3(18, 18, 18)
	cam.look_at(Vector3.ZERO)

	grid = $HexGrid3D
	unit_scene = preload("res://scenes/unit.tscn")

	var cursor_script = preload("res://scripts/cursor_3d.gd")
	cursor = cursor_script.new()
	cursor.name = "Cursor3D"
	cursor.grid_ref = grid
	add_child(cursor)
	cursor.confirmed.connect(_try_select)
	cursor.cancelled.connect(_on_cursor_cancelled)

	var ui_script = preload("res://scripts/ui/unit_info.gd")
	unit_info = ui_script.new()
	unit_info.name = "UnitInfo"
	add_child(unit_info)

	var creator_script = preload("res://scripts/ui/unit_creator.gd")
	var creator = creator_script.new()
	creator.name = "UnitCreator"
	add_child(creator)
	creator.setup(grid, unit_scene)

	turn_manager = preload("res://scripts/turn_manager.gd").new()
	turn_manager.name = "TurnManager"
	add_child(turn_manager)

	turn_indicator = preload("res://scripts/ui/turn_indicator.gd").new()
	turn_indicator.name = "TurnIndicator"
	add_child(turn_indicator)

	turn_manager.turn_changed.connect(_on_turn_changed)

func _start_game():
	if game_started:
		return
	game_started = true
	all_units = get_tree().get_nodes_in_group("units")
	turn_manager.register_units(all_units)
	turn_indicator.show_turn(turn_manager.current_team, turn_manager.current_round)

func _input(event):
	if has_node("UnitCreator"):
		return
	if not game_started:
		_start_game()
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				cam.size = max(zoom_min, cam.size - zoom_step)
			MOUSE_BUTTON_WHEEL_DOWN:
				cam.size = min(zoom_max, cam.size + zoom_step)

	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_C:
				unit_info.toggle(selected_unit)
			KEY_A:
				if unit_info.visible_flag:
					unit_info.nav_left()
			KEY_S:
				if unit_info.visible_flag:
					unit_info.nav_right()
			KEY_E:
				_end_current_turn()

func _try_select() -> bool:
	var key = cursor.tile_key()
	var tile = grid.tile_at(key.x, key.y)
	if tile and tile.unit:
		var u = tile.unit
		if not turn_manager.is_team_active(u.team):
			return false
		if turn_manager.is_unit_acted(u):
			return false
		if selected_unit:
			selected_unit.deselect()
		selected_unit = u
		selected_unit.select()
		cursor.mark_selected()
		print(selected_unit.get_info())
		return true
	return false

func _on_cursor_cancelled():
	_try_deselect()
	unit_info.hide_ui()

func _try_deselect():
	if selected_unit:
		selected_unit.deselect()
		var pos = grid.axial_to_world(cursor.gq, cursor.gr)
		selected_unit.position = pos + Vector3(0, 0.3, 0)
		var old_tile = grid.tile_at(selected_unit.tile_pos.x, selected_unit.tile_pos.y)
		if old_tile:
			old_tile.unit = null
		selected_unit.tile_pos = Vector2i(cursor.gq, cursor.gr)
		var new_tile = grid.tile_at(cursor.gq, cursor.gr)
		if new_tile:
			new_tile.unit = selected_unit
		selected_unit = null
		cursor.mark_idle()

func _on_turn_changed(_team: int):
	for u in all_units:
		u.mark_ready()
	turn_indicator.show_turn(turn_manager.current_team, turn_manager.current_round)

func _end_current_turn():
	if selected_unit:
		selected_unit.mark_acted()
		_try_deselect()
	turn_manager.end_unit_turn()
	turn_indicator.show_turn(turn_manager.current_team, turn_manager.current_round)
	var next = turn_manager.get_current_unit()
	if next:
		cursor.move_to_axial(next.tile_pos.x, next.tile_pos.y)

func _process(_delta):
	if selected_unit:
		var pos = grid.axial_to_world(cursor.gq, cursor.gr)
		selected_unit.position = pos + Vector3(0, 0.3, 0)
