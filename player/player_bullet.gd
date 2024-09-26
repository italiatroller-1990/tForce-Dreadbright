extends Area3D

# Speed of the projectile
var speed: float = 30
var lifetime: float = 3.0  # Time before the projectile is removed

# Called when the projectile is instantiated
func _ready() -> void:
	# Start the movement
	set_as_top_level(true)  # Ensure it moves independently of parent transformations
	
	# Start a timer to remove the projectile
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta: float) -> void:
	# Move the projectile forward
	position += -transform.basis.z * speed * delta

func _on_area_entered(area: Area3D) -> void:
	print("solid hit!")
	queue_free()
	$"hit sfx".play()
	if area.is_in_group("enemy"):
		print("enemy hit!")
		queue_free()


func _on_timer_timeout() -> void:
	print("bullet disappeared")
	queue_free()
