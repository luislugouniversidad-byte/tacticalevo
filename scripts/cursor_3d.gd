extends Node3D

var gq: int = 0
var gr: int = 0

var grid_ref: Node3D
var hex_size: float

var hex_mesh: MeshInstance3D
var ring_mesh: MeshInstance3D
var mat_idle: StandardMaterial3D
var mat_selected: StandardMaterial3D

func _ready():
	grid_ref = get_parent().get_node("HexGrid3D")
	hex_size = grid_ref.tile_size

	mat_idle = StandardMaterial3D.new()
	mat_idle.albedo_color = Color(1, 1, 1, 0.4)
	mat_idle.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA

	mat_selected = StandardMaterial3D.new()
	mat_selected.albedo_color = Color(1, 0, 0, 0.5)
	mat_selected.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA

	var hex_cyl = CylinderMesh.new()
	hex_cyl.top_radius = hex_size * 0.42
	hex_cyl.bottom_radius = hex_size * 0.42
	hex_cyl.height = hex_size * 0.2
	hex_cyl.radial_segments = 6
	hex_mesh = MeshInstance3D.new()
	hex_mesh.mesh = hex_cyl
	hex_mesh.material_override = mat_idle
	hex_mesh.rotate_y(deg_to_rad(30))
	hex_mesh.position = Vector3(0, hex_size * 0.1, 0)
	add_child(hex_mesh)

	var torus = TorusMesh.new()
	torus.inner_radius = hex_size * 0.42
	torus.outer_radius = hex_size * 0.48
	torus.rings = 8
	var ring_mat = StandardMaterial3D.new()
	ring_mat.albedo_color = Color(1, 1, 1, 1)
	ring_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	ring_mesh = MeshInstance3D.new()
	ring_mesh.mesh = torus
	ring_mesh.material_override = ring_mat
	ring_mesh.position = Vector3(0, hex_size * 0.25, 0)
	add_child(ring_mesh)

	_update_position()

func _input(event):
	if not (event is InputEventKey and event.pressed):
		return
	var nq = gq
	var nr = gr
	match event.keycode:
		KEY_RIGHT:
			nq += 1
		KEY_LEFT:
			nq -= 1
		KEY_UP:
			nr -= 1
		KEY_DOWN:
			nr += 1
	if _is_in_bounds(nq, nr):
		gq = nq
		gr = nr
		_update_position()

func _is_in_bounds(q: int, r: int) -> bool:
	var md = grid_ref.grid_radius - 1
	return abs(q) <= md and abs(r) <= md and abs(q + r) <= md

func _update_position():
	var pos = grid_ref.axial_to_world(gq, gr)
	position = pos + Vector3(0, 0, 0)

func tile_key() -> Vector2i:
	return Vector2i(gq, gr)

func move_to_axial(q: int, r: int):
	if _is_in_bounds(q, r):
		gq = q
		gr = r
		_update_position()

func mark_selected():
	hex_mesh.material_override = mat_selected

func mark_idle():
	hex_mesh.material_override = mat_idle
