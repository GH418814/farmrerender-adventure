extends Node

# Variables
var current_time : String = "2026-04-17 15:33:55"
var current_day : int = 1
var current_season : String = "Spring"

# Signals for time changes
signal time_changed(current_time, current_day, current_season)

# Function to advance time
func advance_time(hours:int):
    # Update the current time and day
    var hour = int(current_time.substr(11, 2)) + hours
    if hour >= 24:
        current_day += hour / 24
        hour = hour % 24

    current_time = current_time.substr(0, 11) + String.format("%02d", hour) + current_time.substr(13)
    emit_signal("time_changed", current_time, current_day, current_season)

# Function to handle day/night cycle
func update_day_night_cycle():
    var hour = int(current_time.substr(11, 2))
    if hour >= 6 and hour < 18:
        print("Daytime")
    else:
        print("Nighttime")

# Function to change season (simplified)
func change_season():
    match current_day:
        1: current_season = "Spring"
        31: current_season = "Summer"
        61: current_season = "Autumn"
        91: current_season = "Winter"
    emit_signal("time_changed", current_time, current_day, current_season)
