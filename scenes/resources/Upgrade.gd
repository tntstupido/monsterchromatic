extends Resource
class_name Upgrade

@export var id: String
@export var title: String
@export_multiline var description: String
# @export var icon: Texture2D # Uncomment when we have icons

func apply_upgrade(player: Node) -> void:
	print("Applying upgrade: ", title)
	# Logic will be implemented in subclasses or via strict ID checking in UpgradeManager
