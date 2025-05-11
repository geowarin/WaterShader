@tool
@icon("uid://dx6sx8sm68rle")
extends MeshInstance3D
class_name WaterPlane

var _mat: ShaderMaterial = preload("uid://c3mh5p2w5s8g7")
var _normal: NoiseTexture2D = preload("uid://gq8n64t6y4go")
var _wave_noise: NoiseTexture2D = preload("uid://dhkuuan5kku8y")


func _ready() -> void:
    if Engine.is_editor_hint() && mesh == null:
        mesh = PlaneMesh.new()
        mesh.size = Vector2(1, 1)
        set_surface_override_material(0, _mat)
        _mat.set_shader_parameter(&"wave", _wave_noise)
        _mat.set_shader_parameter(&"texture_normal", _normal)
        _mat.set_shader_parameter(&"texture_normal2", _normal)
        subdivize()

@export var size := Vector2i(1, 1):
    set(value):
        size = value
        subdivize()

func subdivize() -> void:
    scale = Vector3(size.x, 1, size.y)
    mesh.size = Vector2(1, 1)
    mesh.subdivide_width = int(size.x * size.x)
    mesh.subdivide_depth = int(size.y * size.y)