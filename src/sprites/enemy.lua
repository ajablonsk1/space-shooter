local Sprite = require("src.sprites.sprite")
local Globals = require("globals")

local Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy, { __index = Sprite })

function Enemy:new(o)
	local enemy = Sprite:new(o)
	enemy.points = o.points
	setmetatable(enemy, self)
	return enemy
end

function Enemy:update(dt)
	self:moveBy(0, self.speed * dt)
end

return Enemy
