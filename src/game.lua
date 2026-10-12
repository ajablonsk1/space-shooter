local love = require("love")

local Window = require("src.window")
local Globals = require("globals")
local Timer = require("lib.timer")
local State = require("src.utils.state")
local SpriteFactory = require("src.sprites.factory")
local KeyInput = require("src.keyinput")
local EntityManager = require("src.entitymanager")

local Game = {
	windowWidth = love.graphics.getWidth(),
	windowHeight = love.graphics.getHeight(),

	-- Game state
	points = 0,
	state = State.MENU,

	-- Sprites
	ship = {},
	backgrounds = {},
	enemies = {},
	shipProjectiles = {},
	enemyProjectiles = {},
	bonuses = {},
	hearts = {},
}

function Game:init()
	local background1, background2 = SpriteFactory:createBackground()
	table.insert(self.backgrounds, background1)
	table.insert(self.backgrounds, background2)

	Globals.Game.Window.width = love.graphics.getWidth()
	Globals.Game.Window.height = love.graphics.getHeight()
	love.graphics.setColor(1, 1, 1)

	self.entityManager = EntityManager:new(self)
	self.window = Window:new(self)
	self.keyInput = KeyInput:new(self, self.window)

	self:initKeyListeners()
end

function Game:initKeyListeners()
	function love.keypressed(key)
		if self.state == State.MENU then
			self.keyInput:handleMenuInput(key)
		elseif self.state == State.GAME then
			self.keyInput:handleGameInput(key)
		elseif self.state == State.GAMEOVER then
			self.keyInput:handleGameOverInput(key)
		end
	end
end

function Game:clear()
	self.enemies = {}
	self.shipProjectiles = {}
	self.enemyProjectiles = {}
	self.bonuses = {}
end

function Game:startNew()
	self:clear()

	self.ship = SpriteFactory:createShip()
	Timer.every(math.random(5), function()
		local enemy = SpriteFactory:createEnemy()
		table.insert(self.enemies, enemy)
	end)
	self.hearts = SpriteFactory:createHearts(self.ship.health)
end

function Game:update(dt)
	Timer.update(dt)

	self.entityManager:updateBackground(dt)

	if self.state == State.GAME then
		self.entityManager:updateShip(dt)
		self.entityManager:updateEnemies(dt)
	end
end

function Game:draw()
	self.window:drawBackground()

	if self.state == State.MENU then
		self.window:drawMenu()
	elseif self.state == State.GAME then
		self.window:drawGame()
	elseif self.state == State.GAMEOVER then
		self.window:drawGameOver()
	end
end

return Game
