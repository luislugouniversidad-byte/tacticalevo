extends CanvasLayer

var current_unit = null
var visible_flag: bool = false

var panel: Panel
var title_label: Label
var close_btn: Button
var tab_buttons: HBoxContainer
var content: VBoxContainer

var nav_btns = {}
var content_pages = {}
var active_tab: String = ""
var tab_index: int = 0

var tabs = ["Raza", "Oficios", "Ficha", "Equipamiento", "Estadisticas", "Inventario", "Habilidades"]

func _ready():
	visible = false
	_build_ui()

func _build_ui():
	panel = Panel.new()
	panel.anchor_left = 0.5
	panel.anchor_right = 1.0
	panel.anchor_top = 0.0
	panel.anchor_bottom = 1.0
	var theme_style = StyleBoxFlat.new()
	theme_style.bg_color = Color(0.08, 0.08, 0.15, 0.95)
	theme_style.corner_radius_top_left = 8
	theme_style.corner_radius_top_right = 8
	theme_style.corner_radius_bottom_left = 8
	theme_style.corner_radius_bottom_right = 8
	theme_style.content_margin_left = 12
	theme_style.content_margin_right = 12
	theme_style.content_margin_top = 12
	theme_style.content_margin_bottom = 12
	add_child(panel)

	var outer = VBoxContainer.new()
	outer.anchor_left = 0.0
	outer.anchor_right = 1.0
	outer.anchor_top = 0.0
	outer.anchor_bottom = 1.0
	panel.add_child(outer)

	# Title bar
	var title_bar = HBoxContainer.new()
	outer.add_child(title_bar)

	title_label = Label.new()
	title_label.text = "Ficha de Unidad"
	title_label.add_theme_font_size_override("font_size", 20)
	title_label.add_theme_color_override("font_color", Color(0.9, 0.9, 1.0))
	title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	title_bar.add_child(title_label)

	close_btn = Button.new()
	close_btn.text = "X"
	close_btn.add_theme_font_size_override("font_size", 18)
	close_btn.add_theme_color_override("font_color", Color(1, 0.3, 0.3))
	close_btn.pressed.connect(_on_close)
	title_bar.add_child(close_btn)

	# Separator
	var sep = HSeparator.new()
	sep.add_theme_color_override("default_color", Color(0.3, 0.3, 0.5))
	outer.add_child(sep)

	# Tab navigation
	tab_buttons = HBoxContainer.new()
	tab_buttons.alignment = BoxContainer.ALIGNMENT_CENTER
	outer.add_child(tab_buttons)

	for t in tabs:
		var btn = Button.new()
		btn.text = t
		btn.add_theme_font_size_override("font_size", 12)
		btn.add_theme_color_override("font_color", Color(0.7, 0.7, 0.9))
		var normal = StyleBoxEmpty.new()
		btn.add_theme_stylebox_override("normal", normal)
		var hover = StyleBoxEmpty.new()
		btn.add_theme_stylebox_override("hover", hover)
		var pressed = StyleBoxEmpty.new()
		btn.add_theme_stylebox_override("pressed", pressed)
		btn.pressed.connect(_on_tab.bind(t))
		tab_buttons.add_child(btn)
		nav_btns[t] = btn

	# Separator
	var sep2 = HSeparator.new()
	sep2.add_theme_color_override("default_color", Color(0.3, 0.3, 0.5))
	outer.add_child(sep2)

	# Content area with scroll
	var scroll = ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	outer.add_child(scroll)

	content = VBoxContainer.new()
	content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(content)

func _on_close():
	hide_ui()

func _on_tab(tab_name: String):
	active_tab = tab_name
	_update_from_unit()
	for t in tabs:
		var btn = nav_btns.get(t)
		if btn:
			if t == tab_name:
				btn.add_theme_color_override("font_color", Color(1, 1, 1))
			else:
				btn.add_theme_color_override("font_color", Color(0.7, 0.7, 0.9))

func show_ui(unit):
	current_unit = unit
	visible_flag = true
	visible = true
	var team_name = "Azul" if unit.team == 0 else "Rojo"
	title_label.text = unit.race_name + " " + unit.unit_class + " [" + team_name + "]"
	if not active_tab:
		active_tab = "Raza"
	_on_tab(active_tab)

func hide_ui():
	visible_flag = false
	visible = false
	current_unit = null

func toggle(unit):
	if visible_flag:
		hide_ui()
	elif unit:
		show_ui(unit)

func _clear_content():
	for c in content.get_children():
		content.remove_child(c)
		c.queue_free()

func _update_from_unit():
	if not current_unit:
		return
	_clear_content()
	match active_tab:
		"Raza":
			_show_race()
		"Oficios":
			_show_oficios()
		"Ficha":
			_show_ficha()
		"Equipamiento":
			_show_equip()
		"Estadisticas":
			_show_stats()
		"Inventario":
			_show_inventory()
		"Habilidades":
			_show_skills()

func _add_label(txt: String, _bold: bool = false, color: Color = Color(1,1,1), size: int = 14):
	var l = Label.new()
	l.text = txt
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content.add_child(l)
	return l

func _add_sep():
	var s = HSeparator.new()
	s.add_theme_color_override("default_color", Color(0.3, 0.3, 0.5))
	content.add_child(s)

func _show_race():
	if not current_unit:
		return
	var race = RaceData.get_race(current_unit.race_name)
	if race.is_empty():
		_add_label("Raza no encontrada", false, Color(1,0.3,0.3))
		return

	_add_label("[b]Raza:[/b] " + current_unit.race_name, true, Color(0.8, 0.9, 1.0), 18)
	var group_names = { RaceData.Group.HUMANOID: "Humanoide", RaceData.Group.BEAST: "Bestia", RaceData.Group.NON_HUMAN: "No-humano" }
	_add_label("Grupo: " + group_names.get(race.group, "?"), false, Color(0.7, 0.7, 0.9), 14)
	_add_sep()

	_add_label("Estadísticas Base:", true, Color(0.6, 0.8, 1.0), 15)
	var base = race.stats
	var line = ""
	for s in Enums.ALL_STATS:
		line += Enums.STAT_ABBREV.get(s, "?") + ": " + str(base.get(s, 0)) + "  "
	_add_label(line, false, Color(0.8, 0.8, 0.9), 13)
	_add_sep()

	if race.has("passive_name"):
		_add_label("Habilidad Racial:", true, Color(0.6, 0.8, 1.0), 15)
		_add_label(race.passive_name + ": " + race.passive_desc, false, Color(0.8, 0.8, 0.9), 13)
		_add_label("Terreno favorable: " + race.get("terrain", "?"), false, Color(0.5, 0.7, 0.5), 13)
		_add_label("Bono: " + race.get("terrain_bonus", "?"), false, Color(0.5, 0.7, 0.5), 13)

func _show_oficios():
	if not current_unit:
		return
	var team_name = "Azul" if current_unit.team == 0 else "Rojo"
	_add_label("Bando: " + team_name, true, Color(0.8, 0.9, 1.0), 16)
	_add_sep()
	if current_unit.office_name and current_unit.office_name != "":
		var od = OfficeData.get_office_data(current_unit.office_name)
		if not od.is_empty():
			_add_label("Oficio: " + current_unit.office_name, true, Color(0.6, 0.8, 1.0), 18)
			_add_label(od.get("desc", ""), false, Color(0.7, 0.7, 0.9), 13)
			_add_sep()
			_add_label("Pasiva: " + od.get("passive_name", "?"), true, Color(0.8, 0.9, 0.6), 14)
			_add_label(od.get("passive_desc", "?"), false, Color(0.8, 0.8, 0.9), 13)
			_add_label("Activa: " + od.get("active_name", "?"), true, Color(0.8, 0.6, 0.9), 14)
			_add_label(od.get("active_desc", "?"), false, Color(0.8, 0.8, 0.9), 13)
	else:
		_add_label("Oficio: (ninguno)", false, Color(0.6, 0.6, 0.7), 14)

func _show_ficha():
	if not current_unit:
		return
	var pname = Enums.STAT_NAMES.get(current_unit.piece_principal, "?")
	var abv = Enums.STAT_ABBREV.get(current_unit.piece_principal, "?")

	_add_label("Ficha - " + pname + " (" + abv + ")", true, Color(0.8, 0.9, 1.0), 18)
	_add_label("Nivel de Pieza: 1 / 3", false, Color(0.7, 0.7, 0.9), 14)
	_add_sep()

	_add_label("Atributo Principal: " + abv + " (17% por nivel)", true, Color(1, 0.8, 0.3), 14)
	var ady = Enums.ADJACENCY.get(current_unit.piece_principal, [])
	var ady_names = []
	for a in ady:
		ady_names.append(Enums.STAT_ABBREV.get(a, "?"))
	_add_label("Adyacentes: " + ", ".join(ady_names) + " (15% c/u)", false, Color(0.8, 0.8, 0.9), 13)

	var op = Enums.OPPOSITION.get(current_unit.piece_principal, -1)
	if op >= 0:
		_add_label("Opuesto Directo: " + Enums.STAT_ABBREV.get(op, "?") + " (3% por nivel)", false, Color(0.8, 0.3, 0.3), 13)
		var op_ady = Enums.ADJACENCY.get(op, [])
		var op_ady_names = []
		for a in op_ady:
			op_ady_names.append(Enums.STAT_ABBREV.get(a, "?"))
		_add_label("Opuestos Adyacentes: " + ", ".join(op_ady_names) + " (5% c/u)", false, Color(0.7, 0.5, 0.5), 13)

	_add_sep()
	var growth = PieceData.get_total_growth_stats(current_unit.piece_principal, current_unit.level)
	_add_label("Puntos de Crecimiento (Nv." + str(current_unit.level) + "):", true, Color(0.6, 0.8, 1.0), 14)
	var gline = ""
	for s in Enums.ALL_STATS:
		gline += Enums.STAT_ABBREV.get(s, "?") + ": +" + str(growth.get(s, 0)) + "  "
	_add_label(gline, false, Color(0.8, 0.8, 0.9), 12)

func _show_equip():
	_add_label("Equipamiento:", true, Color(0.6, 0.8, 1.0), 16)
	_add_label("Armadura: " + _get_armor_type(), false, Color(0.8, 0.8, 0.9), 14)
	_add_label("Arma: (ninguna)", false, Color(0.8, 0.8, 0.9), 14)
	_add_label("Accesorio: (ninguno)", false, Color(0.8, 0.8, 0.9), 14)
	_add_sep()
	_add_label("(Sistema de equipamiento pendiente de implementación)", false, Color(0.6, 0.6, 0.7), 13)

func _get_armor_type() -> String:
	if not current_unit:
		return "?"
	var cd = ClassData.get_class_data(current_unit.unit_class)
	return cd.get("armor", "?")

func _show_stats():
	if not current_unit:
		return
	_add_label("Estadísticas Finales - " + current_unit.race_name + " " + current_unit.unit_class, true, Color(0.8, 0.9, 1.0), 18)
	_add_label("Nivel: " + str(current_unit.level), false, Color(0.7, 0.7, 0.9), 14)
	_add_label("HP: " + current_unit.get_hp_str(), false, Color(0.3, 1.0, 0.3), 16)
	_add_sep()

	var stat_order = [
		Enums.Stat.FUE, Enums.Stat.ENE, Enums.Stat.FOR, Enums.Stat.VEL, Enums.Stat.RES,
		Enums.Stat.SAB, Enums.Stat.ESP, Enums.Stat.DES, Enums.Stat.CON, Enums.Stat.DEF,
	]
	var h_line = ""
	for s in stat_order:
		var abv = Enums.STAT_ABBREV.get(s, "?")
		var val = current_unit.get_stat(s)
		h_line += abv + ": " + str(val)
		if len(h_line) > 30:
			_add_label(h_line, false, Color(0.9, 0.9, 0.9), 14)
			h_line = "    "
		else:
			h_line += "  |  "
	if h_line.strip_edges() != "":
		_add_label(h_line, false, Color(0.9, 0.9, 0.9), 14)

func _show_inventory():
	_add_label("Inventario:", true, Color(0.6, 0.8, 1.0), 16)
	_add_label("(Vacío)", false, Color(0.6, 0.6, 0.7), 14)
	_add_sep()
	_add_label("Oro: 0", false, Color(1, 0.9, 0.3), 14)
	_add_label("(Sistema de inventario pendiente de implementación)", false, Color(0.6, 0.6, 0.7), 13)

func _show_skills():
	if not current_unit:
		return
	_add_label("Habilidades de Clase:", true, Color(0.6, 0.8, 1.0), 16)
	var cd = ClassData.get_class_data(current_unit.unit_class)
	if not cd.is_empty():
		_add_label(cd.get("passive_name", "?"), true, Color(0.8, 0.9, 0.6), 14)
		_add_label("Pasiva: " + cd.get("passive_desc", "?"), false, Color(0.8, 0.8, 0.9), 13)
		_add_label(cd.get("active_name", "?"), true, Color(0.8, 0.6, 0.9), 14)
		_add_label("Activa: " + cd.get("active_desc", "?"), false, Color(0.8, 0.8, 0.9), 13)
	_add_sep()

	_add_label("Habilidad Racial:", true, Color(0.6, 0.8, 1.0), 16)
	var race = RaceData.get_race(current_unit.race_name)
	if not race.is_empty():
		_add_label(race.get("passive_name", "?"), true, Color(0.8, 0.9, 0.6), 14)
		_add_label(race.get("passive_desc", "?"), false, Color(0.8, 0.8, 0.9), 13)
	_add_sep()

	_add_label("Aura de Formación:", true, Color(0.6, 0.8, 1.0), 16)
	_add_label("Ficha de " + Enums.STAT_NAMES.get(current_unit.piece_principal, "?"), true, Color(0.8, 0.9, 0.6), 14)
	var aura_desc = _get_aura_desc(current_unit.piece_principal)
	_add_label(aura_desc, false, Color(0.8, 0.8, 0.9), 13)

func nav_left():
	if tabs.is_empty():
		return
	tab_index = (tab_index - 1 + tabs.size()) % tabs.size()
	_on_tab(tabs[tab_index])

func nav_right():
	if tabs.is_empty():
		return
	tab_index = (tab_index + 1) % tabs.size()
	_on_tab(tabs[tab_index])

func _get_aura_desc(principal: int) -> String:
	match principal:
		Enums.Stat.FUE: return "+20% daño físico a aliados en rango 3."
		Enums.Stat.DEF: return "-20% daño físico a aliados en rango 3."
		Enums.Stat.CON: return "Centro logístico móvil (abastece aliados en rango 3)."
		Enums.Stat.DES: return "+10% precisión a aliados en rango 3."
		Enums.Stat.ESP: return "Activa: permite 2 acciones a aliado (coste alto de ESP)."
		Enums.Stat.SAB: return "+20% daño mágico a aliados en rango 3."
		Enums.Stat.RES: return "-20% daño mágico a aliados en rango 3."
		Enums.Stat.FOR: return "+10% crítico a aliados en rango 3."
		Enums.Stat.VEL: return "+10% Velocidad a aliados en rango 3."
		Enums.Stat.ENE: return "Activa: permite 2 acciones a aliado (coste alto de ENE)."
	return "?"
