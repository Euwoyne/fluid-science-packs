-- prepend filename with path to the mod's sprite folder
local function spritePath(filename)
	return "__fluid-science-packs__/graphics/" .. filename .. ".png"
end

return {
	-- prepend filename with path to the mod's sprite folder
	spritePath = function(filename)
		return spritePath(filename)
	end,
	
	-- construct array of IconData
	getIcon = function(filename)
		return {{
			icon         = spritePath(filename),
			icon_size    = 64,
			icon_mipmaps = 4
		}}
	end,

	-- construct SpriteParameters
	getSprite = function(filename, scale)
		return {
			size         = 64,
			filename     = spritePath(filename),
			scale        = scale,
			mipmap_count = 4
		}
	end,

	-- construct array of SpriteParameters
	getSprites = function(basename, count, scale)
		local sprites = {}
		for i=1,count do
			sprites[i] = {
				size         = 64,
				filename     = spritePath(basename .. "-" .. i),
				scale        = scale,
				mipmap_count = 4
			}
		end
		return sprites
	end
}
