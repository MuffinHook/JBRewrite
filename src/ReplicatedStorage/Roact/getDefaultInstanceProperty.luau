-- Reviewed by Claude
local v1 = require(script.Parent.Symbol).named("Nil")
local t = {}
return function(p1, p2)
	local v12 = t[p1]
	local v2, v3, v4
	if v12 then
 local v5 = v12[p2]
 if v5 == v1 then
 return true, nil
 elseif v5 == nil then
 v2 = Instance.new(p1)
 v3, v4 = pcall(function()
 return v2[p2]
 end)
 v2:Destroy()
 if v3 then
 if v4 == nil then
 v12[p2] = v1
 return v3, v4
 end
 v12[p2] = v4
 end
 return v3, v4
 else
 return true, v5
 end
	end
	v12 = {}
	t[p1] = v12
	v2 = Instance.new(p1)
	v3, v4 = pcall(function()
 return v2[p2]
	end)
	v2:Destroy()
	if v3 then
 if v4 == nil then
 v12[p2] = v1
 return v3, v4
 end
 v12[p2] = v4
	end
	return v3, v4
end