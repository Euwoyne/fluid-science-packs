
local gph = require("graphics")

-------------
--  Glass  --
-------------
data:extend({
	{
		type                  = "fluid",
		name                  = "srdl:fsp-glass",
		order                 = "a[fluid]-b[glass]",
		icons                 = gph.getIcon("glass"),
		base_color            = {1.0,   0.944, 0.786, 1.0},
		flow_color            = {0.974, 0.855, 0.516, 0.9},
		default_temperature   = 1200,
		heat_capacity         = "0.8KJ",
		auto_barrel           = false
	},
	{
		type                  = "recipe",
		name                  = "srdl:fsp-glass",
		category              = "srdl:fsp-smelting-to-fluid",
		enabled               = true,
--		hidden                = true,
		energy_required       = 2,
		ingredients           = {{"srdl:fsp-sand", 1}},
		results               = {{type="fluid", name="srdl:fsp-glass", amount=100}}
	}
})
