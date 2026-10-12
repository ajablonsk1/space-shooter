local MenuOption = {
	START = "start",
	SETTINGS = "settings",
	QUIT = "quit",
}

local values = { MenuOption.START, MenuOption.SETTINGS, MenuOption.QUIT }
local currentIndex = 1

function MenuOption:current()
	return values[currentIndex]
end

function MenuOption:next()
	currentIndex = currentIndex + 1
	if currentIndex > #values then
		currentIndex = 1
	end

	return values[currentIndex]
end

function MenuOption:previous()
	currentIndex = currentIndex - 1
	if currentIndex <= 0 then
		currentIndex = #values
	end

	return values[currentIndex]
end

return MenuOption
