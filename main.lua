local love = require("love")
local game = require("src.game")

function love.load()
	game:init()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end
