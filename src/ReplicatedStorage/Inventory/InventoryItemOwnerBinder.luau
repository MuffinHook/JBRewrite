-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local Signal = require(ReplicatedStorage.Std.Signal)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
require(ReplicatedStorage.Std.Maid)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	local instance = BaseObject.new(p1)
	setmetatable(instance, t)
	instance.Name = p1.Name
	instance._onCharacterChanged = Signal.new()
	local function update()
		if p1.Value then
			instance.maid.observeChar = RxInstanceUtils.observeProperty(p1.Value, "PrimaryPart", function(p12)
				task.wait()
				if p12 then
					instance.Character = p1.Value
				else
					instance.Character = nil
				end
				instance._onCharacterChanged:Fire(instance.Character)
			end)
		end
	end
	if p1.Value then
		instance.maid.observeChar = RxInstanceUtils.observeProperty(p1.Value, "PrimaryPart", function(p12)
			task.wait()
			if p12 then
				instance.Character = p1.Value
			else
				instance.Character = nil
			end
			instance._onCharacterChanged:Fire(instance.Character)
		end)
	end
	instance.maid:GiveTask(p1.Changed:Connect(update))
	return instance
end
function t.GetAttribute(p1, p2)
	return p1["attr" .. tostring(p2)]
end
function t.SetAttribute(p1, p2, p3)
	p1["attr" .. tostring(p2)] = p3
end
return Binder.new("InventoryItemOwner", t)
