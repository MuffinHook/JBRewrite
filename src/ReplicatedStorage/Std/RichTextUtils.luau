return {
	addColorToText = function(text, textColor)
		assert(typeof(text) == "string", "text must be a string")
		assert(typeof(textColor) == "Color3", "textColor3 must be a Color3")
		assert(if textColor.R >= 0 then textColor.R <= 1 else false, "textColor3.R must be between 0 and 1")
		assert(if textColor.G >= 0 then textColor.G <= 1 else false, "textColor3.G must be between 0 and 1")
		assert(if textColor.B >= 0 then textColor.B <= 1 else false, "textColor3.B must be between 0 and 1")
		return "<font color=\'#" .. textColor:ToHex() .. "\'>" .. text .. "</font>"
	end,
	addStrokeToText = function(text, strokeColor, strokeThickness)
		assert(typeof(text) == "string", "text must be a string")
		assert(typeof(strokeColor) == "Color3", "strokeColor3 must be a Color3")
		return "<stroke color=\'#" .. strokeColor:ToHex() .. "\' thickness=\'" .. tostring(strokeThickness or 1) .. "\' join=\'meter\'>" .. text .. "</stroke>"
	end,
	doesTextHaveColor = function(text)
		assert(typeof(text) == "string", "text must be a string")
		return string.find(text, "<font color=\'#") ~= nil
	end,
	extractColorFromText = function(text)
		assert(typeof(text) == "string", "text must be a string")
		local colorTagPosition = string.find(text, "<font color=\'#")
		if colorTagPosition then
			local hexStartPosition = colorTagPosition + 14
			return Color3.fromHex((string.sub(text, hexStartPosition, hexStartPosition + 6 - 1)))
		else
			return nil
		end
	end
}
