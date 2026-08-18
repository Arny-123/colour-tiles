extends Node2D
@onready var grid = $GridContainer

var spawn_interval = 1.8
var forbidden_colour = Color.BLUE
var correct_taps = 0
var target_taps = 5
var lives = 3

func _ready():
	create_grid()
	start_spawning()


func create_grid():
	for i in range(36):
		var new_tile = Tile.new()
		new_tile.custom_minimum_size = Vector2(100, 100)
		new_tile.color = Color("#303030")
		grid.add_child(new_tile)
		new_tile.tile_clicked.connect(_on_tile_clicked)


func show_random_tile():
	var available_tiles = []

	for tile in grid.get_children():
		if not tile.is_coloured:
			available_tiles.append(tile)

	if available_tiles.is_empty():
		return

	var random_tile = available_tiles.pick_random()
	var colours = [Color.RED, Color.BLUE, Color.GREEN, Color.YELLOW]
	random_tile.light_up(colours.pick_random())

	await get_tree().create_timer(1.5).timeout
	random_tile.turn_grey()

func start_spawning():
	while true:
		show_random_tile()
		await get_tree().create_timer(spawn_interval).timeout


func _on_tile_clicked(tile):
	if tile.current_colour == forbidden_colour:
		print("WRONG!")
	else:
		print("CORRECT!")
		correct_taps += 1
		print(correct_taps)
	tile.turn_grey()
	if correct_taps >= target_taps:
		print("LEVEL COMPLETE!")
	
