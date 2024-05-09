
local gph = require("graphics")

------------------------
--  Smelting Furnace  --
------------------------
local function smeltingFurnaceEntity()
	local pipes = {
		north = {
			filename = gph.spritePath("stone-furnace-pipe-N"),
			priority = "extra-high",
			width    = 54,
			height   = 31,
			shift    = util.by_pixel(0, 15.5),
			scale    = 0.5
		},
		east = {
			filename = gph.spritePath("stone-furnace-pipe-E"),
			priority = "extra-high",
			width    = 17,
			height   = 51,
			shift    = util.by_pixel(-17, 0),
			scale    = 0.5
		},
		south = {
			filename = gph.spritePath("stone-furnace-pipe-S"),
			priority = "extra-high",
			width    = 52,
			height   = 41,
			shift    = util.by_pixel(0, -20.5),
			scale    = 0.5
		},
		west = {
			filename = gph.spritePath("stone-furnace-pipe-W"),
			priority = "extra-high",
			width    = 20,
			height   = 60,
			shift    = util.by_pixel(20, 0),
			scale    = 0.5
		}
	}
	
	local entity = table.deepcopy(data.raw["furnace"]["stone-furnace"])
	entity.type                  = "assembling-machine"
	entity.name                  = "srdl:fsp-smelting-furnace"
	entity.minable.result        = "srdl:fsp-smelting-furnace"
	entity.crafting_categories   = {"smelting", "srdl:fsp-smelting-to-fluid"}
	entity.selection_box         = {{-1,-1}, {1,1}}
	entity.result_inventory_size = 0
	entity.fluid_boxes = {
		{
			production_type       = "output",
			pipe_picture          = pipes,
			pipe_covers           = pipecoverspictures(),
			base_area             = 10,
			base_level            = 1,
			pipe_connections      = {{type = "output", position = {1.5, 0.5}}},
			secondary_draw_orders = {north = -1}
		}
	}
	return entity
end

data:extend({
	{
		type = "recipe-category",
		name = "srdl:fsp-smelting-to-fluid"
	}
})

data:extend({
	{
		type         = "item",
		name         = "srdl:fsp-smelting-furnace",
		subgroup     = "smelting-machine",
		order        = "a[smelting-furnace]",
		stack_size   = 50,
		place_result = "srdl:fsp-smelting-furnace",
		icon         = "__base__/graphics/icons/stone-furnace.png",
		icon_size    = 64,
		icon_mipmaps = 4
	},
	smeltingFurnaceEntity(),
	{
		type        = "recipe",
		name        = "srdl:fsp-smelting-furnace",
		ingredients = {{"stone", 5}},
		result      = "srdl:fsp-smelting-furnace"
	}
})
