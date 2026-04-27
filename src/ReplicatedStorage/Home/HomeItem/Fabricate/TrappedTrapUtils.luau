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
	setup = function(self, setupConfig, remoteEvent)
		local spikesName = setupConfig.spikesName or "Spikes"
		local referenceName = setupConfig.referenceName or "Shelving"
		local offsetCf = setupConfig.offsetCf
		local spikeSizeMin = setupConfig.spikeSizeMin
		local spikeSizeMax = setupConfig.spikeSizeMax
		local damageAmount = setupConfig.damageAmount
		local audioId = setupConfig.audioId
		local doorCloseDelay = setupConfig.doorCloseDelay or 1
		local doorBinderPromise = nil
		local fakeDoor = self._obj:WaitForChild(setupConfig.doorName or "FakeDoor")
		doorBinderPromise = BinderUtils.promiseBoundClass(DoorBinder, fakeDoor):tap(function(doorBinder)
			local spikesInstance = self._obj:FindFirstChild(spikesName)
			local referenceInstance = self._obj:FindFirstChild(referenceName)
			doorBinder:SetUpdateCallback(function(self, progress)
				local interpolatedSize = spikeSizeMin * (1 - progress) + spikeSizeMax * progress
				spikesInstance.Size = Vector3.new(spikesInstance.Size.X, spikesInstance.Size.Y, interpolatedSize)
				spikesInstance.CFrame = referenceInstance.CFrame * offsetCf * CFrame.new(0, 0, -interpolatedSize * 0.5)
			end)
		end):andThen(function()
			doorBinderPromise = nil
		end)
		self._maid:GiveTask(function()
			if doorBinderPromise then
				doorBinderPromise:cancel()
				doorBinderPromise = nil
			end
		end)
		local damageRegion = Region.new(RegionUtils.ConditionPlayer)
		local regionPart = self._obj:FindFirstChild(setupConfig.regionName or "Region")
		local prismData = {}
		local function updatePrism()
			prismData.c = regionPart.CFrame
			prismData.s = regionPart.Size
		end
		prismData.c = regionPart.CFrame
		prismData.s = regionPart.Size
		damageRegion:AddPrism(prismData)
		self._maid:GiveTask(damageRegion)
		self._maid:GiveTask(damageRegion.OnObjAdded:Connect(function()
			if not DoorUtils.getOpen(fakeDoor) then
				remoteEvent:FireServer("xe6v1us6", damageAmount, "Spikes")
				DoorUtils.setOpen(fakeDoor, true)
				Promise.delay(doorCloseDelay):andThen(function()
					DoorUtils.setOpen(fakeDoor, false)
				end)
				Audio.ObjectLocal(fakeDoor.PrimaryPart, audioId, {
					Volume = 0.5,
					RollOffMaxDistance = 64
				})
			end
		end))
		self._maid:GiveTask(Interval.every(0.2):Connect(function()
			prismData.c = regionPart.CFrame
			prismData.s = regionPart.Size
			damageRegion:Update({ LocalPlayer })
		end))
	end
}
