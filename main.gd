extends Node2D
@onready var grid = $GridContainer

var lives
var correct_taps = 0
var game_active = true
var current_level

func _ready():
	current_level = create_level(1)
	lives = current_level.lives
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
	var colours = current_level.available_colours
	random_tile.light_up(colours.pick_random())

	await get_tree().create_timer(current_level.tile_duration).timeout
	random_tile.turn_grey()

func start_spawning():
	while game_active:
		show_random_tile()
		await get_tree().create_timer(current_level.spawn_interval).timeout

func _on_tile_clicked(tile):
	if tile.current_colour == current_level.forbidden_colour:
		lives -= 1
		print("WRONG! Lives left: ", lives)

		if lives <= 0:
			game_active = false
			print("GAME OVER!")

	else:
		correct_taps += 1
		print("Correct taps: ", correct_taps)

		if correct_taps >= current_level.target_taps:
			game_active = false
			print("LEVEL COMPLETE!")

	tile.turn_grey()

func create_level(level_number):
	if level_number == 1:
		return Level.new(
			1,
			5,
			3,
			1.7,
			1.5,
			[Color.RED, Color.BLUE],
			Color.BLUE,
			0,
			false
		)
	
