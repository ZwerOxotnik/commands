local mod_commands = require("mod-commands")
local commands_control = require("commands-control")

-- Adds commands
mod_commands.handle_custom_commands(commands_control)


local event_handler
if script.active_mods["zk-lib"] then
	event_handler = require("__zk-lib__/static-libs/lualibs/event_handler_vZO.lua")
else
	event_handler = require("event_handler")
end
event_handler.add_libraries({mod_commands, commands_control})
