extends CanvasLayer

var grid_ref: Node3D
var unit_scene: PackedScene
var created_units: Array = []
var base_tiles: Array = []
var base_idx: int = 0

var panel: Panel
var race_dd: OptionButton
var class_dd: OptionButton
var piece_dd: OptionButton
var office_dd: OptionButton
var team_azul_btn: Button
var team_rojo_btn: Button
var create_btn: Button
var clear_btn: Button
var close_btn: Button
var list_container: VBoxContainer
var unit_count_label: Label

var focus_list: Array = []
var focus_idx: int = 0

var selected_team: int = 0

var humanoid_races = []
var class_list = []
var piece_list = []
var office_list = []

func _ready():
	humanoid_races = RaceData.get_group_races(RaceData.Group.HUMANOID)
	class_list = ClassData.get_class_names()
	piece_list = Enums.ALL_STATS
	office_list = OfficeData.get_office_names()
	_build_ui()
	focus_list = [race_dd, class_dd, piece_dd, office_dd, team_azul_btn, team_rojo_btn, create_btn, clear_btn, close_btn]
	race_dd.grab_focus()

func setup(grid: Node3D, scene: PackedScene):
	grid_ref = grid
	unit_scene = scene
	_calc_base_tiles()

func _calc_base_tiles():
	var zone = Vector2i(9, 0)
	base_tiles = [zone]
	var offsets = [Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1), Vector2i(1,-1), Vector2i(-1,1)]
	for o in offsets:
		var nt = zone + o
		var td = grid_ref.tile_at(nt.x, nt.y)
		if td:
			base_tiles.append(nt)

func _build_ui():
	panel = Panel.new()
	panel.anchor_left = 0.1
	panel.anchor_right = 0.9
	panel.anchor_top = 0.05
	panel.anchor_bottom = 0.95
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.06, 0.06, 0.12, 0.97)
	style.corner_radius_top_left = 10
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10
	style.set_content_margin_all(16)
	add_child(panel)

	var outer = VBoxContainer.new()
	outer.anchor_left = 0.0
	outer.anchor_right = 1.0
	outer.anchor_top = 0.0
	outer.anchor_bottom = 1.0
	panel.add_child(outer)

	var title = Label.new()
	title.text = "CREACIÓN DE UNIDADES"
	title.add_theme_font_size_override("font_size", 24)
	title.add_theme_color_override("font_color", Color(0.9, 0.9, 1.0))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	outer.add_child(title)

	var sep = HSeparator.new()
	sep.add_theme_color_override("default_color", Color(0.3, 0.3, 0.5))
	outer.add_child(sep)

	# Selectors grid
	var grid_container = GridContainer.new()
	grid_container.columns = 3
	grid_container.add_theme_constant_override("h_separation", 16)
	grid_container.add_theme_constant_override("v_separation", 8)
	outer.add_child(grid_container)

	_add_selector(grid_container, "Raza:", humanoid_races, "race_dd")
	_add_selector(grid_container, "Clase:", class_list, "class_dd")
	_add_selector(grid_container, "Ficha:", piece_list, "piece_dd")
	piece_dd.select(0)

	_add_selector(grid_container, "Oficio:", office_list, "office_dd")

	# Team selector (Azul / Rojo)
	var team_lbl = Label.new()
	team_lbl.text = "Bando:"
	team_lbl.add_theme_color_override("font_color", Color(0.8, 0.8, 0.9))
	team_lbl.add_theme_font_size_override("font_size", 14)
	grid_container.add_child(team_lbl)

	var team_hb = HBoxContainer.new()
	team_hb.add_theme_constant_override("separation", 8)
	grid_container.add_child(team_hb)

	team_azul_btn = Button.new()
	team_azul_btn.text = "AZUL"
	team_azul_btn.add_theme_font_size_override("font_size", 14)
	team_azul_btn.add_theme_color_override("font_color", Color(0.5, 0.8, 1.0))
	team_azul_btn.pressed.connect(_on_team_azul)
	team_hb.add_child(team_azul_btn)

	team_rojo_btn = Button.new()
	team_rojo_btn.text = "ROJO"
	team_rojo_btn.add_theme_font_size_override("font_size", 14)
	team_rojo_btn.add_theme_color_override("font_color", Color(1.0, 0.5, 0.5))
	team_rojo_btn.pressed.connect(_on_team_rojo)
	team_hb.add_child(team_rojo_btn)

	_highlight_team()

	var spacer_team = Control.new()
	grid_container.add_child(spacer_team)

	# Buttons
	var btn_row = HBoxContainer.new()
	btn_row.alignment = BoxContainer.ALIGNMENT_CENTER
	btn_row.add_theme_constant_override("separation", 20)
	outer.add_child(btn_row)

	create_btn = Button.new()
	create_btn.text = "CREAR UNIDAD"
	create_btn.add_theme_font_size_override("font_size", 16)
	create_btn.add_theme_color_override("font_color", Color(0.2, 1.0, 0.2))
	create_btn.pressed.connect(_on_create)
	btn_row.add_child(create_btn)

	clear_btn = Button.new()
	clear_btn.text = "LIMPIAR"
	clear_btn.add_theme_font_size_override("font_size", 14)
	clear_btn.add_theme_color_override("font_color", Color(1.0, 0.5, 0.5))
	clear_btn.pressed.connect(_on_clear)
	btn_row.add_child(clear_btn)

	close_btn = Button.new()
	close_btn.text = "CERRAR y JUGAR"
	close_btn.add_theme_font_size_override("font_size", 16)
	close_btn.add_theme_color_override("font_color", Color(0.5, 0.8, 1.0))
	close_btn.pressed.connect(_on_close)
	btn_row.add_child(close_btn)

	var sep2 = HSeparator.new()
	sep2.add_theme_color_override("default_color", Color(0.3, 0.3, 0.5))
	outer.add_child(sep2)

	unit_count_label = Label.new()
	unit_count_label.text = "Unidades creadas: 0"
	unit_count_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.9))
	outer.add_child(unit_count_label)

	var scroll = ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	outer.add_child(scroll)

	list_container = VBoxContainer.new()
	list_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(list_container)

func _popup_open() -> bool:
	for c in focus_list:
		if c is OptionButton and c.get_popup().visible:
			return true
	return false

func _focus_next():
	if focus_list.is_empty():
		return
	focus_idx = (focus_idx + 1) % focus_list.size()
	focus_list[focus_idx].grab_focus()

func _focus_prev():
	if focus_list.is_empty():
		return
	focus_idx = (focus_idx - 1 + focus_list.size()) % focus_list.size()
	focus_list[focus_idx].grab_focus()

func _input(event):
	if not visible:
		return
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_Z:
				_handle_z()
				get_viewport().set_input_as_handled()
			KEY_X:
				_handle_x()
				get_viewport().set_input_as_handled()
			KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT:
				if _popup_open():
					return
				get_viewport().set_input_as_handled()
				if event.keycode in [KEY_DOWN, KEY_RIGHT]:
					_focus_next()
				else:
					_focus_prev()

func _handle_z():
	var opened = false
	for c in focus_list:
		if c is OptionButton and c.get_popup().visible:
			var popup = c.get_popup()
			var highlighted = popup.get_focused_item()
			if highlighted >= 0:
				c.select(highlighted)
			popup.hide()
			opened = true
			break
	if opened:
		return
	var fc = focus_list[focus_idx]
	if fc is OptionButton:
		fc.show_popup()
	elif fc is Button:
		fc.pressed.emit()

func _handle_x():
	for c in focus_list:
		if c is OptionButton and c.get_popup().visible:
			c.get_popup().hide()
			return
	_on_close()

func _add_selector(parent: GridContainer, label_text: String, items: Array, var_name: String):
	var lbl = Label.new()
	lbl.text = label_text
	lbl.add_theme_color_override("font_color", Color(0.8, 0.8, 0.9))
	lbl.add_theme_font_size_override("font_size", 14)
	parent.add_child(lbl)

	var dd = OptionButton.new()
	dd.add_theme_font_size_override("font_size", 13)
	dd.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for item in items:
		if typeof(item) == TYPE_STRING:
			dd.add_item(item)
		elif typeof(item) == TYPE_INT:
			dd.add_item(Enums.STAT_NAMES.get(item, "?"), item)
	parent.add_child(dd)

	if var_name == "race_dd":
		race_dd = dd
	elif var_name == "class_dd":
		class_dd = dd
	elif var_name == "piece_dd":
		piece_dd = dd
	elif var_name == "office_dd":
		office_dd = dd

	var spacer = Control.new()
	parent.add_child(spacer)

func _on_create():
	if base_idx >= base_tiles.size():
		_add_list_item("¡No hay más espacio cerca de la base!", Color(1, 0.3, 0.3))
		return

	var race_name = humanoid_races[race_dd.selected]
	var cls_name = class_list[class_dd.selected]
	var piece_val = piece_dd.get_selected_id()
	var ofc_name = office_list[office_dd.selected] if office_dd.selected >= 0 else ""
	var pos = base_tiles[base_idx]

	var tile_data = grid_ref.tile_at(pos.x, pos.y)
	if not tile_data:
		return

	base_idx += 1
	var unit = UnitFactory.create_unit(unit_scene, grid_ref, 0, pos,
		race_name, cls_name, piece_val, 1, ofc_name, selected_team)
	created_units.append(unit)

	unit_count_label.text = "Unidades creadas: " + str(created_units.size())

	var team_name = "Azul" if selected_team == 0 else "Rojo"
	var txt = "%s | %s | %s | %s [%s]" % [race_name, cls_name, ofc_name, Enums.STAT_NAMES.get(piece_val, "?"), team_name]
	_add_list_item(txt, Color(0.6, 0.9, 0.6))

func _add_list_item(text: String, color: Color):
	var h = HBoxContainer.new()
	var lbl = Label.new()
	lbl.text = text
	lbl.add_theme_color_override("font_color", color)
	lbl.add_theme_font_size_override("font_size", 13)
	lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	h.add_child(lbl)
	list_container.add_child(h)

func _on_clear():
	UnitFactory.clear_units(created_units, grid_ref)
	base_idx = 0
	unit_count_label.text = "Unidades creadas: 0"
	for c in list_container.get_children():
		list_container.remove_child(c)
		c.queue_free()

func _highlight_team():
	if team_azul_btn and team_rojo_btn:
		var azul_color = Color(0.3, 0.7, 1.0) if selected_team == 0 else Color(0.5, 0.5, 0.6)
		var rojo_color = Color(1.0, 0.3, 0.3) if selected_team == 1 else Color(0.5, 0.5, 0.6)
		team_azul_btn.add_theme_color_override("font_color", azul_color)
		team_rojo_btn.add_theme_color_override("font_color", rojo_color)

func _on_team_azul():
	selected_team = 0
	_highlight_team()

func _on_team_rojo():
	selected_team = 1
	_highlight_team()

func _on_close():
	if created_units.is_empty():
		_on_create()
	queue_free()
