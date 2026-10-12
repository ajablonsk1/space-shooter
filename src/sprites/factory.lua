local love = require("love")
local assets = require("src.assets.assets")

local Globals = require("globals")
local Sprite = require("src.sprites.sprite")
local Background = require("src.sprites.background")
local Ship = require("src.sprites.ship")
local Enemy = require("src.sprites.enemy")
local Projectile = require("src.sprites.projectile")

local SpriteFactory = {}

function SpriteFactory:createSpriteSkeleton(assetName, extraParams)
	local asset = assets.get(assetName)
	local image = asset.image
	local scale = asset.scale
	local width = image:getWidth() * scale
	local height = image:getHeight() * scale
	local speed = extraParams.speed or Globals.Sprites.Defaults.speed

	local skeleton = {
		width = width,
		height = height,
		image = image,
		speed = speed,
	}

	for k, v in pairs(extraParams) do
		skeleton[k] = v
	end

	return skeleton
end

function SpriteFactory:createBackground()
	local background1 = Background:new(self:createSpriteSkeleton("background", {
		posX = 0,
		posY = 0,
		speed = Globals.Sprites.Background.speed,
	}))

	local background2 = Background:new(self:createSpriteSkeleton("background", {
		posX = 0,
		posY = -background1.height,
		speed = Globals.Sprites.Background.speed,
	}))

	return background1, background2
end

function SpriteFactory:createShip()
	local skeleton = self:createSpriteSkeleton("shipFront", {
		posY = Globals.Sprites.Ship.initYPosition,
		speed = Globals.Sprites.Ship.speed,
		imageLeft = assets.get("shipLeft").image,
		imageRight = assets.get("shipRight").image,
		health = Globals.Sprites.Ship.health,
		laserCooldownDurationSec = Globals.Sprites.Ship.Projectiles.laserCooldownDurationSec,
	})
	skeleton.posX = (love.graphics.getWidth() - skeleton.width) / 2

	return Ship:new(skeleton)
end

function SpriteFactory:createEnemy()
	local enemyAssets = { "enemy1", "enemy2", "enemy3" }
	local randomEnemyAsset = enemyAssets[math.random(#enemyAssets)]

	local skeleton = self:createSpriteSkeleton(randomEnemyAsset, {
		posX = math.random(0, love.graphics.getWidth()),
		speed = Globals.Sprites.Enemy.speed,
		points = Globals.Sprites.Enemy.points,
	})
	skeleton.posY = -skeleton.height
	return Enemy:new(skeleton)
end

function SpriteFactory:createShipLaser(ship)
	local skeleton = self:createSpriteSkeleton("shipBasicLaser", {
		posX = ship.posX + ship.width / 2,
		posY = ship.posY,
		speed = Globals.Sprites.Ship.Projectiles.speed,
	})
	ship.laserCooldownSec = ship.laserCooldownDurationSec
	return Projectile:new(skeleton)
end

function SpriteFactory:createHearts(num)
	local hearts = {}
	local heartPadding = Globals.Sprites.Heart.padding
	for i = 1, num do
		local skeleton = self:createSpriteSkeleton("heart", {})
		skeleton.posX = love.graphics.getWidth() - (skeleton.width + heartPadding) * i
		skeleton.posY = heartPadding
		table.insert(hearts, Sprite:new(skeleton))
	end
	return hearts
end

return SpriteFactory
