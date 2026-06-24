extends Node3D

@export var grid_radius: int = 15
@export var tile_size: float = 1.0
@export var tile_height: float = 0.3

var tiles: Dictionary = {}
var tile_container: Node3D
var zone_glow_meshes: Array = []
var _glow_time: float = 0.0

var zone_centers = [
	Vector2i(0, 0),
	Vector2i(9, 0),
	Vector2i(0, 9),
	Vector2i(-9, 9),
	Vector2i(-9, 0),
	Vector2i(0, -9),
	Vector2i(9, -9),
]

var zone_offsets = [
	Vector2i(1, 0), Vector2i(-1, 0),
	Vector2i(0, 1), Vector2i(0, -1),
	Vector2i(1, -1), Vector2i(-1, 1),
]

func _ready():
	tile_container = Node3D.new()
	tile_container.name = "Tiles"
	add_child(tile_container)
	generate_grid()

func generate_grid():
	var max_d = grid_radius - 1
	var sqrt3 = sqrt(3.0)
	var x_spacing = sqrt3 * tile_size
	var z_spacing = 1.5 * tile_size

	var zone_set = {}
	for c in zone_centers:
		zone_set[c] = true
		for o in zone_offsets:
			zone_set[c + o] = false

	for q in range(-max_d, max_d + 1):
		var r_min = max(-max_d, -q - max_d)
		var r_max = min(max_d, -q + max_d)
		for r in range(r_min, r_max + 1):
			var x = x_spacing * q + x_spacing * 0.5 * r
			var z = z_spacing * r

			var body = StaticBody3D.new()
			body.name = "Tile_%d_%d" % [q, r]
			body.collision_layer = 1

			var mi = MeshInstance3D.new()
			var cylinder = CylinderMesh.new()
			cylinder.top_radius = tile_size
			cylinder.bottom_radius = tile_size
			cylinder.height = tile_height
			cylinder.radial_segments = 6
			mi.mesh = cylinder
			mi.rotate_y(deg_to_rad(30))

			var mat = StandardMaterial3D.new()
			mat.albedo_color = _tile_color(q, r, zone_set)
			mi.material_override = mat

			body.add_child(mi)

			var col = CollisionShape3D.new()
			var cyl_shape = CylinderShape3D.new()
			cyl_shape.radius = tile_size * 0.48
			cyl_shape.height = 0.05
			col.shape = cyl_shape
			body.add_child(col)

			body.position = Vector3(x, 0, z)
			tile_container.add_child(body)

			var key = Vector2i(q, r)
			var zc = zone_set.get(key)
			tiles[key] = {
				"body": body,
				"node": mi,
				"q": q, "r": r,
				"pos": body.position,
				"dist": max(abs(q), abs(r), abs(-q - r)),
				"is_zone_core": zc == true,
				"is_zone_adj": zc == false,
				"unit": null,
			}

			if zc == true:
				_highlight_zone(mi, body)

func _tile_color(q: int, r: int, zone_set: Dictionary) -> Color:
	var key = Vector2i(q, r)
	var zc = zone_set.get(key)
	if zc == true:
		return Color(0.9, 0.7, 0.2, 1.0)
	if zc == false:
		return Color(0.5, 0.9, 0.3, 1.0)
	var alt = (q + r) % 2 == 0
	return Color(0.25, 0.35, 0.45, 1.0) if alt else Color(0.2, 0.28, 0.38, 1.0)

func _highlight_zone(mesh: MeshInstance3D, parent: Node3D):
	var pos = mesh.position
	# Emissive glow on the tile mesh
	var tile_mat = mesh.material_override
	if tile_mat:
		tile_mat.emission_enabled = true
		tile_mat.emission = Color(1.0, 0.85, 0.2)
		tile_mat.emission_energy_multiplier = 0.5
		zone_glow_meshes.append(mesh)

	# Rings
	var ring_mats = []
	for i in 3:
		var ring = MeshInstance3D.new()
		var torus = TorusMesh.new()
		torus.inner_radius = tile_size * (0.85 + i * 0.08)
		torus.outer_radius = tile_size * (0.95 + i * 0.08)
		torus.rings = 6
		var glow = StandardMaterial3D.new()
		glow.albedo_color = Color(1.0, 0.85, 0.3, 0.6 - i * 0.15)
		glow.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		glow.emission_enabled = true
		glow.emission = Color(1.0, 0.8, 0.2)
		ring.material_override = glow
		ring.position = pos + Vector3(0, 0.02 * (i + 1), 0)
		parent.add_child(ring)
		ring_mats.append(glow)
		zone_glow_meshes.append(ring)

func _process(delta):
	_glow_time += delta
	var pulse = 0.5 + 0.5 * sin(_glow_time * 1.5)
	for m in zone_glow_meshes:
		if m and m.material_override:
			m.material_override.emission_energy_multiplier = 0.3 + 0.7 * pulse

func tile_at(q: int, r: int) -> Dictionary:
	return tiles.get(Vector2i(q, r))

func axial_to_world(q: int, r: int) -> Vector3:
	var sqrt3 = sqrt(3.0)
	var x = sqrt3 * tile_size * q + sqrt3 * tile_size * 0.5 * r
	var z = 1.5 * tile_size * r
	return Vector3(x, 0, z)
