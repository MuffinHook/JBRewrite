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
	setup = function(self, p2, p3)
		local v2 = p2.spikesName or "Spikes"
		local var3 = p2.referenceName or "Shelving"
		local offsetCf = p2.offsetCf
		local spikeSizeMin = p2.spikeSizeMin
		local spikeSizeMax = p2.spikeSizeMax
		local damageAmount = p2.damageAmount
		local audioId = p2.audioId
		local var5 = p2.doorCloseDelay or 1
		local var6 = nil
		local var7 = self._obj:WaitForChild(p2.doorName or "FakeDoor")
		var6 = BinderUtils.promiseBoundClass(DoorBinder, var7):tap(function(p12)
			local v1 = self._obj:FindFirstChild(v2)
			local var22 = self._obj:FindFirstChild(var3)
			p12:SetUpdateCallback(function(self, p2)
				local var12 = spikeSizeMin * (1 - p2) + spikeSizeMax * p2
				v1.Size = Vector3.new(v1.Size.X, v1.Size.Y, var12)
				v1.CFrame = var22.CFrame * offsetCf * CFrame.new(0, 0, -var12 * 0.5)
			end)
		end):andThen(function()
			var6 = nil
		end)
		self._maid:GiveTask(function()
			if var6 then
				var6:cancel()
				var6 = nil
			end
		end)
		local instance8 = Region.new(RegionUtils.ConditionPlayer)
		local var9 = self._obj:FindFirstChild(p2.regionName or "Region")
		local t = {}
		local function updatePrism()
			t.c = var9.CFrame
			t.s = var9.Size
		end
		t.c = var9.CFrame
		t.s = var9.Size
		instance8:AddPrism(t)
		self._maid:GiveTask(instance8)
		self._maid:GiveTask(instance8.OnObjAdded:Connect(function()
			if not DoorUtils.getOpen(var7) then
				p3:FireServer("xe6v1us6", damageAmount, "Spikes")
				DoorUtils.setOpen(var7, true)
				Promise.delay(var5):andThen(function()
					DoorUtils.setOpen(var7, false)
				end)
				Audio.ObjectLocal(var7.PrimaryPart, audioId, {
					Volume = 0.5,
					RollOffMaxDistance = 64
				})
			end
		end))
		self._maid:GiveTask(Interval.every(0.2):Connect(function()
			t.c = var9.CFrame
			t.s = var9.Size
			instance8:Update({ LocalPlayer })
		end))
	end
}
