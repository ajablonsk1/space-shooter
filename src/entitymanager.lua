local love = require("love")

local SpriteFactory = require("src.sprites.factory")
local Collision = require("src.logic.collision")
local State = require("src.utils.state")

local EntityManager = {}

function EntityManager:new(game)
	local entityManager = {}
	entityManager.game = game
	return setmetatable(entityManager, { __index = EntityManager })
end

function EntityManager:updateBackground(dt)
	for _, background in ipairs(self.game.backgrounds) do
		background:update(dt)
	end
end

function EntityManager:updateShip(dt)
	local ship = self.game.ship
	local shipProjectiles = self.game.shipProjectiles

	ship:update(dt)
	if love.keyboard.isDown("space") and ship.laserCooldownSec <= 0 then
		local laser = SpriteFactory:createShipLaser(ship)
		table.insert(shipProjectiles, laser)
	end

	for _, projectile in ipairs(shipProjectiles) do
		projectile:update(dt)
	end
end

function EntityManager:updateEnemies(dt)
	local enemies = self.game.enemies
	local ship = self.game.ship
	local hearts = self.game.hearts
	local shipProjectiles = self.game.shipProjectiles
	local enemyProjectiles = self.game.enemyProjectiles

	for i = #enemies, 1, -1 do
		local enemy = enemies[i]
		enemy:update(dt)

		if Collision:between(ship, enemy) or Collision:withBottomBorder(enemy) then
			table.remove(enemies, i)
			table.remove(hearts)
			if #hearts == 0 then
				self.game.state = State.GAMEOVER
			end
		else
			for j = #shipProjectiles, 1, -1 do
				local projectile = shipProjectiles[j]
				if Collision:between(projectile, enemy) then
					table.remove(enemies, i)
					table.remove(shipProjectiles, j)
					self.game.points = self.game.points + enemy.points
					break
				end
			end
		end
	end

	for _, projectile in ipairs(enemyProjectiles) do
		projectile:update(dt)
	end
end

return EntityManager
