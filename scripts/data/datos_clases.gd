class_name ClassData

const CLASSES = {
	"Guerrero": {
		"abbrev": "FUE",
		"armor": "Armaduras de Fuerza",
		"pct": { Enums.Stat.FUE:0.20, Enums.Stat.ENE:0.17, Enums.Stat.FOR:0.13, Enums.Stat.VEL:0.06, Enums.Stat.RES:0.04, Enums.Stat.SAB:0.00, Enums.Stat.ESP:0.04, Enums.Stat.DES:0.06, Enums.Stat.CON:0.13, Enums.Stat.DEF:0.17 },
		"passive_name": "Sangre y Acero",
		"passive_desc": "+2% FUE por ataque físico (máx +10%).",
		"active_name": "Golpe de Ruptura",
		"active_desc": "-15% DEF objetivo por 2 turnos.",
	},
	"Mercenario": {
		"abbrev": "ENE",
		"armor": "Placas, Escudos",
		"pct": { Enums.Stat.FUE:0.17, Enums.Stat.ENE:0.20, Enums.Stat.FOR:0.17, Enums.Stat.VEL:0.13, Enums.Stat.RES:0.06, Enums.Stat.SAB:0.04, Enums.Stat.ESP:0.00, Enums.Stat.DES:0.04, Enums.Stat.CON:0.06, Enums.Stat.DEF:0.13 },
		"passive_name": "Defensa Entrenada",
		"passive_desc": "+5% bloqueo con escudo.",
		"active_name": "Golpe de Poder",
		"active_desc": "+25% daño en siguiente ataque.",
	},
	"Pícaro": {
		"abbrev": "FOR",
		"armor": "Cuero, Telas",
		"pct": { Enums.Stat.FUE:0.13, Enums.Stat.ENE:0.17, Enums.Stat.FOR:0.20, Enums.Stat.VEL:0.17, Enums.Stat.RES:0.13, Enums.Stat.SAB:0.06, Enums.Stat.ESP:0.04, Enums.Stat.DES:0.00, Enums.Stat.CON:0.04, Enums.Stat.DEF:0.06 },
		"passive_name": "Oportunismo",
		"passive_desc": "+15% crítico por espalda o flancos libres.",
		"active_name": "Paso de Sombras",
		"active_desc": "Teletransporte rango 2, siguiente golpe perforante.",
	},
	"Explorador": {
		"abbrev": "VEL",
		"armor": "Cuero",
		"pct": { Enums.Stat.FUE:0.06, Enums.Stat.ENE:0.13, Enums.Stat.FOR:0.17, Enums.Stat.VEL:0.20, Enums.Stat.RES:0.17, Enums.Stat.SAB:0.13, Enums.Stat.ESP:0.06, Enums.Stat.DES:0.04, Enums.Stat.CON:0.00, Enums.Stat.DEF:0.04 },
		"passive_name": "Zancada Ágil",
		"passive_desc": "Costo terreno difícil fijo en 1.",
		"active_name": "Reconocimiento",
		"active_desc": "Revela zona oculta rango 5, +2 mov. a aliado.",
	},
	"Guardián": {
		"abbrev": "RES",
		"armor": "Placas oscuras",
		"pct": { Enums.Stat.FUE:0.04, Enums.Stat.ENE:0.06, Enums.Stat.FOR:0.13, Enums.Stat.VEL:0.17, Enums.Stat.RES:0.20, Enums.Stat.SAB:0.17, Enums.Stat.ESP:0.13, Enums.Stat.DES:0.06, Enums.Stat.CON:0.04, Enums.Stat.DEF:0.00 },
		"passive_name": "Aislante Místico",
		"passive_desc": "Convierte 10% daño mágico en HP.",
		"active_name": "Ancla de Resistencia",
		"active_desc": "Suelo sagrado rango 1: +25% RES mágica aliados 2 turnos.",
	},
	"Sabio": {
		"abbrev": "SAB",
		"armor": "Túnicas",
		"pct": { Enums.Stat.FUE:0.00, Enums.Stat.ENE:0.04, Enums.Stat.FOR:0.06, Enums.Stat.VEL:0.13, Enums.Stat.RES:0.17, Enums.Stat.SAB:0.20, Enums.Stat.ESP:0.17, Enums.Stat.DES:0.13, Enums.Stat.CON:0.06, Enums.Stat.DEF:0.04 },
		"passive_name": "Previsión Ilustrada",
		"passive_desc": "Absorbe 10% daño mágico a aliados rango 3.",
		"active_name": "Edicto de Protección",
		"active_desc": "Escudo contra magia a aliado.",
	},
	"Hechicero": {
		"abbrev": "ESP",
		"armor": "Túnicas",
		"pct": { Enums.Stat.FUE:0.04, Enums.Stat.ENE:0.00, Enums.Stat.FOR:0.04, Enums.Stat.VEL:0.06, Enums.Stat.RES:0.13, Enums.Stat.SAB:0.17, Enums.Stat.ESP:0.20, Enums.Stat.DES:0.17, Enums.Stat.CON:0.13, Enums.Stat.DEF:0.06 },
		"passive_name": "Manantial del Alma",
		"passive_desc": "Regenera 5% Espíritu si está por debajo del 25%.",
		"active_name": "Canalización de Falla",
		"active_desc": "Daño mágico en línea recta rango 3.",
	},
	"Artillero": {
		"abbrev": "DES",
		"armor": "Cuero, Telas",
		"pct": { Enums.Stat.FUE:0.06, Enums.Stat.ENE:0.04, Enums.Stat.FOR:0.00, Enums.Stat.VEL:0.04, Enums.Stat.RES:0.06, Enums.Stat.SAB:0.13, Enums.Stat.ESP:0.17, Enums.Stat.DES:0.20, Enums.Stat.CON:0.17, Enums.Stat.DEF:0.13 },
		"passive_name": "Cálculo de Trayectoria",
		"passive_desc": "Ignora coberturas arbóreas.",
		"active_name": "Fuego de Supresión",
		"active_desc": "Daño leve en área rango 4, -2 mov.",
	},
	"Carguero": {
		"abbrev": "CON",
		"armor": "Ligera",
		"pct": { Enums.Stat.FUE:0.13, Enums.Stat.ENE:0.06, Enums.Stat.FOR:0.04, Enums.Stat.VEL:0.00, Enums.Stat.RES:0.04, Enums.Stat.SAB:0.06, Enums.Stat.ESP:0.13, Enums.Stat.DES:0.17, Enums.Stat.CON:0.20, Enums.Stat.DEF:0.17 },
		"passive_name": "Paso Sólido",
		"passive_desc": "Inmune a empujes.",
		"active_name": "Despliegue de Provisiones",
		"active_desc": "Cura 20% HP y limpia estados físicos a rango 3.",
	},
	"Acorazado": {
		"abbrev": "DEF",
		"armor": "Placas, Escudos",
		"pct": { Enums.Stat.FUE:0.17, Enums.Stat.ENE:0.13, Enums.Stat.FOR:0.06, Enums.Stat.VEL:0.04, Enums.Stat.RES:0.00, Enums.Stat.SAB:0.04, Enums.Stat.ESP:0.06, Enums.Stat.DES:0.13, Enums.Stat.CON:0.17, Enums.Stat.DEF:0.20 },
		"passive_name": "Bastión Estático",
		"passive_desc": "-1.5% daño recibido por casilla no movida (máx 7.5%).",
		"active_name": "Provocación de Falange",
		"active_desc": "Atrae enemigos a rango 2.",
	},
}

static func get_class_names() -> Array:
	return CLASSES.keys()

static func get_class_data(cls_name: String) -> Dictionary:
	return CLASSES.get(cls_name, {})
