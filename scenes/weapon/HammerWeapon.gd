extends "res://scenes/weapon/MeleeWeapon.gd"

@export var min_radius: float = 40.0
@export var max_radius: float = 80.0
@export var wobble_speed: float = 5.0

var _time: float = 0.0

func _process(delta: float) -> void:
	super._process(delta)
	
	# Only apply wobble if we are attacking (rotating)
	# MeleeWeapon rotates the parent node.
	# We want to move the children (Sprite/Hitbox) in and out to create an ellipse/wobble.
	
	if _hitbox and _hitbox.monitoring: # monitoring is true during attack in MeleeWeapon
		_time += delta * wobble_speed
		var current_radius = lerp(min_radius, max_radius, (sin(_time) + 1.0) / 2.0)
		
		# Update positions of visual and hitbox
		if _sprite:
			_sprite.position.x = current_radius
		if _hitbox:
			# Hitbox collision shape is usually offset, or the hitbox itself is.
			# In Hammer.tscn, CollisionShape2D is at (60, 0).
			# We should probably move the CollisionShape2D or the Hitbox children.
			# Let's check how Hammer.tscn is structured.
			# Hitbox is at (0,0), CollisionShape2D is at (60,0).
			for child in _hitbox.get_children():
				if child is Node2D:
					child.position.x = current_radius
