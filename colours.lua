
return {
	getSciencePackColour = function(name)
		local defaultColour             = {0.0, 0.7, 0.7, 1.0}
		local sciencePackColours = {
			["automation-science-pack"] = {1.0, 0.1, 0.1, 1.0},
			["logistic-science-pack"]   = {0.1, 1.0, 0.1, 1.0},
			["chemical-science-pack"]   = {0.2, 0.2, 1.0, 1.0},
			["production-science-pack"] = {0.8, 0.1, 0.8, 1.0},
			["military-science-pack"]   = {1.0, 0.5, 0.0, 1.0},
			["utility-science-pack"]    = {1.0, 0.9, 0.1, 1.0},
			["space-science-pack"]      = {0.8, 0.8, 0.8, 1.0}
		}
		
		return sciencePackColours[name] or defaultColour
	end
}
