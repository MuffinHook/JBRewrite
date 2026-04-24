-- Reviewed by Claude
local t = {}
local t2 = {}
for k, v in pairs(script.Spritesheets:GetChildren()) do
	t[v.Name] = {}
	for k2, v2 in pairs(v:GetChildren()) do
		t[v.Name][v2.Name] = require(v2).new()
	end
end
local function getImageInstance(p1, p2, p3)
	if type(p2) == "userdata" then
		p2 = string.sub(tostring(p2), 14)
	end
	local v3 = t.XboxOne[p3]
	if v3 then
		return v3:GetSprite(p1, p2)
	end
	warn("Could not find style: " .. p3)
end
function t2.GetImageLabel(p1, p2, p3, p4)
	return getImageInstance("ImageLabel", p2, p3, p4)
end
function t2.GetImageButton(p1, p2, p3, p4)
	return getImageInstance("ImageButton", p2, p3, p4)
end
return t2
