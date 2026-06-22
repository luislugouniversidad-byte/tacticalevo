class_name StatCalculator

static func calculate(race_name: String, cls_name: String, piece_principal: int,
		level: int, bonus_pct: Dictionary, bonus_flat: Dictionary) -> Dictionary:
	var race = RaceData.get_race(race_name)
	if race.is_empty():
		return {}
	var base = race.stats.duplicate()

	var piece_pct = _get_piece_pct(piece_principal)
	var class_pct = _get_class_pct(cls_name)

	var final = {}
	for s in Enums.ALL_STATS:
		var pct_mod = 1.0
		pct_mod += piece_pct.get(s, 0.0)
		pct_mod += class_pct.get(s, 0.0)
		pct_mod += bonus_pct.get(s, 0.0)
		var val = base[s] * pct_mod
		var growth = PieceData.get_total_growth_stats(piece_principal, level)
		val += growth.get(s, 0)
		val += bonus_flat.get(s, 0)
		final[s] = roundi(val)

	return final

static func _get_piece_pct(principal: int) -> Dictionary:
	var result = {}
	for s in Enums.ALL_STATS:
		result[s] = 0.0
	result[principal] = 0.17 * 3.0
	var ady = Enums.ADJACENCY.get(principal, [])
	for a in ady:
		result[a] = 0.15 * 3.0
	return result

static func _get_class_pct(cls_name: String) -> Dictionary:
	var class_data = ClassData.get_class_data(cls_name)
	if class_data.is_empty():
		return {}
	var raw = class_data.get("pct", {})
	var result = {}
	for s in Enums.ALL_STATS:
		result[s] = raw.get(s, 0.0)
	return result

static func calculate_hp(con: int) -> int:
	return con * 5
