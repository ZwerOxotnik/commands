local module = {}


local KIT_COOLDOWN = 60 * 60 * 20 -- 20 mins
local KIT_ITEMS = { -- TODO: check prototypes before the loaded game
	{"iron-plate", 300},
	{"copper-plate", 200},
	{"electronic-circuit", 200},
	{"iron-gear-wheel", 200},
	{"burner-inserter", 20},
	{"inserter", 10},
	{"transport-belt", 200},
	{"small-electric-pole", 30},
	{"stone-furnace", 20},
	{"assembling-machine-1", 10},
	{"pipe", 50},
	{"wooden-chest", 10},
	{"steam-engine", 5},
	{"boiler", 2},
	{"lab", 1},
	{"small-lamp", 10},
	{"pistol", 1},
	{"firearm-magazine", 30},
	{"wood", 100},
	{"offshore-pump", 1},
	{"repair-pack", 10},
}


local function kit_command(cmd)
	local player = game.get_player(cmd.player_index)

	local kit_last_use = global.z_commands.kit_last_use
	if kit_last_use[cmd.player_index] ~= nil then
		if kit_last_use[cmd.player_index] < game.tick + KIT_COOLDOWN then
			player.print({"z_commands.respons.kit_time"}) -- TODO: show time for next kit
			return
		end
	end
	kit_last_use[cmd.player_index] = game.tick

	for _, item in pairs(KIT_ITEMS) do
		if game.item_prototypes[item[1]] then
			player.insert{name = item[1], count = item[2]}
		else
			log("\""..item[1].."\" doesn't exist in the game, please check spelling.")
		end
	end
	player.print({"z_commands.respons.added_kit"})
end


local function on_player_removed(event)
	local data = global.z_commands
	data.kit_last_use[event.player_index] = nil
end


local function update_global_data()
	global.z_commands = global.z_commands or {}
	local data = global.z_commands
	data.kit_last_use = data.kit_last_use or {}
end


module.on_init = update_global_data
module.on_configuration_changed = update_global_data

-- Check mod-commands.lua
module.commands = {
	kit = kit_command
}

module.events = {
	[defines.events.on_player_removed] = on_player_removed
}


return module
