# Tactical Evolution Chess

Juego táctico por turnos en 3D isométrico, desarrollado en **Godot 4.6**. Combina elementos de ajedrez por zonas con un profundo sistema de personalización de unidades (10 atributos, 30 razas, 10 clases, 8 oficios).

---

## Captura

*(pendiente)*

---

## Características

### Tablero
- Hex grid radial (R15) en coordenadas axiales (q, r)
- 7 **Zonas de Convergencia**: centro + 6 a distancia 9, con brillo pulsante
- Cámara isométrica con zoom (rueda del ratón)

### Sistema de Datos (Fase 1)
- **10 Atributos**: FUE, ENE, FOR, VEL, RES, SAB, ESP, DES, CON, DEF
- **30 Razas** en 3 grupos (Humanoides, Bestias, No-humanos), cada una con stats base que suman 100 + pasiva racial + bono de terreno
- **10 Clases** con distribución porcentual de atributos (total 100%) + habilidad pasiva y activa
- **8 Oficios**: Comandante, Guardia, Médico, Explorador, Ingeniero, Infiltrado, Artillero, Vanguardista — cada uno con pasiva y activa
- **Sistema de Fichas**: matriz de crecimiento basada en distancia del atributo principal (17%→3%)
- **Fórmula de estadística final**: `Base × (1 + %mods) + crecimiento + bonos`
- **HP** = `CON × 5`

### Creador de Unidades
- Panel visual para crear unidades seleccionando Raza, Clase, Ficha y Oficio
- Selección de bando (Azul / Rojo)
- Las unidades aparecen en la Zona de Convergencia base (9,0)
- Navegación por teclado: flechas, Z para confirmar, X para cerrar

### Controles del Juego
| Tecla | Acción |
|-------|--------|
| Flechas | Mover cursor |
| Z | Seleccionar unidad |
| X | Mover unidad al cursor |
| C | Abrir/cerrar panel de información |
| A / S | Navegar pestañas del panel |
| E | Terminar turno de la unidad actual |

### Sistema de Turnos
- Alterna entre equipo **Azul** y **Rojo**
- Cada unidad puede actuar una vez por ronda
- Las unidades que ya actuaron se marcan con anillo gris
- Indicador visual de turno y ronda

### Interfaz
- Panel de unidad con 7 pestañas (Raza, Oficios, Ficha, Equipamiento, Estadísticas, Inventario, Habilidades)
- Barras de HP 3D sobre cada unidad (verde >60%, amarillo 30-60%, rojo <30%)
- Cursor 3D visible (blanco inactivo, rojo con unidad seleccionada)

---

## Estructura del Proyecto

```
tactical-evo/
├── main_3d.tscn              # Escena principal
├── scenes/unit.tscn          # Escena de unidad
├── scripts/
│   ├── main_3d.gd            # Controlador principal
│   ├── cursor_3d.gd          # Cursor 3D
│   ├── hex_grid_3d.gd        # Generación del tablero
│   ├── turn_manager.gd       # Lógica de turnos
│   ├── unit.gd               # Lógica de unidad
│   ├── data/
│   │   ├── enums.gd          # Atributos y constantes
│   │   ├── race_data.gd      # 30 razas
│   │   ├── class_data.gd     # 10 clases
│   │   ├── piece_data.gd     # Matriz de crecimiento
│   │   ├── office_data.gd    # 8 oficios
│   │   └── stat_calculator.gd # Fórmula de stats
│   └── ui/
│       ├── unit_creator.gd   # Panel de creación
│       ├── unit_info.gd      # Panel de información
│       └── turn_indicator.gd # Indicador de turno
└── materials/                # Materiales 3D
```

---

## Próximos Pasos

- [ ] Movimiento con rango (basado en VEL, tiles resaltados)
- [ ] Combate (fórmula de daño usando los 10 atributos)
- [ ] IA enemiga básica
- [ ] Condiciones de victoria/derrota
- [ ] Sistema de equipamiento
- [ ] Subida de nivel y experiencia
- [ ] Habilidades activas de clase y oficio

---

## Requisitos

- **Godot 4.6+** (descargar de https://godotengine.org)
- Sistema operativo: Windows, Linux o macOS

## Cómo ejecutar

1. Clonar el repositorio
2. Abrir Godot 4.6
3. Importar el proyecto (`project.godot`)
4. Presionar F5 (Ejecutar)

---

## Licencia

MIT
