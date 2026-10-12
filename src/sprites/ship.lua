local love = require("love")
local Sprite = require("src.sprites.Sprite")
local Direction = require("src.utils.direction")
local Collision = require("src.logic.collision")

local Ship = {}
Ship.__index = Ship
setmetatable(Ship, { __index = Sprite })

function Ship:new(o)
	local ship = Sprite:new(o)
	ship.imageRight = o.imageRight or {}
	ship.imageLeft = o.imageLeft or {}
	ship.direction = Direction.NORTH
	ship.health = o.health
	ship.laserCoolddownDurationSec = o.laserCoolddownDurationSec
	ship.laserCooldownSec = 0
	setmetatable(ship, self)
	return ship
end

function Ship:update(dt)
	self.direction = Direction.NORTH

	if love.keyboard.isDown("left") then
		self:moveBy(-self.speed * dt, 0)
		self.direction = Direction.WEST
	end

	if love.keyboard.isDown("right") then
		self:moveBy(self.speed * dt, 0)
		self.direction = Direction.EAST
	end

	if love.keyboard.isDown("up") then
		self:moveBy(0, -self.speed * dt)
	end

	if love.keyboard.isDown("down") then
		self:moveBy(0, self.speed * dt)
	end

	if self.laserCooldownSec > 0 then
		self.laserCooldownSec = self.laserCooldownSec - dt
	end
end

function Ship:moveBy(posX, posY)
	local prevPosX = self.posX
	local prevPosY = self.posY
	self.posX = self.posX + posX
	self.posY = self.posY + posY

	if
		Collision:withLeftBorderOffset(self, self.width / 2) or Collision:withRightBorderOffset(self, self.width / 2)
	then
		self.posX = prevPosX
	end

	if Collision:withTopBorder(self) or Collision:withBottomBorder(self) then
		self.posY = prevPosY
	end
end

function Ship:draw()
	if self.image and self.direction == Direction.NORTH then
		love.graphics.draw(self.image, self.posX, self.posY, self.rotation, self.scaleX, self.scaleY)
	elseif self.imageLeft and self.direction == Direction.WEST then
		love.graphics.draw(self.imageLeft, self.posX, self.posY, self.rotation, self.scaleX, self.scaleY)
	elseif self.imageRight and self.direction == Direction.EAST then
		love.graphics.draw(self.imageRight, self.posX, self.posY, self.rotation, self.scaleX, self.scaleY)
	end
end

return Ship
