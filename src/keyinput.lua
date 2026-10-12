local love = require("love")

local MenuOption = require("src.utils.menuoption")
local State = require("src.utils.state")

local KeyInput = {}

function KeyInput:new(game, window)
	local keyInput = {}
	keyInput.game = game
	keyInput.window = window
	return setmetatable(keyInput, { __index = KeyInput })
end

function KeyInput:handleMenuInput(key)
	if key == "up" then
		self.window.currentMenuOption = MenuOption:previous()
	end

	if key == "down" then
		self.window.currentMenuOption = MenuOption:next()
	end

	if key == "return" or key == "enter" or key == "space" then
		if self.window.currentMenuOption == MenuOption.START then
			self.game.state = State.GAME
			self.game:startNew()
		elseif self.window.currentMenuOption == MenuOption.QUIT then
			love.event.quit()
		end
	end
end

function KeyInput:handleGameInput(key) end

function KeyInput:handleGameOverInput(key)
	if key == "space" then
		self.game.state = State.MENU
	end
end

return KeyInput
