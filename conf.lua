local love = require("love")
local Globals = require("globals")

function love.conf(t)
	t.window.title = Globals.Game.title
	t.window.width = Globals.Game.width
	t.window.height = Globals.Game.height
end
