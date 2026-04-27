local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local RegionUtils = require(script.RegionUtils)
local Region = {}
Region.__index = Region
function Region.new(condition)
	assert(condition)
	local instance = setmetatable({}, Region)
	instance.Prisms = {}
	instance.ListObj = {}
	instance.MapObj = {}
	instance.Condition = condition
	instance.OnObjAdded = Signal.new()
	instance.OnObjRemoved = Signal.new()
	return instance
end
function Region.AddPrism(self, prism)
	assert(prism)
	table.insert(self.Prisms, prism)
	return function()
		return table.remove(self.Prisms, (table.find(self.Prisms, prism)))
	end
end
function Region.AddPart(self, part)
	return self:AddPrism(RegionUtils.getPrism(part.CFrame, part.Size))
end
function Region.CastPoint(self, point)
	local Prisms = self.Prisms
	for i = 1, #Prisms do
		if RegionUtils.CastPoint(Prisms[i], point) then
			return true
		end
	end
	return false
end
function Region.GetObjCount(self)
	return #self.ListObj
end
function Region.HasObj(self, object)
	return self.MapObj[object] == true
end
function Region.GetObjList(self)
	return self.ListObj
end
function Region.Update(self, objectsList)
	local ListObj = self.ListObj
	local MapObj = self.MapObj
	local Condition = self.Condition
	local newObjectsMap = {}
	for i = 1, #objectsList do
		local object = objectsList[i]
		newObjectsMap[object] = true
		local conditionMet = Condition(self, object)
		if conditionMet and MapObj[object] == nil then
			MapObj[object] = true
			table.insert(ListObj, object)
			self.OnObjAdded:Fire(object)
		elseif not conditionMet and MapObj[object] ~= nil then
			MapObj[object] = nil
			for j = #ListObj, 1, -1 do
				if ListObj[j] == object then
					table.remove(ListObj, j)
				end
			end
			self.OnObjRemoved:Fire(object)
		end
	end
	for k = #ListObj, 1, -1 do
		local object = ListObj[k]
		if newObjectsMap[object] == nil then
			table.remove(ListObj, k)
			MapObj[object] = nil
			self.OnObjRemoved:Fire(object)
		end
	end
end
function Region.Destroy(self)
	local ListObj = self.ListObj
	for i = 1, #ListObj do
		self.OnObjRemoved:Fire(ListObj[i])
	end
	self.ListObj = nil
	self.MapObj = nil
	self.OnObjAdded:Destroy()
	self.OnObjAdded = nil
	self.OnObjRemoved:Destroy()
	self.OnObjRemoved = nil
end
return Region
