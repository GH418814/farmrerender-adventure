extends Node
class_name FarmManager

signal crop_planted(tile_pos, crop_type)
signal crop_watered(tile_pos)
signal crop_harvested(tile_pos, crop_type)

# crops: dictionary keyed by tile position string "x,y" -> {type, growth_stage, days_grown, watered}
var crops := {}
var days_per_growth_stage := 2

func _ready():
    pass

func _tile_key(tile_pos: Vector2) -> String:
    return str(tile_pos.x) + "," + str(tile_pos.y)

func plant_crop(tile_pos: Vector2, crop_type: String) -> bool:
    var key = _tile_key(tile_pos)
    if crops.has(key):
        return false # already planted
    crops[key] = {"type": crop_type, "growth_stage": 0, "days_grown": 0, "watered": false}
    emit_signal("crop_planted", tile_pos, crop_type)
    return true

func water_crop(tile_pos: Vector2) -> bool:
    var key = _tile_key(tile_pos)
    if not crops.has(key):
        return false
    crops[key]["watered"] = true
    emit_signal("crop_watered", tile_pos)
    return true

func harvest_crop(tile_pos: Vector2) -> Variant:
    var key = _tile_key(tile_pos)
    if not crops.has(key):
        return null
    var data = crops[key]
    if data["growth_stage"] < 3:
        return null # not ready
    var crop_type = data["type"]
    crops.erase(key)
    emit_signal("crop_harvested", tile_pos, crop_type)
    return crop_type

# Simulate daytime tick: advance days, growth if watered
func on_new_day():
    var to_update := []
    for key in crops.keys():
        var data = crops[key]
        if data["watered"]:
            data["days_grown"] += 1
            if data["days_grown"] >= days_per_growth_stage:
                data["growth_stage"] += 1
                data["days_grown"] = 0
        # reset watered flag for next day
        data["watered"] = false
        crops[key] = data

func get_crop(tile_pos: Vector2) -> Dictionary:
    var key = _tile_key(tile_pos)
    if crops.has(key):
        return crops[key]
    return {}

func get_all_crops() -> Dictionary:
    return crops
