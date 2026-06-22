class_name PieceData

const ADJACENCY = Enums.ADJACENCY
const OPPOSITION = Enums.OPPOSITION
const CIRCLE_ORDER = Enums.CIRCLE_ORDER

const GROWTH = {
	"principal": 0.17,
	"adyacente": 0.15,
	"media_mayor": 0.13,
	"media_menor": 0.07,
	"opuesto_adyacente": 0.05,
	"opuesto_directo": 0.03,
}

static func get_piece_principal(stat_name: String) -> int:
	return Enums.Stat.get(stat_name)

static func get_adyacentes(principal: int) -> Array:
	return ADJACENCY.get(principal, [])

static func get_opuesto(principal: int) -> int:
	return OPPOSITION.get(principal, -1)

static func get_opuestos_adyacentes(principal: int) -> Array:
	var op = get_opuesto(principal)
	if op < 0:
		return []
	return ADJACENCY.get(op, [])

static func get_growth_distribution(principal: int) -> Dictionary:
	var result = {}
	for s in Enums.ALL_STATS:
		result[s] = 0.0

	var opuesto = get_opuesto(principal)
	var ady = get_adyacentes(principal)
	var op_ady = get_opuestos_adyacentes(principal)

	var remaining = []
	for s in Enums.ALL_STATS:
		if s == principal or s in ady or s == opuesto or s in op_ady:
			continue
		remaining.append(s)

	var dists = {}
	for s in remaining:
		dists[s] = Enums.circ_distance(principal, s)
	var sorted_rem = dists.keys()
	sorted_rem.sort_custom(func(a, b): return dists[a] < dists[b])

	var med_may = [sorted_rem[0], sorted_rem[1]]
	var med_men = [sorted_rem[2], sorted_rem[3]]

	result[principal] = GROWTH.principal
	for a in ady:
		result[a] = GROWTH.adyacente
	for m in med_may:
		result[m] = GROWTH.media_mayor
	for m in med_men:
		result[m] = GROWTH.media_menor
	for o in op_ady:
		result[o] = GROWTH.opuesto_adyacente
	result[opuesto] = GROWTH.opuesto_directo

	return result

static func get_growth_points(principal: int, level: int) -> Dictionary:
	var dist = get_growth_distribution(principal)
	var result = {}
	var reserves = {}
	var total_decimal = 0.0

	for s in Enums.ALL_STATS:
		var raw = dist[s] * 10.0 * level
		var pts = int(raw)
		var dec = raw - pts
		result[s] = pts
		reserves[s] = dec
		total_decimal += dec

	while total_decimal >= 1.0:
		var best = -1
		var best_dec = 0.0
		for s in Enums.ALL_STATS:
			if reserves[s] > best_dec:
				best_dec = reserves[s]
				best = s
		result[best] += 1
		reserves[best] = 0.0
		total_decimal -= best_dec

	return result

static func get_total_growth_stats(principal: int, total_levels: int) -> Dictionary:
	var cumulative = {}
	for s in Enums.ALL_STATS:
		cumulative[s] = 0

	for lvl in range(1, total_levels + 1):
		var pts = get_growth_points(principal, lvl)
		for s in Enums.ALL_STATS:
			cumulative[s] += pts.get(s, 0)

	return cumulative
