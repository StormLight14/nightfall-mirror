extends Node

signal language_changed
signal inventory_updated
signal changed_hotbar_selection
signal night_started
signal night_ended
signal turning_day(time: float)
signal turning_night(time: float)
signal fade_completed(type: String) # "fade_in", "fade_out", "player_died"
signal show_gamble_ui
signal spawn_stalker
signal blind_player
