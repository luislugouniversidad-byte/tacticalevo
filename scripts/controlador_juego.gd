extends Node3D

@export var zoom_min: float = 5.0
@export var zoom_max: float = 50.0
@export var zoom_step: float = 1.5

const THIRD_PERSON_DIST: float = 4.24
const THIRD_PERSON_HEIGHT: float = 2.5

var cam: Camera3D
var cam_third: Camera3D
var grid: Node3D
var cursor: Node3D
var unit_scene: PackedScene
var selected_unit = null
var unit_info: CanvasLayer
var turn_manager: Node
var turn_indicator: CanvasLayer
var all_units: Array = []
var game_started: bool = false

var orbit_angle: float = 225.0

var hex_dirs = [Vector2i(1, 0), Vector2i(1, -1), Vector2i(0, -1), Vector2i(-1, 0), Vector2i(-1, 1), Vector2i(0, 1)]
var hex_world_dirs: Array[Vector3] = []

func _ready():
	cam = $Camera3D
	cam.position = Vector3(18, 18, 18)
	cam.look_at(Vector3.ZERO)

	cam_third = Camera3D.new()
	cam_third.name = "CameraThird"
	cam_third.projection = Camera3D.PROJECTION_PERSPECTIVE
	cam_third.current = false
	add_child(cam_third)

	grid = $HexGrid3D

	for d in hex_dirs:
		hex_world_dirs.append(grid.axial_to_world(d.x, d.y).normalized())
	unit_scene = preload("res://scenes/unidad.tscn")

	var cursor_script = preload("res://scripts/cursor.gd")
	cursor = cursor_script.new()
	cursor.name = "Cursor3D"
	cursor.grid_ref = grid
	add_child(cursor)
	cursor.confirmed.connect(_try_select)
	cursor.cancelled.connect(_on_cursor_cancelled)

	var ui_script = preload("res://scripts/ui/info_unidad.gd")
	unit_info = ui_script.new()
	unit_info.name = "UnitInfo"
	add_child(unit_info)

	var creator_script = preload("res://scripts/ui/creador_unidades.gd")
	var creator = creator_script.new()
	creator.name = "UnitCreator"
	add_child(creator)
	creator.setup(grid, unit_scene)

	turn_manager = preload("res://scripts/gestor_turnos.gd").new()
	turn_manager.name = "TurnManager"
	add_child(turn_manager)

	turn_indicator = preload("res://scripts/ui/indicador_turnos.gd").new()
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
			KEY_X:
				if selected_unit:
					_try_deselect()
			KEY_Q:
				if selected_unit:
					_orbit_camera(15.0)
			KEY_E:
				if selected_unit:
					_orbit_camera(-15.0)
				else:
					_end_current_turn()
			KEY_W, KEY_S, KEY_A, KEY_D:
				if selected_unit:
					_move_wasd(event.keycode)
				elif unit_info.visible_flag:
					match event.keycode:
						KEY_A: unit_info.nav_left()
						KEY_D: unit_info.nav_right()

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
		_enter_third_person()
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
		_exit_third_person()
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

func _enter_third_person():
	cursor.input_enabled = false
	orbit_angle = 225.0
	var offset = _get_third_person_offset()
	cam_third.global_position = selected_unit.global_position + offset
	cam_third.look_at(selected_unit.global_position + Vector3(0, 0.5, 0))
	cam.current = false
	cam_third.current = true

func _exit_third_person():
	cursor.input_enabled = true
	cam_third.current = false
	cam.current = true

func _get_third_person_offset() -> Vector3:
	var a = deg_to_rad(orbit_angle)
	return Vector3(sin(a) * THIRD_PERSON_DIST, THIRD_PERSON_HEIGHT, cos(a) * THIRD_PERSON_DIST)

func _move_wasd(keycode: int):
	var a = deg_to_rad(orbit_angle)
	var forward = Vector3(-sin(a), 0, -cos(a)).normalized()
	match keycode:
		KEY_W: pass
		KEY_S: forward = -forward
		KEY_A: forward = Vector3(-forward.z, 0, forward.x)
		KEY_D: forward = Vector3(forward.z, 0, -forward.x)

	var best_dot = -INF
	var best_dir = Vector2i(0, 0)
	for i in hex_dirs.size():
		var dot = forward.dot(hex_world_dirs[i])
		if dot > best_dot:
			best_dot = dot
			best_dir = hex_dirs[i]

	var nq = cursor.gq + best_dir.x
	var nr = cursor.gr + best_dir.y
	if _cursor_in_bounds(nq, nr):
		cursor.gq = nq
		cursor.gr = nr
		cursor._update_position()

func _orbit_camera(delta_deg: float):
	orbit_angle = fmod(orbit_angle + delta_deg, 360.0)
	if orbit_angle < 0:
		orbit_angle += 360.0

func _cursor_in_bounds(q: int, r: int) -> bool:
	return cursor._is_in_bounds(q, r)

func _process(delta):
	if selected_unit:
		var pos = grid.axial_to_world(cursor.gq, cursor.gr)
		selected_unit.position = pos + Vector3(0, 0.3, 0)
		if cam_third.current:
			var offset = _get_third_person_offset()
			var target = selected_unit.global_position + offset
			cam_third.global_position = cam_third.global_position.lerp(target, delta * 10.0)
			cam_third.look_at(selected_unit.global_position + Vector3(0, 0.5, 0))
