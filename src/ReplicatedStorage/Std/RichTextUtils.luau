-- Reviewed by Claude
-- variables reassigned
return {
	addColorToText = function(p1, p2)
		assert(typeof(p1) == "string", "text must be a string")
		assert(typeof(p2) == "Color3", "textColor3 must be a Color3")
		assert(if p2.R >= 0 then p2.R <= 1 else false, "textColor3.R must be between 0 and 1")
		assert(if p2.G >= 0 then p2.G <= 1 else false, "textColor3.G must be between 0 and 1")
		assert(if p2.B >= 0 then p2.B <= 1 else false, "textColor3.B must be between 0 and 1")
		return "<font color=\'#" .. p2:ToHex() .. "\'>" .. p1 .. "</font>"
	end,
	addStrokeToText = function(p1, p2, p3)
		assert(typeof(p1) == "string", "text must be a string")
		assert(typeof(p2) == "Color3", "strokeColor3 must be a Color3")
		return "<stroke color=\'#" .. p2:ToHex() .. "\' thickness=\'" .. tostring(p3 or 1) .. "\' join=\'meter\'>" .. p1 .. "</stroke>"
	end,
	doesTextHaveColor = function(p1)
		assert(typeof(p1) == "string", "text must be a string")
		return string.find(p1, "<font color=\'#") ~= nil
	end,
	extractColorFromText = function(p1)
		assert(typeof(p1) == "string", "text must be a string")
		local v2 = string.find(p1, "<font color=\'#")
		if v2 then
			local v3 = v2 + 14
			return Color3.fromHex((string.sub(p1, v3, v3 + 6 - 1)))
		else
			return nil
		end
	end
}
