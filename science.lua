
local colours = require("colours")

local function getSciencePackInfo()
	
	local function findSciencePacks()
		local next = next
		local science_packs = {}
		for _,lab in pairs(data.raw["lab"]) do
			for _,input in pairs(lab.inputs) do
				science_packs[input] = {recipes = {}, technologies = {}}
			end
		end
		return science_packs
	end
	
	local function findRecipes(science_packs)
		local function getSingleResult(recipe)
			if recipe.result ~= nil then return recipe.result end
			if recipe.results ~= nil and #recipe.results == 1 then
				if recipe.results[1].name ~= nil then return recipe.results[1].name end
				if #recipe.results[1] > 0 then return recipe.results[1][1] end
			end
			return nil
		end
		
		local recipes = {}
		for name,recipe in pairs(data.raw["recipe"]) do
			local result = getSingleResult(recipe)
			if result ~= nil then
				local science_pack = science_packs[result]
				if science_pack ~= nil then
					table.insert(science_pack.recipes, name)
					recipes[name] = result
				end
			end
		end
		return recipes
	end
	
	local function findTechnologies(science_packs, recipes)
		local technologies = {}
		for name,tech in pairs(data.raw["technology"]) do
			if tech.effects ~= nil then
				for _,effect in pairs(tech.effects) do
					if effect.type == "unlock-recipe" and recipes[effect.recipe] ~= nil then
						local science_pack = recipes[effect.recipe]
						if technologies[name] == nil then
							technologies[name] = {}
						end
						table.insert(technologies[name], science_pack)
						table.insert(science_packs[science_pack].technologies, name)
					end
				end
			end
		end
		return technologies
	end

	local function findItems(science_packs)
		for name,science_pack in pairs(science_packs) do
			if data.raw["tool"][name] ~= nil then
				science_pack.type = "tool"
			elseif data.raw["item"][name] ~= nil then
				science_pack.type = "item"
			else
				error("Failed to find prototype for science pack \"" .. name .. "\".")
			end
		end
	end
	
	local science_packs = findSciencePacks()
	local technologies  = findTechnologies(science_packs, findRecipes(science_packs))
	
	findItems(science_packs)
	
	return science_packs, technologies
end

local function transformSciencePacks(science_packs)
	local function transformSciencePack(name, science_pack)
		local function getFluidName()
			local fluidname, n = name:gsub("-pack$", "-fluid")
			if n == 0 then fluidname = name .. "-fluid" end
			return "srdl:fsp-" .. fluidname
		end
		
		local function setupScienceFluid(fluidname)
			
			local function createFluid(packitem)
				local localised_name        = packitem.localised_name or {"item-name." .. packitem.name}
				local localised_description = packitem.localised_description
				return {
					type                  = "fluid",
					name                  = fluidname,
					subgroup              = "srdl:fsp-science-liquid",
					localised_name        = {"fluid-name.srdl:fsp-science-fluid", localised_name},
					localised_description = localised_description,
					order                 = packitem.order .. "-f[fluid]",
					icon                  = packitem.icon,
					icon_size             = packitem.icon_size,
					base_color            = colours.getSciencePackColour(packitem.name),
					flow_color            = colours.getSciencePackColour(packitem.name),
					default_temperature   = 15,
					auto_barrel           = false
				}
			end
			
			local function createFluidRecipe(packrecipe)
				local fluidrecipe = table.deepcopy(packrecipe)
				fluidrecipe.name = fluidname
				
				local count = packrecipe.result_count
				if count ~= nil then
					packrecipe.result_count = nil
				elseif packrecipe.results ~= nil then
					count = packrecipe.results[1].amount
					packrecipe.results[1].amount = nil
				end
				count = count or 1
				
				fluidrecipe.category = "crafting-with-fluid"
				fluidrecipe.results = {{type="fluid", name=fluidname, amount=count * 100}}
				fluidrecipe.result_count = nil
				fluidrecipe.result = nil
				
				packrecipe.category = "crafting-with-fluid"
				packrecipe.ingredients = {
					{type="item",  name="srdl:fsp-flask", amount=  1},
					{type="fluid", name=fluidname,        amount=100}
				}
				packrecipe.energy_required = 0.5
				
				return fluidrecipe
			end
			
			local newdata = {createFluid(data.raw[science_pack.type][name])}
			for _,recipe in pairs(science_pack.recipes) do
				table.insert(newdata, createFluidRecipe(data.raw["recipe"][recipe]))
			end
			data:extend(newdata)
		end
		
		local fluidname = getFluidName(name)
		setupScienceFluid(fluidname)
		return fluidname
	end
	
	data:extend({
		{
			type  = "item-subgroup",
			name  = "srdl:fsp-science-liquid",
			group = "intermediate-products",
			order = data.raw["item-subgroup"]["science-pack"].order .. "-a[science-liquid]"
		}
	})
	
	for name,science_pack in pairs(science_packs) do
		science_pack.fluid = transformSciencePack(name, science_pack)
	end
end

local function updateTechnologies(science_packs, technologies)
	for name,science_pack_names in pairs(technologies) do
		for _, science_pack_name in pairs(science_pack_names) do
			table.insert(data.raw["technology"][name].effects, {
				type   = "unlock-recipe",
				recipe = science_packs[science_pack_name].fluid
			})
		end
	end
end

local science_packs, technologies = getSciencePackInfo()
transformSciencePacks(science_packs)
updateTechnologies(science_packs, technologies)
