
local resource_autoplace = require("resource-autoplace")
local gph = require("graphics")

------------
--  Sand  --
------------
function sandResource()
	local resource = table.deepcopy(data.raw["resource"]["stone"])
	resource.name                      = "srdl:fsp-sand"
	resource.order                     = "b-srdl:fsp-sand"
	resource.icons                     = gph.getIcon("sand")
	resource.icon                      = resource.icons[1].icon
	resource.icon_size                 = resource.icons[1].icon_size
	resource.icon_mipmaps              = resource.icons[1].icon_mipmaps
	resource.map_color                 = {0.886, 0.839, 0.725}
	resource.mining_visualisation_tint = {0.671, 0.565, 0.357}
	resource.stages                    = gph.getSprites("sand.tile", 4, 0.5)
	resource.stage_counts              = {1}
	resource.minable.result            = "srdl:fsp-sand"
	resource.autoplace = resource_autoplace.resource_autoplace_settings {
		name                          = resource.name,
		order                         = resource.order,
		base_density                  = 4,
		regular_rq_factor_multiplier  = 1.0,
		starting_rq_factor_multiplier = 1.1,
		has_starting_area_placement   = true
	}
	return resource
end

data:extend({
	{
		type       = "item",
		name       = "srdl:fsp-sand",
		subgroup   = "raw-resource",
		order      = "a[sand]",
		stack_size = 100,
		icons      = gph.getIcon("sand"),
		pictures   = gph.getSprite("sand", 0.25)
--		pictures   = gph.getSprites("sand", 4, 0.25)
	},
	{
		type           = "autoplace-control",
		category       = "resource",
		name           = "srdl:fsp-sand",
		localised_name = {"", "[entity=srdl:fsp-sand] ", {"tile-name.srdl:fsp-sand"}},
		order          = "b-srdl:fsp-sand",
		richness       = true
	},
	{
		type = "noise-layer",
		name = "srdl:fsp-sand"
	},
	sandResource()
})
