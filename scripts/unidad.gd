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

var visual: Node3D

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

	var vis_script = preload("res://scripts/unidad_visual.gd")
	visual = vis_script.new()
	visual.name = "UnitVisual"
	add_child(visual)
	visual.build(self, race_name, team, hp_max)
	update_hp_bar()

func _build_collision():
	var shape = CollisionShape3D.new()
	var cyl = CylinderShape3D.new()
	cyl.radius = 0.35
	cyl.height = 0.5
	shape.shape = cyl
	add_child(shape)

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
	if visual:
		visual.select()

func deselect():
	if visual:
		visual.deselect()

func mark_acted():
	if visual:
		visual.mark_acted()

func mark_ready():
	if visual:
		visual.mark_ready()

func update_hp_bar():
	if visual:
		visual.update_hp_bar(hp_current, hp_max)
