-- Reviewed by Claude
local v1 = next
local v2, v3 = script:GetChildren()
local t = {}
local t2 = {}
for v4, v5 in v1, v2, v3 do
	t[v5.Name] = require(v5)
end
local t3 = {}
for v6, v7 in script.Parent:FindFirstChild("Category"):GetChildren() do
	t3[v7.Name] = require(v7)
end
function t2.Apply(p1, p2, p3, p4, p5)
	local v1 = t[p2]
	if v1 == nil then
		error("No category function exists on server for: " .. p2)
	end
	return v1(p1, p3, p4, p5)
end
function t2.ApplyAll(p1, p2, p3)
	for v1 in next, t do
		local v2 = p1[v1]
		local v3 = t3[v1]
		if not v3 or v3(p2) then
			t2.Apply(v2, v1, p2, p3)
		end
	end
	return true
end
return t2