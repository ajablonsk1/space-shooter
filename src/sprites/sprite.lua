local love = require("love")

local Sprite = {}
Sprite.__index = Sprite

function Sprite:new(o)
	o = o or {}
	o.posX = o.posX or 0
	o.posY = o.posY or 0
	o.width = o.width or 0
	o.height = o.height or 0
	o.image = o.image or nil
	o.rotation = o.rotation or 0
	o.scaleX = o.scaleX or 4
	o.scaleY = o.scaleY or 4
	setmetatable(o, self)
	self.__index = self
	return o
end

function Sprite:update() end

function Sprite:moveBy(posX, posY)
	self.posX = self.posX + posX
	self.posY = self.posY + posY
end

function Sprite:draw()
	if self.image then
		love.graphics.draw(self.image, self.posX, self.posY, self.rotation, self.scaleX, self.scaleY)
	end
end

return Sprite
