# Half-edge data structure as described here:
# https://en.wikipedia.org/wiki/Doubly_connected_edge_list

class_name HalfEdgeGraph

extends Resource

class HalfEdge:
	var next: HalfEdge = null
	var twin: HalfEdge = null
	var origin: Vertex = null
	var face: Face = null
	
class Vertex:
	var pos: Vector2 = Vector2.ZERO
	var edge: HalfEdge = null
	
class Face:
	var edge: HalfEdge = null

var edges: Array[HalfEdge] = []
var vertices: Array[Vertex] = []
var faces: Array[Face] = []



# Destructor
# https://docs.godotengine.org/en/stable/tutorials/best_practices/data_preferences.html
func _notification(p_what):
	match p_what:
		NOTIFICATION_PREDELETE:
			for edge in edges:
				edge.free()
			for vertex in vertices:
				vertex.free()
			for face in faces:
				face.free()
