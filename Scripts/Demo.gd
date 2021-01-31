extends Spatial

const Wall = preload("res://Maze Assets/Wall.tscn")
const Floor = preload("res://Maze Assets/Floor.tscn")
#const Ball = preload("res://Player Assets/Human.tscn")
#const Ball = preload("res://Maze Assets/Ball.tscn")

#onready var camera = $kinematicBody/Pivot/Camera
onready var camera = $Camera
var camera_y
var ball: Node

func _ready():
	_build_maze(3.0, 0.0)
	#_set_up_ball(0.0, 0.0)
	#camera_y = camera.translation.y
	
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Music/Lobo Loco.ogg")
	player.play()
	
func _physics_process(delta):
	#camera.translation = Vector3(ball.translation.x - 5, max(camera_y, ball.translation.y + 20), ball.translation.z)
	#camera.rotation_degrees.z = 60
	pass
func _build_maze(cell_size: float, offset: float) -> void:
	var maze = $Spatial/MazeGenerator.generate_maze()
	for row in maze.number_rows:
		for column in maze.number_columns:
			var cell = maze.cell_at(row, column)
			
			var left_boundary = column * cell_size + offset 
			var right_boundary = (column + 0.5) * cell_size + offset
			var bottom_boundary = row * cell_size + offset 
			var top_boundary = (row + 0.5) * cell_size + offset
			
			var floor_ = Floor.instance()
			floor_.mesh.size = Vector2(cell_size, cell_size)
			floor_.translation = Vector3(left_boundary, 0, bottom_boundary)
			add_child(floor_)
			
			if cell.walls.E:
				_spawn_wall(right_boundary, bottom_boundary, PI / 2, cell_size)
				
			if cell.walls.W:
				_spawn_wall(left_boundary - cell_size * 0.5, bottom_boundary, PI / 2, cell_size)
				
			if cell.walls.N:
				_spawn_wall(left_boundary, top_boundary, 0, cell_size)
				
			if cell.walls.S:
				_spawn_wall(left_boundary,  bottom_boundary - cell_size * 0.5, 0, cell_size)
				
func _spawn_wall(x: float, z: float, rotate_y: float, cell_size: float):
	var wall = Wall.instance()
	wall.translation = Vector3(x, 2.5, z)
	wall.rotate_y(rotate_y)
	wall.width = cell_size
	wall.height = 5
	add_child(wall)

#func _set_up_ball(x: float, z: float):
	#ball = Ball.instance()
	#ball.translate(Vector3.UP * 5)
	#add_child(ball)
