local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Localization = require(ReplicatedStorage.Module.Localization)
local t = {
	Comma = function(p1) --[[ Name: Comma | Line: 6 ]]
		local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
		return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
	end
}
function t.Currency(p1) --[[ Line: 10 | Upvalues: Localization (copy), t (copy) ]]
	assert(p1 ~= nil)
	local v2 = math.floor(p1 + 0.5)
	return if v2 >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", { t.Comma((math.abs(v2))) })
end
function t.MinSec(p1) --[[ Line: 20 ]]
	local v1 = ""
	local v2 = math.floor(p1 / 60)
	local v3 = p1 % 60
	if v2 > 0 then
		v1 = v1 .. ("%d minute"):format(v2)
		if v2 ~= 1 then
			v1 = v1 .. "s"
		end
	end
	if v2 > 0 and v3 > 0 then
		v1 = v1 .. " and "
	end
	if v3 > 0 then
		v1 = v1 .. ("%d second"):format(v3)
		if v3 ~= 1 then
			v1 = v1 .. "s"
		end
	end
	return v1
end
return t