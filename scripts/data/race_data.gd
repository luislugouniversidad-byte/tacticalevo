class_name RaceData

enum Group { HUMANOID, BEAST, NON_HUMAN }

const RACES = {
	# ── Humanoides ──
	"Orco": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:16, Enums.Stat.ENE:14, Enums.Stat.FOR:12, Enums.Stat.VEL:8, Enums.Stat.RES:6, Enums.Stat.SAB:4, Enums.Stat.ESP:6, Enums.Stat.DES:8, Enums.Stat.CON:12, Enums.Stat.DEF:14 },
		"passive_name": "Fervor de Sangre",
		"passive_desc": "Al causar daño cuerpo a cuerpo, recupera 10% de Energía (20% si el objetivo sangra).",
		"terrain": "Desierto/Baldío",
		"terrain_bonus": "+VEL, rec. Energía ×2",
	},
	"Infernal": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:14, Enums.Stat.ENE:16, Enums.Stat.FOR:14, Enums.Stat.VEL:12, Enums.Stat.RES:8, Enums.Stat.SAB:6, Enums.Stat.ESP:4, Enums.Stat.DES:6, Enums.Stat.CON:8, Enums.Stat.DEF:12 },
		"passive_name": "Toque Erosivo",
		"passive_desc": "Ataques físicos aplican Erosión (-5% DEF por acumulación, máx 3).",
		"terrain": "Volcán/Lava",
		"terrain_bonus": "+DES, rec. Energía ×2",
	},
	"Genio": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:12, Enums.Stat.ENE:14, Enums.Stat.FOR:16, Enums.Stat.VEL:14, Enums.Stat.RES:12, Enums.Stat.SAB:8, Enums.Stat.ESP:6, Enums.Stat.DES:4, Enums.Stat.CON:6, Enums.Stat.DEF:8 },
		"passive_name": "Sinfonía de Espíritu",
		"passive_desc": "Reduce coste de Espíritu en 5/10/15% según nivel.",
		"terrain": "Zonas de Convergencia",
		"terrain_bonus": "+RES, rec. Espíritu ×2",
	},
	"Mediano": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:8, Enums.Stat.ENE:12, Enums.Stat.FOR:14, Enums.Stat.VEL:16, Enums.Stat.RES:14, Enums.Stat.SAB:12, Enums.Stat.ESP:8, Enums.Stat.DES:6, Enums.Stat.CON:4, Enums.Stat.DEF:6 },
		"passive_name": "Fortuna del Pequeño",
		"passive_desc": "+5/10/15% probabilidad de Golpe Crítico según nivel.",
		"terrain": "Pradera",
		"terrain_bonus": "+Evasión, rec. Energía ×2",
	},
	"Elfo": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:6, Enums.Stat.ENE:8, Enums.Stat.FOR:12, Enums.Stat.VEL:14, Enums.Stat.RES:16, Enums.Stat.SAB:14, Enums.Stat.ESP:12, Enums.Stat.DES:8, Enums.Stat.CON:6, Enums.Stat.DEF:4 },
		"passive_name": "Sinfonía de Espíritu",
		"passive_desc": "Reduce coste de Espíritu en 5/10/15% según nivel.",
		"terrain": "Vegetación/Bosque",
		"terrain_bonus": "+5/10/15% a todas las stats, rec. Espíritu ×2",
	},
	"Hada": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:4, Enums.Stat.ENE:6, Enums.Stat.FOR:8, Enums.Stat.VEL:12, Enums.Stat.RES:14, Enums.Stat.SAB:16, Enums.Stat.ESP:14, Enums.Stat.DES:12, Enums.Stat.CON:8, Enums.Stat.DEF:6 },
		"passive_name": "Cuerpo Etéreo",
		"passive_desc": "Al recibir daño físico, desvía 20% a Espíritu en lugar de HP.",
		"terrain": "Flores/Estanques",
		"terrain_bonus": "+RES, rec. Espíritu ×2",
	},
	"Angelical": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:6, Enums.Stat.ENE:4, Enums.Stat.FOR:6, Enums.Stat.VEL:8, Enums.Stat.RES:12, Enums.Stat.SAB:14, Enums.Stat.ESP:16, Enums.Stat.DES:14, Enums.Stat.CON:12, Enums.Stat.DEF:8 },
		"passive_name": "Gracia Celestial",
		"passive_desc": "Exceso de curación se convierte en escudo (50% del valor, máx 20% HP).",
		"terrain": "Altares/Templos",
		"terrain_bonus": "+ESP, rec. Espíritu ×2",
	},
	"Humano": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:8, Enums.Stat.ENE:6, Enums.Stat.FOR:4, Enums.Stat.VEL:6, Enums.Stat.RES:8, Enums.Stat.SAB:12, Enums.Stat.ESP:14, Enums.Stat.DES:16, Enums.Stat.CON:14, Enums.Stat.DEF:12 },
		"passive_name": "Adaptación",
		"passive_desc": "+5/10/15% a las 5 stats más altas de oficios/profesiones; igual reducción a las 5 más bajas.",
		"terrain": "Llanura neutra",
		"terrain_bonus": "+5% a todas las stats",
	},
	"Gigante": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:12, Enums.Stat.ENE:8, Enums.Stat.FOR:6, Enums.Stat.VEL:4, Enums.Stat.RES:6, Enums.Stat.SAB:8, Enums.Stat.ESP:12, Enums.Stat.DES:14, Enums.Stat.CON:16, Enums.Stat.DEF:14 },
		"passive_name": "Impacto Sísmico",
		"passive_desc": "Ataques cuerpo a cuerpo: 20/30/40% de empujar 1 casilla. Si está obstruido, +20% daño.",
		"terrain": "Montaña/Nieve",
		"terrain_bonus": "Ignora terreno difícil, rec. Energía ×2",
	},
	"Enano": {
		"group": Group.HUMANOID,
		"stats": { Enums.Stat.FUE:14, Enums.Stat.ENE:12, Enums.Stat.FOR:8, Enums.Stat.VEL:6, Enums.Stat.RES:4, Enums.Stat.SAB:6, Enums.Stat.ESP:8, Enums.Stat.DES:12, Enums.Stat.CON:14, Enums.Stat.DEF:16 },
		"passive_name": "Inercia de Piedra",
		"passive_desc": "Mitiga 50% daño por Sangrado/Erosión. Inmune a Aturdimiento.",
		"terrain": "Cuevas/Montañas",
		"terrain_bonus": "+DEF, rec. Energía ×2",
	},

	# ── Bestias ──
	"Colmillo": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:18, Enums.Stat.ENE:16, Enums.Stat.FOR:14, Enums.Stat.VEL:6, Enums.Stat.RES:4, Enums.Stat.SAB:2, Enums.Stat.ESP:4, Enums.Stat.DES:6, Enums.Stat.CON:14, Enums.Stat.DEF:16 },
		"passive_name": "Depredador Alfa",
		"passive_desc": "+15/20/25% daño vs objetivos con HP < 50%.",
		"terrain": "Bosque/Selva",
		"terrain_bonus": "+VEL, rec. Energía ×2",
	},
	"Garra": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:16, Enums.Stat.ENE:18, Enums.Stat.FOR:16, Enums.Stat.VEL:14, Enums.Stat.RES:6, Enums.Stat.SAB:4, Enums.Stat.ESP:2, Enums.Stat.DES:4, Enums.Stat.CON:6, Enums.Stat.DEF:14 },
		"passive_name": "Frenesí Salvaje",
		"passive_desc": "+5% daño por ataque consecutivo al mismo objetivo (máx 4).",
		"terrain": "Colinas/Rocas",
		"terrain_bonus": "+FUE, rec. Energía ×2",
	},
	"Aleta": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:14, Enums.Stat.ENE:16, Enums.Stat.FOR:18, Enums.Stat.VEL:16, Enums.Stat.RES:14, Enums.Stat.SAB:6, Enums.Stat.ESP:4, Enums.Stat.DES:2, Enums.Stat.CON:4, Enums.Stat.DEF:6 },
		"passive_name": "Impulso Acuático",
		"passive_desc": "+1 mov. y +10% precisión en casillas adyacentes a agua.",
		"terrain": "Ríos/Playas",
		"terrain_bonus": "+DES, rec. Energía ×2",
	},
	"Pluma": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:6, Enums.Stat.ENE:14, Enums.Stat.FOR:16, Enums.Stat.VEL:18, Enums.Stat.RES:16, Enums.Stat.SAB:14, Enums.Stat.ESP:6, Enums.Stat.DES:4, Enums.Stat.CON:2, Enums.Stat.DEF:4 },
		"passive_name": "Vuelo Rasante",
		"passive_desc": "Sobrevuela obstáculos ≤1. +10/15/20% daño desde casilla elevada.",
		"terrain": "Cielo abierto/Acantilados",
		"terrain_bonus": "+FOR, rec. Energía ×2",
	},
	"Insecto": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:4, Enums.Stat.ENE:6, Enums.Stat.FOR:14, Enums.Stat.VEL:16, Enums.Stat.RES:18, Enums.Stat.SAB:16, Enums.Stat.ESP:14, Enums.Stat.DES:6, Enums.Stat.CON:4, Enums.Stat.DEF:2 },
		"passive_name": "Enjambre Adaptable",
		"passive_desc": "+2% Evasión al recibir ataque (máx 6 acumulaciones, 2 turnos).",
		"terrain": "Pantano/Ciénaga",
		"terrain_bonus": "+RES, rec. Espíritu ×2",
	},
	"Escama": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:2, Enums.Stat.ENE:4, Enums.Stat.FOR:6, Enums.Stat.VEL:14, Enums.Stat.RES:16, Enums.Stat.SAB:18, Enums.Stat.ESP:16, Enums.Stat.DES:14, Enums.Stat.CON:6, Enums.Stat.DEF:4 },
		"passive_name": "Reflejo Prismático",
		"passive_desc": "Refleja 10/15/20% daño mágico recibido al atacante.",
		"terrain": "Cristales/Cavernas brillantes",
		"terrain_bonus": "+SAB, rec. Espíritu ×2",
	},
	"Húmedo": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:4, Enums.Stat.ENE:2, Enums.Stat.FOR:4, Enums.Stat.VEL:6, Enums.Stat.RES:14, Enums.Stat.SAB:16, Enums.Stat.ESP:18, Enums.Stat.DES:16, Enums.Stat.CON:14, Enums.Stat.DEF:6 },
		"passive_name": "Piel Mucosa",
		"passive_desc": "Reduce 10% daño físico. Inmune a Quemadura.",
		"terrain": "Pantano/Río",
		"terrain_bonus": "+DEF, rec. Energía ×2",
	},
	"Pulgar": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:6, Enums.Stat.ENE:4, Enums.Stat.FOR:2, Enums.Stat.VEL:4, Enums.Stat.RES:6, Enums.Stat.SAB:14, Enums.Stat.ESP:16, Enums.Stat.DES:18, Enums.Stat.CON:16, Enums.Stat.DEF:14 },
		"passive_name": "Agarre Firme",
		"passive_desc": "30/40/50% de enraizar al objetivo al golpear cuerpo a cuerpo.",
		"terrain": "Bosque/Montaña",
		"terrain_bonus": "+FUE, rec. Energía ×2",
	},
	"Cuerno": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:14, Enums.Stat.ENE:6, Enums.Stat.FOR:4, Enums.Stat.VEL:2, Enums.Stat.RES:4, Enums.Stat.SAB:6, Enums.Stat.ESP:14, Enums.Stat.DES:16, Enums.Stat.CON:18, Enums.Stat.DEF:16 },
		"passive_name": "Carga Imparable",
		"passive_desc": "+20/30/40% daño y derribo si se mueve ≥2 casillas en línea recta antes de atacar.",
		"terrain": "Llanura/Estepa",
		"terrain_bonus": "+VEL, rec. Energía ×2",
	},
	"Caparazón": {
		"group": Group.BEAST,
		"stats": { Enums.Stat.FUE:16, Enums.Stat.ENE:14, Enums.Stat.FOR:6, Enums.Stat.VEL:4, Enums.Stat.RES:2, Enums.Stat.SAB:4, Enums.Stat.ESP:6, Enums.Stat.DES:14, Enums.Stat.CON:16, Enums.Stat.DEF:18 },
		"passive_name": "Fortaleza Viva",
		"passive_desc": "+20/30/40% DEF y RES si no se movió el turno anterior.",
		"terrain": "Desierto/Ruinas",
		"terrain_bonus": "+CON, rec. Energía ×2",
	},

	# ── No-humanos ──
	"Dragón": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:17, Enums.Stat.ENE:16, Enums.Stat.FOR:15, Enums.Stat.VEL:5, Enums.Stat.RES:4, Enums.Stat.SAB:3, Enums.Stat.ESP:4, Enums.Stat.DES:5, Enums.Stat.CON:15, Enums.Stat.DEF:16 },
		"passive_name": "Aliento Primordial",
		"passive_desc": "Ataque de aliento en cono (3 casillas): (FUE+SAB)×1.2. Enf: 3 turnos.",
		"terrain": "Montañas/Volcanes",
		"terrain_bonus": "+RES, rec. Energía ×2",
	},
	"Piel-Verde": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:16, Enums.Stat.ENE:17, Enums.Stat.FOR:16, Enums.Stat.VEL:15, Enums.Stat.RES:5, Enums.Stat.SAB:4, Enums.Stat.ESP:3, Enums.Stat.DES:4, Enums.Stat.CON:5, Enums.Stat.DEF:15 },
		"passive_name": "Regeneración Acelerada",
		"passive_desc": "Regenera 5/10/15% HP máximo al iniciar turno si no recibió daño el turno anterior.",
		"terrain": "Bosque/Pantano",
		"terrain_bonus": "+VEL, rec. Energía ×2",
	},
	"Cósmico": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:15, Enums.Stat.ENE:16, Enums.Stat.FOR:17, Enums.Stat.VEL:16, Enums.Stat.RES:15, Enums.Stat.SAB:5, Enums.Stat.ESP:4, Enums.Stat.DES:3, Enums.Stat.CON:4, Enums.Stat.DEF:5 },
		"passive_name": "Singularidad",
		"passive_desc": "15% de no consumir Espíritu al lanzar habilidad mágica.",
		"terrain": "Zonas de Convergencia / Noche estrellada",
		"terrain_bonus": "+FOR, rec. Espíritu ×2",
	},
	"Monstruo": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:5, Enums.Stat.ENE:15, Enums.Stat.FOR:16, Enums.Stat.VEL:17, Enums.Stat.RES:16, Enums.Stat.SAB:15, Enums.Stat.ESP:5, Enums.Stat.DES:4, Enums.Stat.CON:3, Enums.Stat.DEF:4 },
		"passive_name": "Piel Gruesa",
		"passive_desc": "Mitiga 5/10/15% de todo daño recibido.",
		"terrain": "Cuevas/Túneles",
		"terrain_bonus": "+FUE, rec. Energía ×2",
	},
	"Aberracion": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:4, Enums.Stat.ENE:5, Enums.Stat.FOR:15, Enums.Stat.VEL:16, Enums.Stat.RES:17, Enums.Stat.SAB:16, Enums.Stat.ESP:15, Enums.Stat.DES:5, Enums.Stat.CON:4, Enums.Stat.DEF:3 },
		"passive_name": "Mutación Adaptativa",
		"passive_desc": "Gana +10% aleatorio a dos stats base al inicio del turno.",
		"terrain": "Ruinas/Zonas corruptas",
		"terrain_bonus": "+SAB, rec. Espíritu ×2",
	},
	"Elemental": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:3, Enums.Stat.ENE:4, Enums.Stat.FOR:5, Enums.Stat.VEL:15, Enums.Stat.RES:16, Enums.Stat.SAB:17, Enums.Stat.ESP:16, Enums.Stat.DES:15, Enums.Stat.CON:5, Enums.Stat.DEF:4 },
		"passive_name": "Esencia Cambiante",
		"passive_desc": "Elige aspecto al iniciar turno: Fuego (+FUE), Agua (+RES), Tierra (+DEF), Aire (+VEL).",
		"terrain": "Variable según aspecto",
		"terrain_bonus": "Ajuste dinámico",
	},
	"No-Muerto": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:4, Enums.Stat.ENE:3, Enums.Stat.FOR:4, Enums.Stat.VEL:5, Enums.Stat.RES:15, Enums.Stat.SAB:16, Enums.Stat.ESP:17, Enums.Stat.DES:16, Enums.Stat.CON:15, Enums.Stat.DEF:5 },
		"passive_name": "Toque de Drenaje",
		"passive_desc": "Recupera HP = 15% del daño infligido con ataques físicos.",
		"terrain": "Cementerio/Ruinas oscuras",
		"terrain_bonus": "+DES, rec. Espíritu ×2",
	},
	"Máquina": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:5, Enums.Stat.ENE:4, Enums.Stat.FOR:3, Enums.Stat.VEL:4, Enums.Stat.RES:5, Enums.Stat.SAB:15, Enums.Stat.ESP:16, Enums.Stat.DES:17, Enums.Stat.CON:16, Enums.Stat.DEF:15 },
		"passive_name": "Blindaje Autorreparable",
		"passive_desc": "20% de recuperar 5% HP máximo al recibir daño.",
		"terrain": "Talleres/Forjas",
		"terrain_bonus": "+CON, rec. Energía ×2",
	},
	"Planta": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:15, Enums.Stat.ENE:5, Enums.Stat.FOR:4, Enums.Stat.VEL:3, Enums.Stat.RES:4, Enums.Stat.SAB:5, Enums.Stat.ESP:15, Enums.Stat.DES:16, Enums.Stat.CON:17, Enums.Stat.DEF:16 },
		"passive_name": "Arraigo Vital",
		"passive_desc": "Si no se mueve, recupera 5/10/15% HP máximo al final del turno.",
		"terrain": "Bosque/Selva",
		"terrain_bonus": "+DEF, rec. Espíritu ×2",
	},
	"Constructo": {
		"group": Group.NON_HUMAN,
		"stats": { Enums.Stat.FUE:16, Enums.Stat.ENE:15, Enums.Stat.FOR:5, Enums.Stat.VEL:4, Enums.Stat.RES:3, Enums.Stat.SAB:4, Enums.Stat.ESP:5, Enums.Stat.DES:15, Enums.Stat.CON:16, Enums.Stat.DEF:17 },
		"passive_name": "Integridad Estructural",
		"passive_desc": "Anula el daño extra de Golpes Críticos.",
		"terrain": "Minas/Canteras",
		"terrain_bonus": "+RES, rec. Energía ×2",
	},
}

static func get_race_names() -> Array:
	return RACES.keys()

static func get_race(race_name: String) -> Dictionary:
	return RACES.get(race_name, {})

static func get_group_races(group: int) -> Array:
	var result = []
	for name in RACES:
		if RACES[name].group == group:
			result.append(name)
	return result
