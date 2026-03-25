extends CharacterBody2D
@onready var eyes: Node2D = $eyes
@onready var area_2d: Area2D = $Area2D
@onready var ray_cast_2d: RayCast2D = $eyes/RayCast2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
