local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local Interval = require(ReplicatedStorage.Std.Interval)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
require(ReplicatedStorage.Door2.DoorBinder)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2) --[[ Line: 17 | Upvalues: BaseObject (copy), t (copy), Interval (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.manifest = p2
	v1.maid:GiveTask(Interval.every(0.5):Connect(function() --[[ Line: 23 | Upvalues: v1 (copy) ]]
		if v1:_isLocalColliding() then
			if not v1.maid.running then
				v1:_hook()
			end
		elseif v1.maid.running then
			v1.maid.running = nil
		end
	end))
	return v1
end
function t._isLocalColliding(p1) --[[ Line: 36 | Upvalues: CharacterUtils (copy), Players (copy) ]]
	local v1 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
	local v2 = RaycastParams.new()
	v2.FilterType = Enum.RaycastFilterType.Whitelist
	v2.FilterDescendantsInstances = { p1.manifest.floor }
	if v1 then
		return workspace:Raycast(v1.Position, Vector3.new(0, -20, 0), v2) ~= nil
	else
		return false
	end
end
function t._hook(p1) --[[ Line: 47 | Upvalues: RunService (copy), CharacterUtils (copy), Players (copy) ]]
	local floor = p1.manifest.floor
	local v1 = floor.CFrame
	p1.maid.running = RunService.Heartbeat:Connect(function() --[[ Line: 50 | Upvalues: CharacterUtils (ref), Players (ref), floor (copy), v1 (ref) ]]
		local v12 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
		local v2 = floor.CFrame
		v12.CFrame = v2 * v1:Inverse() * v12.CFrame
		v1 = v2
	end)
end
return ManifestBinder.new("Elevator", {
	floor = "Car/InnerModel/Floor"
}, t)