-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local RegionUtils = require(script.RegionUtils)
local t = {}
t.__index = t
function t.new(p1)
	assert(p1)
	local v2 = setmetatable({}, t)
	v2.Prisms = {}
	v2.ListObj = {}
	v2.MapObj = {}
	v2.Condition = p1
	v2.OnObjAdded = Signal.new()
	v2.OnObjRemoved = Signal.new()
	return v2
end
function t.AddPrism(p1, p2)
	assert(p2)
	table.insert(p1.Prisms, p2)
	return function()
		return table.remove(p1.Prisms, (table.find(p1.Prisms, p2)))
	end
end
function t.AddPart(p1, p2)
	return p1:AddPrism(RegionUtils.getPrism(p2.CFrame, p2.Size))
end
function t.CastPoint(p1, p2)
	local Prisms = p1.Prisms
	for i = 1, #Prisms do
		if RegionUtils.CastPoint(Prisms[i], p2) then
			return true
		end
	end
	return false
end
function t.GetObjCount(p1)
	return #p1.ListObj
end
function t.HasObj(p1, p2)
	return p1.MapObj[p2] == true
end
function t.GetObjList(p1)
	return p1.ListObj
end
function t.Update(p1, p2)
	local ListObj = p1.ListObj
	local MapObj = p1.MapObj
	local Condition = p1.Condition
	local t = {}
	for i = 1, #p2 do
		local v1 = p2[i]
		t[v1] = true
		local v2 = Condition(p1, v1)
		if v2 and MapObj[v1] == nil then
			MapObj[v1] = true
			table.insert(ListObj, v1)
			p1.OnObjAdded:Fire(v1)
		elseif not v2 and MapObj[v1] ~= nil then
			MapObj[v1] = nil
			for j = #ListObj, 1, -1 do
				if ListObj[j] == v1 then
					table.remove(ListObj, j)
				end
			end
			p1.OnObjRemoved:Fire(v1)
		end
	end
	for k = #ListObj, 1, -1 do
		local v3 = ListObj[k]
		if t[v3] == nil then
			table.remove(ListObj, k)
			MapObj[v3] = nil
			p1.OnObjRemoved:Fire(v3)
		end
	end
end
function t.Destroy(p1)
	local ListObj = p1.ListObj
	for i = 1, #ListObj do
		p1.OnObjRemoved:Fire(ListObj[i])
	end
	p1.ListObj = nil
	p1.MapObj = nil
	p1.OnObjAdded:Destroy()
	p1.OnObjAdded = nil
	p1.OnObjRemoved:Destroy()
	p1.OnObjRemoved = nil
end
return t
