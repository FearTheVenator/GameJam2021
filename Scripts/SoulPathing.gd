extends KinematicBody

var path =[]
var path_node = 0
var speed = 2.5
#Gets the parent node: the kinematic soul
onready var nav = get_parent()
#This is the node that we are tracking it can be a player a cube a 3d position and so
#Ideally we will create an array of positions for the Ghost to path to
onready var goalPosition = get_node("/root/Maze/Goal")
func _ready():
	pass
func _physics_process(delta):
#This checks how many godot units away from its objective is
#The path actually places multiple node waypoints to figure out where its going
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed,Vector3.UP)
			
#Creates the path the ghost will follow to its target
func move_to(target_pos):
	#This is the part that actually uses the navigation mesh
	path = nav.get_simple_path(global_transform.origin,target_pos)
	path_node = 0
#Timer tells ghost when to think and check if it has arrived at its destination yet
func _on_Timer_timeout():
	print("here")
	move_to(goalPosition.global_transform.origin)
