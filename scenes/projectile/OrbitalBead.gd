extends Area2D

@export var damage: float = 8.0
@export var hit_sound: AudioStream

var _hit_enemies: Dictionary = {}  # enemy -> cooldown timer
const HIT_COOLDOWN: float = 0.5  # Time between hits on same enemy

# Array of bead textures for variety
const BEAD_TEXTURES = [
	"res://assets/weapons/prayer_beads_multi/prayer_bead_01.png",
	"res://assets/weapons/prayer_beads_multi/prayer_bead_02.png",
	"res://assets/weapons/prayer_beads_multi/prayer_bead_03.png",
	"res://assets/weapons/prayer_beads_multi/prayer_bead_04.png",
]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	collision_layer = 0
	collision_mask = 2  # Enemy layer

	# Randomize bead texture
	_randomize_texture()

func _process(delta: float) -> void:
	# Decrease cooldown timers
	var enemies_to_remove: Array = []
	for enemy in _hit_enemies:
		_hit_enemies[enemy] -= delta
		if _hit_enemies[enemy] <= 0.0:
			enemies_to_remove.append(enemy)

	for enemy in enemies_to_remove:
		_hit_enemies.erase(enemy)

func _randomize_texture() -> void:
	# Get the Sprite2D node and set a random bead texture
	var sprite = get_node_or_null("Sprite2D")
	if sprite and sprite is Sprite2D:
		var random_texture_path = BEAD_TEXTURES[randi() % BEAD_TEXTURES.size()]
		if ResourceLoader.exists(random_texture_path):
			sprite.texture = load(random_texture_path)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("enemy"):
		return

	# Check if we can hit this enemy (cooldown expired)
	if body in _hit_enemies:
		return

	# Deal damage
	if body.has_method("take_damage"):
		body.take_damage(damage)

		# Play hit sound
		if hit_sound:
			AudioManager.play_sound(hit_sound, global_position)

		# Add to hit cooldown
		_hit_enemies[body] = HIT_COOLDOWN
