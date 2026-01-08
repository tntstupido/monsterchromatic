extends CanvasLayer

# Quick resolution tester for mobile aspect ratios

var test_resolutions = {
	"iPhone SE (9:16)": Vector2i(375, 667),
	"iPhone 14 (9:19.5)": Vector2i(390, 844),
	"Pixel 7 (9:20)": Vector2i(412, 915),
	"Galaxy S23 (9:19.5)": Vector2i(360, 780),
	"iPad (3:4)": Vector2i(810, 1080),
	"Desktop Test": Vector2i(720, 1280),
}

func _ready():
	var vbox = VBoxContainer.new()
	vbox.position = Vector2(10, 10)
	add_child(vbox)

	var label = Label.new()
	label.text = "Resolution Tester (F1 to hide)"
	label.modulate = Color.YELLOW
	vbox.add_child(label)

	for resolution_name in test_resolutions:
		var btn = Button.new()
		btn.text = resolution_name
		btn.pressed.connect(_change_resolution.bind(test_resolutions[resolution_name], resolution_name))
		vbox.add_child(btn)

	# Info label
	var info = Label.new()
	info.text = "Current: %dx%d" % [get_viewport().get_visible_rect().size.x, get_viewport().get_visible_rect().size.y]
	info.modulate = Color.CYAN
	vbox.add_child(info)

func _change_resolution(size: Vector2i, resolution_name: String):
	get_window().size = size
	print("Changed to: ", resolution_name, " - ", size)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F1:
		visible = not visible
