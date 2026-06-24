extends CanvasLayer

var team_label: Label
var round_label: Label

func _ready():
	visible = false
	var panel = Panel.new()
	panel.anchor_left = 0.0
	panel.anchor_right = 0.3
	panel.anchor_top = 0.0
	panel.anchor_bottom = 0.08
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.0, 0.0, 0.0, 0.6)
	style.corner_radius_bottom_right = 8
	add_child(panel)

	var hb = HBoxContainer.new()
	hb.anchor_left = 0.0
	hb.anchor_right = 1.0
	hb.anchor_top = 0.0
	hb.anchor_bottom = 1.0
	hb.alignment = BoxContainer.ALIGNMENT_CENTER
	panel.add_child(hb)

	team_label = Label.new()
	team_label.add_theme_font_size_override("font_size", 20)
	hb.add_child(team_label)

	round_label = Label.new()
	round_label.add_theme_font_size_override("font_size", 14)
	round_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.9))
	hb.add_child(round_label)

func show_turn(team: int, round_num: int):
	visible = true
	var name = "AZUL" if team == 0 else "ROJO"
	var color = Color(0.3, 0.7, 1.0) if team == 0 else Color(1.0, 0.3, 0.3)
	team_label.text = "TURNO: " + name
	team_label.add_theme_color_override("font_color", color)
	round_label.text = "Ronda " + str(round_num)
