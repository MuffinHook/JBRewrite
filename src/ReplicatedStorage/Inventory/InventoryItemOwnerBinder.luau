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
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.Name = p1.Name
	v1._onCharacterChanged = Signal.new()
	local function update()
		if p1.Value then
			v1.maid.observeChar = RxInstanceUtils.observeProperty(p1.Value, "PrimaryPart", function(p12)
				task.wait()
				if p12 then
					v1.Character = p1.Value
				else
					v1.Character = nil
				end
				v1._onCharacterChanged:Fire(v1.Character)
			end)
		end
	end
	if p1.Value then
		v1.maid.observeChar = RxInstanceUtils.observeProperty(p1.Value, "PrimaryPart", function(p12)
			task.wait()
			if p12 then
				v1.Character = p1.Value
			else
				v1.Character = nil
			end
			v1._onCharacterChanged:Fire(v1.Character)
		end)
	end
	v1.maid:GiveTask(p1.Changed:Connect(update))
	return v1
end
function t.GetAttribute(p1, p2)
	return p1["attr" .. tostring(p2)]
end
function t.SetAttribute(p1, p2, p3)
	p1["attr" .. tostring(p2)] = p3
end
return Binder.new("InventoryItemOwner", t)
