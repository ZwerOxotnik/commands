local handler = require("event_handler")
local mod_commands = require("mod-commands")
local commands_control = require("commands-control")

-- Adds commands
mod_commands.handle_custom_commands(commands_control)

handler.add_libraries({mod_commands, commands_control})
