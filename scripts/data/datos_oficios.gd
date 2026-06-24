class_name OfficeData

const OFFICES = {
	"Comandante": {
		"desc": "Líder nato que potencia a sus aliados.",
		"passive_name": "Presencia Inspiradora",
		"passive_desc": "+5% a todas las estadísticas de aliados en rango 2.",
		"active_name": "Orden de Avance",
		"active_desc": "Otorga +2 movimiento a un aliado por 1 turno.",
	},
	"Guardia": {
		"desc": "Defensor impenetrable, muro del equipo.",
		"passive_name": "Postura Defensiva",
		"passive_desc": "+10% DEF cuando no se ha movido en el turno.",
		"active_name": "Escudo de Protección",
		"active_desc": "Reduce 30% daño a un aliado adyacente por 1 turno.",
	},
	"Médico": {
		"desc": "Sanador de campo, mantiene al equipo en pie.",
		"passive_name": "Aura Sanadora",
		"passive_desc": "Cura 5% HP de aliados adyacentes al inicio del turno.",
		"active_name": "Curación de Emergencia",
		"active_desc": "Cura 30% HP máximo a un aliado en rango 2.",
	},
	"Explorador": {
		"desc": "Ojos del equipo, se mueve con libertad.",
		"passive_name": "Zancada Expedita",
		"passive_desc": "+1 movimiento y terreno difícil no penaliza.",
		"active_name": "Ojo de Águila",
		"active_desc": "Revela unidad oculta en rango 5 por 2 turnos.",
	},
	"Ingeniero": {
		"desc": "Constructor y destructor de obstáculos.",
		"passive_name": "Terreno Moldeable",
		"passive_desc": "Puede construir coberturas o destruirlas como acción secundaria.",
		"active_name": "Barrera de Campo",
		"active_desc": "Crea cobertura sólida en una casilla adyacente por 2 turnos.",
	},
	"Infiltrado": {
		"desc": "Sombra entre enemigos, golpea sin ser visto.",
		"passive_name": "Paso Etéreo",
		"passive_desc": "Ignora zonas de control enemigas.",
		"active_name": "Golpe Silencioso",
		"active_desc": "Ataque que no revela posición, +20% crítico.",
	},
	"Artillero": {
		"desc": "Experto en proyectiles y supresión.",
		"passive_name": "Puntería Calculada",
		"passive_desc": "+1 rango de ataque y +10% precisión.",
		"active_name": "Fuego Rasante",
		"active_desc": "Ataque en línea de 3 casillas, -15% velocidad por 1 turno.",
	},
	"Vanguardista": {
		"desc": "Primero en la batalla, rompe líneas enemigas.",
		"passive_name": "Ímpetu Inicial",
		"passive_desc": "+15% daño en el primer ataque de cada combate.",
		"active_name": "Carga Imparable",
		"active_desc": "Avanza hasta 3 casillas, dañando enemigos en el camino.",
	},
}

static func get_office_names() -> Array:
	return OFFICES.keys()

static func get_office_data(ofc_name: String) -> Dictionary:
	return OFFICES.get(ofc_name, {})
