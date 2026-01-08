extends TileMapLayer

@export var view_distance: int = 25 # Radius in tiles to generate
@export var player_path: NodePath = "../../Player"

var _player: Node2D
var _last_player_tile_pos: Vector2i

func _ready() -> void:
	_player = get_node_or_null(player_path)
	if not _player:
		# Fallback if path is wrong, try to find in parents
		_player = get_parent().get_parent().get_node_or_null("Player")
	
	# Initial generation
	_update_floor()

func _process(_delta: float) -> void:
	if not _player:
		_player = get_tree().get_first_node_in_group("player") # Another fallback
		if not _player: return

	var current_tile = local_to_map(to_local(_player.global_position))
	if current_tile != _last_player_tile_pos:
		_last_player_tile_pos = current_tile
		_update_floor()

func _update_floor() -> void:
	if not _player: return
	
	var center = local_to_map(to_local(_player.global_position))
	
	# Loop through a square around the player
	for x in range(center.x - view_distance, center.x + view_distance):
		for y in range(center.y - view_distance, center.y + view_distance):
			var coords = Vector2i(x, y)
			
			# Check if tile is empty
			if get_cell_source_id(coords) == -1:
				# Randomly pick a tile from the 4x4 atlas (source id 0)
				var atlas_coords = Vector2i(randi() % 4, randi() % 4)
				set_cell(coords, 0, atlas_coords)
