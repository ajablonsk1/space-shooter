local love = require("love")

local Collision = { windowWidth = love.graphics.getWidth(), windowHeight = love.graphics.getHeight() }
Collision.__index = Collision

function Collision:between(sprite1, sprite2)
	local left1 = sprite1.posX
	local right1 = sprite1.posX + sprite1.width
	local top1 = sprite1.posY
	local bottom1 = sprite1.posY + sprite1.height

	local left2 = sprite2.posX
	local right2 = sprite2.posX + sprite2.width
	local top2 = sprite2.posY
	local bottom2 = sprite2.posY + sprite2.height

	return left1 < right2 and right1 > left2 and top1 < bottom2 and bottom1 > top2
end

function Collision:withTopBorder(sprite)
	return sprite.posY < 0
end

function Collision:withBottomBorder(sprite)
	return sprite.posY + sprite.height > self.windowHeight
end

function Collision:withLeftBorder(sprite)
	return sprite.posX < 0
end

function Collision:withRightBorder(sprite)
	return sprite.posX + sprite.width > self.windowWidth
end

function Collision:withLeftBorderOffset(sprite, offset)
	return sprite.posX + offset < 0
end

function Collision:withRightBorderOffset(sprite, offset)
	return sprite.posX + sprite.height - offset > self.windowWidth
end

return Collision
