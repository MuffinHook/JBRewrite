-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Region = require(ReplicatedStorage.Std.Region)
local Promise = require(ReplicatedStorage.Std.Promise)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local DoorBinder = require(ReplicatedStorage.Door2.DoorBinder)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local Interval = require(ReplicatedStorage.Std.Interval)
return {
	setup = function(p1, p2, p3)
		local v2 = p2.spikesName or "Spikes"
		local v3 = p2.referenceName or "Shelving"
		local offsetCf = p2.offsetCf
		local spikeSizeMin = p2.spikeSizeMin
		local spikeSizeMax = p2.spikeSizeMax
		local damageAmount = p2.damageAmount
		local audioId = p2.audioId
		local v5 = p2.doorCloseDelay or 1
		local v6 = nil
		local v7 = p1._obj:WaitForChild(p2.doorName or "FakeDoor")
		v6 = BinderUtils.promiseBoundClass(DoorBinder, v7):tap(function(p12)
			local v1 = p1._obj:FindFirstChild(v2)
			local v22 = p1._obj:FindFirstChild(v3)
			p12:SetUpdateCallback(function(p1, p2)
				local v12 = spikeSizeMin * (1 - p2) + spikeSizeMax * p2
				v1.Size = Vector3.new(v1.Size.X, v1.Size.Y, v12)
				v1.CFrame = v22.CFrame * offsetCf * CFrame.new(0, 0, -v12 * 0.5)
			end)
		end):andThen(function()
			v6 = nil
		end)
		p1._maid:GiveTask(function()
			if v6 then
				v6:cancel()
				v6 = nil
			end
		end)
		local v8 = Region.new(RegionUtils.ConditionPlayer)
		local v9 = p1._obj:FindFirstChild(p2.regionName or "Region")
		local t = {}
		local function updatePrism()
			t.c = v9.CFrame
			t.s = v9.Size
		end
		t.c = v9.CFrame
		t.s = v9.Size
		v8:AddPrism(t)
		p1._maid:GiveTask(v8)
		p1._maid:GiveTask(v8.OnObjAdded:Connect(function()
			if not DoorUtils.getOpen(v7) then
				p3:FireServer("xe6v1us6", damageAmount, "Spikes")
				DoorUtils.setOpen(v7, true)
				Promise.delay(v5):andThen(function()
					DoorUtils.setOpen(v7, false)
				end)
				Audio.ObjectLocal(v7.PrimaryPart, audioId, {
					Volume = 0.5,
					RollOffMaxDistance = 64
				})
			end
		end))
		p1._maid:GiveTask(Interval.every(0.2):Connect(function()
			t.c = v9.CFrame
			t.s = v9.Size
			v8:Update({ LocalPlayer })
		end))
	end
}
