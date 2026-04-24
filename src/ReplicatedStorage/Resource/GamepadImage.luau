-- Reviewed by Claude
local tbl = {}
local tbl2 = {}
for k, v in pairs(script.Spritesheets:GetChildren()) do
	tbl[v.Name] = {}
	for k2, v2 in pairs(v:GetChildren()) do
		tbl[v.Name][v2.Name] = require(v2).new()
	end
end
local function getImageInstance(p1, p2, p3)
	if type(p2) == "userdata" then
		p2 = string.sub(tostring(p2), 14)
	end
	local var3 = tbl.XboxOne[p3]
	if var3 then
		return var3:GetSprite(p1, p2)
	end
	warn("Could not find style: " .. p3)
end
function tbl2.GetImageLabel(p1, p2, p3, p4)
	return getImageInstance("ImageLabel", p2, p3, p4)
end
function tbl2.GetImageButton(p1, p2, p3, p4)
	return getImageInstance("ImageButton", p2, p3, p4)
end
return tbl2
