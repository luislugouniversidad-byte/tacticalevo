class_name UnitFactory

static func create_unit(unit_scene: PackedScene, grid: Node3D,
		pid: int, pos: Vector2i, race: String, cls: String,
		pstat: int, lvl: int, ofc: String, team: int) -> Node3D:
	var unit = unit_scene.instantiate()
	unit.setup(pid, pos, race, cls, pstat, lvl, ofc, team)
	var wpos = grid.axial_to_world(pos.x, pos.y)
	unit.position = wpos + Vector3(0, 0.3, 0)
	grid.add_child(unit)
	var tile_data = grid.tile_at(pos.x, pos.y)
	if tile_data:
		tile_data.unit = unit
	return unit

static func clear_units(units: Array, grid: Node3D):
	for u in units:
		var td = grid.tile_at(u.tile_pos.x, u.tile_pos.y)
		if td:
			td.unit = null
		u.queue_free()
	units.clear()
