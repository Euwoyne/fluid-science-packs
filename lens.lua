
local gph = require("graphics")

------------
--  Lens  --
------------
data:extend({
	{
		type       = "item",
		name       = "srdl:fsp-lens",
		subgroup   = "raw-material",
		order      = "d[glassware]-a[lens]",
		stack_size = 100,
		icons      = gph.getIcon("lens"),
		pictures   = gph.getSprite("lens", 0.25)
	},
	{
		type            = "recipe",
		category        = "crafting-with-fluid",
		name            = "srdl:fsp-lens",
		enabled         = true,
		energy_required = 2,
		ingredients     = {{type="fluid", name="srdl:fsp-glass", amount=50}},
		results         = {{"srdl:fsp-lens", 1}}
	}
})

for _,r in pairs({
	{name = "small-lamp",   amount =  1},
	{name = "laser-turret", amount =  5},
	{name = "satellite",    amount = 10},
}) do
	local recipe = data.raw["recipe"][r.name]
	if recipe ~= nil then
		table.insert(recipe.ingredients, {
			type   = "item",
			name   = "srdl:fsp-lens",
			amount = r.amount
		})
	end
end
