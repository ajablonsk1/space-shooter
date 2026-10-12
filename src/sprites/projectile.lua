local Sprite = require("src.sprites.sprite")
local Direction = require("src.utils.direction")

local Projectile = {}
Projectile.__index = Projectile
setmetatable(Projectile, { __index = Sprite })

function Projectile:new(o)
	local projectile = Sprite:new(o)
	projectile.direction = o.direction or Direction.NORTH
	setmetatable(projectile, self)
	return projectile
end

function Projectile:update(dt)
	if self.direction == Direction.NORTH then
		self:moveBy(0, -self.speed * dt)
	elseif self.direction == Direction.SOUTH then
		self:moveBy(0, -self.speed * dt)
	end
end

return Projectile
