local RunService = game:GetService("RunService")
local t = {}
local t2 = {}
for v1, v2 in script:GetChildren() do
	t[v2.Name] = false
end
local function GetCategoryByName(p1) --[[ Line: 8 | Upvalues: t (copy), t2 (copy) ]]
	assert(p1)
	if not t[p1] then
		local v1 = script:FindFirstChild(p1)
		if not v1 then
			print(("No category module: %s"):format(p1))
			error("No category module")
		end
		t2[p1] = require(v1)
		t[p1] = true
	end
	return t2[p1]
end
local function GetItemByName(p1, p2) --[[ Line: 21 | Upvalues: GetCategoryByName (copy), RunService (copy) ]]
	assert(p1)
	assert(p2)
	local v1 = GetCategoryByName(p1)
	if v1 then
		assert(v1, p1)
		if v1.GetItemByName then
			return v1.GetItemByName(p2)
		end
		for v3, v4 in if v1.GetItems then v1.GetItems() else v1.Items do
			if v4.Name == p2 then
				return v4
			end
		end
	end
	local v5 = ("No CategoryName/ItemName: %s/%s"):format(p1, p2)
	if RunService:IsServer() then
		warn(v5)
	end
	return nil
end
return {
	GetCategoryByName = GetCategoryByName,
	GetItemByName = GetItemByName,
	GetMapFromSelection = function(p1) --[[ Name: GetMapFromSelection | Line: 50 | Upvalues: GetItemByName (copy) ]]
		assert(p1)
		local t = {}
		for k, v in pairs(p1) do
			t[k] = GetItemByName(k, v)
		end
		return t
	end
}