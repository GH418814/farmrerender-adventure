# InventorySystem.gd

# Managing player inventory including adding, removing, and tracking items

max_inventory_size = 24
var inventory = []

# Add item to the inventory
func add_item(item: String):
    if inventory.size() < max_inventory_size:
        inventory.append(item)
        print("Added: " + item)
    else:
        print("Inventory full, cannot add: " + item)

# Remove item from the inventory
func remove_item(item: String):
    if item in inventory:
        inventory.erase(item)
        print("Removed: " + item)
    else:
        print("Item not found: " + item)

# Get current inventory
func get_inventory():
    return inventory

# Check if inventory is full
func is_inventory_full() -> bool:
    return inventory.size() >= max_inventory_size

# Check number of items
func item_count() -> int:
    return inventory.size()