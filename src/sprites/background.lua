local Sprite = require("src.sprites.sprite")

local Background = {}
Background.__index = Background
setmetatable(Background, { __index = Sprite })

function Background:update(dt)
	self.posY = self.posY + self.speed * dt
	if self.posY >= self.height then
		self.posY = self.posY - (self.height * 2)
	end
end

return Background
