
local gph = require("graphics")

-------------
--  Flask  --
-------------
data:extend({
	{
		type       = "item",
		name       = "srdl:fsp-flask",
		subgroup   = "raw-material",
		order      = "d[glassware]-a[flask]",
		stack_size = 50,
		icons      = gph.getIcon("flask"),
		pictures   = gph.getSprite("flask", 0.25)
	},
	{
		type            = "recipe",
		category        = "crafting-with-fluid",
		name            = "srdl:fsp-flask",
		enabled         = true,
		energy_required = 2,
		ingredients     = {{type="fluid", name="srdl:fsp-glass", amount=100}},
		results         = {{"srdl:fsp-flask", 1}}
	}
})
