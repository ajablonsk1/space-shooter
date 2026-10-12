local Globals = {}

local Game = {
	title = "Space Shooter",
	width = 512,
	height = 1024,

	Window = {
		-- these two values will be filled after love initializes grpahics
		width = nil,
		height = nil,

		Menu = {
			iconMargin = 20,
			iconCaptionMargin = 10,
			Captions = {
				startGame = "New Game",
				settings = "Settings",
				quitGame = "Quit",
			},
		},
	},

	Font = {
		path = "static/font/arcadeclassic.ttf",

		Menu = {
			size = 40,
		},

		Game = {
			size = 24,
		},

		GameOver = {
			size = 40,
		},
	},
}

-- Sprite Configuration
local Sprites = {
	Background = {
		speed = 100,
	},

	Ship = {
		speed = 300,
		initYPosition = Game.height - 100,
		health = 3,

		Projectiles = {
			speed = 300,
			laserCooldownDurationSec = 0.5,
		},
	},

	Enemy = {
		speed = 200,
		initYPosition = 100,
		points = 10,

		Projectiles = {
			speed = 300,
		},
	},

	Heart = {
		padding = 8,
	},

	Defaults = {
		speed = 200,
	},
}

Globals.Game = Game
Globals.Sprites = Sprites

return Globals
