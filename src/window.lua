local love = require("love")
local assets = require("src.assets.assets")

local Globals = require("globals")
local MenuOption = require("src.utils.menuoption")

local menuFont = love.graphics.newFont(Globals.Game.Font.path, Globals.Game.Font.Menu.size)
local gameFont = love.graphics.newFont(Globals.Game.Font.path, Globals.Game.Font.Game.size)
local gameOverFont = love.graphics.newFont(Globals.Game.Font.path, Globals.Game.Font.GameOver.size)

local Window = {}

function Window:new(game)
	local window = {}
	window.game = game
	window.currentMenuOption = MenuOption.current()
	return setmetatable(window, { __index = Window })
end

function Window:drawBackground()
	for _, background in ipairs(self.game.backgrounds) do
		background:draw()
	end
end

Window.menuList = {
	{
		menuOption = MenuOption.START,
		caption = Globals.Game.Window.Menu.Captions.startGame,
		defaultImage = assets.get("startDefault"),
		pressedImage = assets.get("startPressed"),
	},
	{
		menuOption = MenuOption.SETTINGS,
		caption = Globals.Game.Window.Menu.Captions.settings,
		defaultImage = assets.get("settingsDefault"),
		pressedImage = assets.get("settingsPressed"),
	},
	{
		menuOption = MenuOption.QUIT,
		caption = Globals.Game.Window.Menu.Captions.quitGame,
		defaultImage = assets.get("endDefault"),
		pressedImage = assets.get("endPressed"),
	},
}

function Window:drawMenu()
	love.graphics.setFont(menuFont)

	local iconMargin = Globals.Game.Window.Menu.iconMargin
	local iconCaptionMargin = Globals.Game.Window.Menu.iconCaptionMargin
	local textHeight = gameOverFont:getHeight()
	for i, menuItem in ipairs(self.menuList) do
		local imageObject = menuItem.defaultImage
		if menuItem.menuOption == self.currentMenuOption then
			imageObject = menuItem.pressedImage
		end

		local image = imageObject.image
		local scale = imageObject.scale

		local imageWidth = image:getWidth() * scale
		local imageHeight = image:getHeight() * scale

		local iconPosX = Globals.Game.Window.width / 4
		local iconPosY = Globals.Game.Window.height / 4 + (imageHeight + iconMargin) * i
		local captionPosX = iconPosX + imageWidth + iconCaptionMargin
		local captionPosY = iconPosY + (imageHeight - textHeight) / 2

		love.graphics.draw(image, iconPosX, iconPosY, 0, scale, scale)
		love.graphics.print(menuItem.caption, captionPosX, captionPosY)
	end
end

function Window:drawGame()
	love.graphics.setFont(gameFont)
	love.graphics.print(self.game.points, 10, 10)

	-- Hearts
	for _, heart in ipairs(self.game.hearts) do
		heart:draw()
	end

	-- Ship
	self.game.ship:draw()

	-- Enemy
	for _, enemy in ipairs(self.game.enemies) do
		enemy:draw()
	end

	-- Projectiles
	for _, projectile in ipairs(self.game.shipProjectiles) do
		projectile:draw()
	end
	for _, projectile in ipairs(self.game.enemyProjectiles) do
		projectile:draw()
	end
end

function Window:drawGameOver()
	love.graphics.setFont(gameOverFont)

	local caption = "Game Over"
	local textWidth = gameOverFont:getWidth(caption)
	local textHeight = gameOverFont:getHeight()

	love.graphics.print(
		caption,
		(love.graphics.getWidth() - textWidth) / 2,
		(love.graphics.getHeight() - textHeight) / 2
	)
end

return Window
