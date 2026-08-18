class_name Tile
extends ColorRect
signal tile_clicked(tile)

var is_coloured = false
var current_colour

func light_up(new_colour):
    is_coloured = true
    current_colour = new_colour
    color = new_colour
    

func turn_grey():
    is_coloured = false
    current_colour = null
    color = Color("#303030")

func _gui_input(event):
    if event is InputEventMouseButton and event.pressed:
        if is_coloured:
            tile_clicked.emit(self)