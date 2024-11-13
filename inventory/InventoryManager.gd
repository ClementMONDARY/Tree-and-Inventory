extends Node

signal inventory_updated
signal hotbar_updated

var hotbar = []
var inventory = []
const HOTBAR_SIZE = 8
const INVENTORY_ROWS = 3
const INVENTORY_COLS = 8

func _ready():
	hotbar.resize(HOTBAR_SIZE)
	inventory.resize(INVENTORY_ROWS * INVENTORY_COLS)

func add_item(item: Item) -> bool:
    # Essayer d'abord la hotbar
	var slot = find_empty_slot_hotbar()
	if slot != -1:
		hotbar[slot] = item
		hotbar_updated.emit()
		return true
		
	# Sinon essayer l'inventaire principal
	slot = find_empty_slot_inventory()
	if slot != -1:
		inventory[slot] = item
		inventory_updated.emit()
		return true
    
	return false

func find_empty_slot_hotbar() -> int:
	for i in range(HOTBAR_SIZE):
		if hotbar[i] == null:
			return i
	return -1

func find_empty_slot_inventory() -> int:
	for i in range(inventory.size()):
		if inventory[i] == null:
			return i
	return -1