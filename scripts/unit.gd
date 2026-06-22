extends StaticBody3D

var player: int = 0
var tile_pos: Vector2i
var level: int = 1
var piece_principal: int = Enums.Stat.FUE

var race_name: String = "Humano"
var unit_class: String = "Guerrero"
var office_name: String = ""

var team: int = 0

var stats_final: Dictionary = {}
var hp_max: int = 100
var hp_current: int = 100

var ring: MeshInstance3D
var ring_mat: StandardMaterial3D
var ring_color_idle = Color(1, 1, 0.6, 0.7)
var ring_color_acted = Color(0.4, 0.4, 0.4, 0.5)
var hp_bar_bg: MeshInstance3D
var hp_bar_fg: MeshInstance3D
var team_colors = [
	Color(0.15, 0.4, 0.9),   # 0 = Azul
	Color(0.9, 0.15, 0.15),  # 1 = Rojo
]

func setup(pid: int, pos: Vector2i, race: String = "Humano", cls: String = "Guerrero", pstat: int = Enums.Stat.FUE, lvl: int = 1, ofc: String = "", pteam: int = 0):
	player = pid
	tile_pos = pos
	race_name = race
	unit_class = cls
	piece_principal = pstat
	level = lvl
	office_name = ofc
	team = pteam
	collision_layer = 2

	stats_final = StatCalculator.calculate(race_name, unit_class, piece_principal, level, {}, {})
	hp_max = StatCalculator.calculate_hp(stats_final.get(Enums.Stat.CON, 10))
	hp_current = hp_max

	add_to_group("units")
	_build_collision()
	_build_visual()

func _build_collision():
	var shape = CollisionShape3D.new()
	var cyl = CylinderShape3D.new()
	cyl.radius = 0.35
	cyl.height = 0.5
	shape.shape = cyl
	add_child(shape)

func _build_visual():
	var shade = team_colors[team]

	var base = MeshInstance3D.new()
	var bm = CylinderMesh.new()
	bm.top_radius = 0.35
	bm.bottom_radius = 0.35
	bm.height = 0.08
	bm.radial_segments = 12
	base.mesh = bm
	var bmat = StandardMaterial3D.new()
	bmat.albedo_color = shade
	base.material_override = bmat
	base.position = Vector3(0, 0.04, 0)
	add_child(base)

	var torso = MeshInstance3D.new()
	var cm = CylinderMesh.new()
	cm.top_radius = 0.12
	cm.bottom_radius = 0.25
	cm.height = 0.35
	cm.radial_segments = 10
	torso.mesh = cm
	var cmat = StandardMaterial3D.new()
	cmat.albedo_color = shade.lightened(0.15)
	torso.material_override = cmat
	torso.position = Vector3(0, 0.22, 0)
	add_child(torso)

	var head = MeshInstance3D.new()
	var sm = SphereMesh.new()
	sm.radius = 0.1
	sm.height = 0.2
	head.mesh = sm
	var smat = StandardMaterial3D.new()
	smat.albedo_color = shade.lightened(0.3)
	head.material_override = smat
	head.position = Vector3(0, 0.4, 0)
	add_child(head)

	ring = MeshInstance3D.new()
	var torus = TorusMesh.new()
	torus.inner_radius = 0.38
	torus.outer_radius = 0.42
	torus.rings = 8
	ring_mat = StandardMaterial3D.new()
	ring_mat.albedo_color = ring_color_idle
	ring_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	ring.material_override = ring_mat
	ring.position = Vector3(0, 0.01, 0)
	ring.visible = false
	add_child(ring)

	_build_hp_bar()

func _build_hp_bar():
	var bar_width = 0.5
	var bar_height = 0.04
	var bar_y = 0.62

	# Background (dark)
	hp_bar_bg = MeshInstance3D.new()
	var bgm = BoxMesh.new()
	bgm.size = Vector3(bar_width, bar_height, 0.06)
	bgm.material = _make_bar_mat(Color(0.15, 0.15, 0.15))
	hp_bar_bg.mesh = bgm
	hp_bar_bg.position = Vector3(0, bar_y, 0)
	add_child(hp_bar_bg)

	# Foreground (colored)
	hp_bar_fg = MeshInstance3D.new()
	var fgm = BoxMesh.new()
	fgm.size = Vector3(bar_width, bar_height, 0.065)
	fgm.material = _make_bar_mat(Color(0.2, 0.9, 0.2))
	hp_bar_fg.mesh = fgm
	hp_bar_fg.position = Vector3(0, bar_y, 0)
	add_child(hp_bar_fg)

	update_hp_bar()

func _make_bar_mat(color: Color) -> StandardMaterial3D:
	var m = StandardMaterial3D.new()
	m.albedo_color = color
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	return m

func update_hp_bar():
	if not hp_bar_fg:
		return
	var pct = float(hp_current) / float(max(hp_max, 1))
	pct = clamp(pct, 0.0, 1.0)
	var w = 0.5 * pct
	var bx = (0.5 - w) / 2.0
	var fgm = hp_bar_fg.mesh as BoxMesh
	if fgm:
		fgm.size.x = 0.5 * pct
	hp_bar_fg.position.x = bx

	var color: Color
	if pct > 0.6:
		color = Color(0.2, 0.9, 0.2)
	elif pct > 0.3:
		color = Color(0.9, 0.8, 0.2)
	else:
		color = Color(0.9, 0.2, 0.2)
	var mat = hp_bar_fg.material_override as StandardMaterial3D
	if mat:
		mat.albedo_color = color

func get_stat(s: int) -> int:
	return stats_final.get(s, 0)

func get_hp_str() -> String:
	return "%d / %d" % [hp_current, hp_max]

func get_info() -> String:
	var team_name = "Azul" if team == 0 else "Rojo"
	var info = "%s %s [%s]\n" % [race_name, unit_class, team_name]
	if office_name:
		info += "Oficio: %s\n" % office_name
	info += "Nv.%d | HP: %s\n" % [level, get_hp_str()]
	for s in Enums.ALL_STATS:
		var abbr = Enums.STAT_ABBREV.get(s, "??")
		info += "%s: %d  " % [abbr, get_stat(s)]
	return info

func select():
	if ring:
		ring.visible = true

func deselect():
	if ring:
		ring.visible = false

func mark_acted():
	if ring_mat:
		ring_mat.albedo_color = ring_color_acted

func mark_ready():
	if ring_mat:
		ring_mat.albedo_color = ring_color_idle
