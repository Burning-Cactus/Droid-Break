extends Label

var timer: int = 0

func _process(delta: float) -> void:
	var color: Color = get_theme_color("font_color")
	# Let the alpha range from 0 to 1
	var alpha: float = 0.5 * sin(timer * 0.015) + 0.5
	color.a = alpha
	add_theme_color_override("font_color", color)
	
	color = get_theme_color("font_shadow_color")
	color.a = alpha
	add_theme_color_override("font_shadow_color", color)
	
	timer += 1
	
