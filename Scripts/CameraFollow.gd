extends Camera2D

@export var target:Node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	self.position = target.position - Vector2(0, 24)
	pass
