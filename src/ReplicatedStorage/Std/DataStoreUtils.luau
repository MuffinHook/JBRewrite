-- Reviewed by Claude
local HttpService = game:GetService("HttpService")
local t = {}
local function v1(p1)
	for v12, v2 in p1 do
		if typeof(v12) == "string" then
			if #v12 >= 1000 then
				warn("Key is too long")
				return false
			elseif not utf8.len(v12) then
				warn("Key is not valid utf8")
				return false
			end
		elseif typeof(v12) == "number" then
			if v12 ~= v12 then
				warn("Key is NaN")
				return false
			end
		else
			warn("Key is not a string or number")
			return false
		end
		if typeof(v2) == "table" then
			if not v1(v2) then
				warn((("SubTable at %* was not safe"):format((tostring(v12)))))
				return false
			end
		elseif typeof(v2) ~= "number" then
			if typeof(v2) == "string" then
				if #v2 >= 4000000 then
					warn("Value is too long")
					return false
				end
				if not utf8.len(v2) then
					warn("Value is not valid utf8")
					return false
				end
			elseif typeof(v2) ~= "boolean" then
				warn("Value is not a table, number, or string")
				return false
			end
		end
	end
	return true
end
function t.isTableSafe(p1, p2)
	if typeof(p1) == "table" then
		local v12 = nil
		local v2, v3 = pcall(function()
			v12 = #HttpService:JSONEncode(p1)
		end)
		if v2 then
			if if p2 and p2.maxTotalLength then p2.maxTotalLength else 4194304 <= v12 then
				return false
			else
				return v1(p1)
			end
		else
			warn("Failed to encode to JSON: " .. tostring(v3))
			return false
		end
	else
		return false
	end
end
function t.isStringSafe(p1)
	if typeof(p1) == "string" then
		if utf8.len(p1) == nil then
			return false
		else
			return not (#p1 > 1000000)
		end
	else
		return false
	end
end
return t
