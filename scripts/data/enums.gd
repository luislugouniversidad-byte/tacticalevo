class_name Enums

enum Stat {
	FUE, ENE, FOR, VEL, RES, SAB, ESP, DES, CON, DEF
}

const STAT_NAMES = {
	Stat.FUE: "Fuerza",
	Stat.ENE: "Energía",
	Stat.FOR: "Fortuna",
	Stat.VEL: "Velocidad",
	Stat.RES: "Resistencia",
	Stat.SAB: "Sabiduría",
	Stat.ESP: "Espíritu",
	Stat.DES: "Destreza",
	Stat.CON: "Constitución",
	Stat.DEF: "Defensa",
}

const STAT_ABBREV = {
	Stat.FUE: "FUE",
	Stat.ENE: "ENE",
	Stat.FOR: "FOR",
	Stat.VEL: "VEL",
	Stat.RES: "RES",
	Stat.SAB: "SAB",
	Stat.ESP: "ESP",
	Stat.DES: "DES",
	Stat.CON: "CON",
	Stat.DEF: "DEF",
}

const ALL_STATS = [
	Stat.FUE, Stat.ENE, Stat.FOR, Stat.VEL, Stat.RES,
	Stat.SAB, Stat.ESP, Stat.DES, Stat.CON, Stat.DEF,
]

const OPPOSITION = {
	Stat.FUE: Stat.SAB, Stat.SAB: Stat.FUE,
	Stat.DEF: Stat.RES, Stat.RES: Stat.DEF,
	Stat.CON: Stat.VEL, Stat.VEL: Stat.CON,
	Stat.DES: Stat.FOR, Stat.FOR: Stat.DES,
	Stat.ESP: Stat.ENE, Stat.ENE: Stat.ESP,
}

const ADJACENCY = {
	Stat.FUE: [Stat.DEF, Stat.ENE],
	Stat.DEF: [Stat.FUE, Stat.CON],
	Stat.CON: [Stat.DEF, Stat.DES],
	Stat.DES: [Stat.CON, Stat.ESP],
	Stat.ESP: [Stat.DES, Stat.SAB],
	Stat.SAB: [Stat.ESP, Stat.RES],
	Stat.RES: [Stat.SAB, Stat.FOR],
	Stat.FOR: [Stat.RES, Stat.VEL],
	Stat.VEL: [Stat.FOR, Stat.ENE],
	Stat.ENE: [Stat.VEL, Stat.FUE],
}

const CIRCLE_ORDER = [
	Stat.FUE, Stat.DEF, Stat.CON, Stat.DES, Stat.ESP,
	Stat.SAB, Stat.RES, Stat.FOR, Stat.VEL, Stat.ENE,
]

static func stat_index(s: int) -> int:
	var idx = CIRCLE_ORDER.find(s)
	return idx if idx >= 0 else 0

static func circ_distance(a: int, b: int) -> int:
	var ia = stat_index(a)
	var ib = stat_index(b)
	var d = abs(ia - ib)
	return mini(d, 10 - d)
