class_name Level

var level_number
var target_taps
var lives
var spawn_interval
var tile_duration
var available_colours
var forbidden_colour
var forbidden_changes
var is_challenge_level

func _init(
	level_number,
	target_taps,
	lives,
	spawn_interval,
	tile_duration,
	available_colours,
	forbidden_colour,
	forbidden_changes,
	is_challenge_level
):
	self.level_number = level_number
	self.target_taps = target_taps
	self.lives = lives
	self.spawn_interval = spawn_interval
	self.tile_duration = tile_duration
	self.available_colours = available_colours
	self.forbidden_colour = forbidden_colour
	self.forbidden_changes = forbidden_changes
	self.is_challenge_level = is_challenge_level