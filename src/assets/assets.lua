local love = require("love")

local assets = {}

local assets_conf = {
	-- Menu
	startDefault = { path = "static/ui/start_001.png", scale = 4 },
	startPressed = { path = "static/ui/start_002.png", scale = 4 },
	settingsDefault = { path = "static/ui/settings_001.png", scale = 4 },
	settingsPressed = { path = "static/ui/settings_002.png", scale = 4 },
	endDefault = { path = "static/ui/end_001.png", scale = 4 },
	endPressed = { path = "static/ui/end_002.png", scale = 4 },

	-- Background
	background = { path = "static/background/background_001.png", scale = 4 },

	-- Ship
	shipFront = { path = "static/ships/ship_001.png", scale = 4 },
	shipLeft = { path = "static/ships/ship_002.png", scale = 4 },
	shipRight = { path = "static/ships/ship_003.png", scale = 4 },

	-- Enemy
	enemy1 = { path = "static/enemies/small_enemy_001.png", scale = 4 },
	enemy2 = { path = "static/enemies/small_enemy_002.png", scale = 4 },
	enemy3 = { path = "static/enemies/small_enemy_003.png", scale = 4 },

	-- Laser
	shipBasicLaser = { path = "static/projectiles/ship_laser_001.png", scale = 4 },
	smallEnemyBasicLaser = { path = "static/projectiles/enemy_laser_001.png", scale = 4 },

	-- Boosts
	heart = { path = "static/boosts/heart.png", scale = 4 },
}

local cache = {}

function assets.load(name)
	local conf = assets_conf[name]
	if not cache[name] then
		local img = love.graphics.newImage(conf.path)
		img:setFilter("nearest", "nearest")
		cache[name] = {
			image = img,
			scale = conf.scale,
		}
	end
	return cache[name]
end

function assets.get(name)
	return assets.load(name)
end

return assets
