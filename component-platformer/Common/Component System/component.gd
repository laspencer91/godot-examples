class_name Component extends Node

var components: Array[Component] = []

func _ready() -> void:
	for child in get_parent().get_children():
		if child is Component:
			components.push_back(child)
	_component_ready()

func _component_ready() -> void:
	pass

func get_component(type: Variant):
	for component in components:
		if is_instance_of(component, type):
			return component
	push_error("%s component not found." % str(type))
