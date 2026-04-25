-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local DogConsts = require(ReplicatedStorage.Game.Dog.DogConsts)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local AdoptionStandUI = require(script.Parent.AdoptionStandUI)
local AdoptionSystem = require(script.Parent.AdoptionSystem)
local AdoptionStandConsts = require(script.Parent.AdoptionStandConsts)
local AdoptionStand = {}
AdoptionStand.__index = AdoptionStand
AdoptionStand.__ClassName = "AdoptionStand"
function AdoptionStand.new(standPart)
	local self = {}
	setmetatable(self, AdoptionStand)
	self._maid = Maid.new()
	self._breedIdValue = standPart:WaitForChild(AdoptionStandConsts.BREED_ID_VALUE_NAME)
	self._adoptRemote = standPart:WaitForChild(AdoptionStandConsts.ADOPT_REMOTE_NAME)
	local circleActionConfig = {
		Part = standPart,
		Timed = false,
		Dist = 8,
		Callback = function(player, isOpen)
			if isOpen then
				local breedId = self:GetBreedId()
				self._maid.walkAwayLoop = Interval.every(1):Connect(function()
					local rootPart = PlayerUtils.getRootPart(LocalPlayer)
					if rootPart and ((rootPart.Position - standPart.Position).Magnitude > 16 and AdoptionStandUI.isOpen()) then
						AdoptionStandUI.close()
					end
				end)
				self._maid.onClickAdopt = AdoptionStandUI.getOnClickAdoptSignal():Connect(function()
					self._adoptRemote:FireServer((AdoptionStandUI.getName()))
					AdoptionStandUI.close()
				end)
				self._maid.onClosed = AdoptionStandUI.getOnClosedSignal():Connect(function()
					self._maid.walkAwayLoop = nil
					self._maid.onClosed = nil
					self._maid.onClickAdopt = nil
				end)
				local doesOwn = AdoptionSystem.doesOwn(breedId)
				local adoptPrice = if doesOwn then nil else DogConsts.PRICE[breedId]
				AdoptionStandUI.setName(AdoptionSystem.getDogName(breedId) or "")
				AdoptionStandUI.setTitle(DogConsts.TITLE[breedId]:upper())
				AdoptionStandUI.setImageId(DogConsts.IMAGE_ID[breedId])
				AdoptionStandUI.setDescriptionTeam(DogConsts.OPT_TEAM[breedId])
				AdoptionStandUI.setPrice(adoptPrice)
				AdoptionStandUI.setFirstAdopt(not doesOwn)
				AdoptionStandUI.open()
				return true
			end
		end,
		PreUpdateFun = function(standPart)
			standPart.Enabled = not AdoptionStandUI.isOpen()
		end,
		PreUpdatePeriod = 0.5
	}
	CircleAction.Add(circleActionConfig, standPart)
	self._maid:GiveTask(function()
		CircleAction.Remove(standPart)
	end)
	local function updateSpec()
		circleActionConfig.Name = ("Adopt %s"):format(DogConsts.TITLE[self:GetBreedId()])
	end
	self._maid:GiveTask(self._breedIdValue.Changed:Connect(updateSpec))
	circleActionConfig.Name = ("Adopt %s"):format(DogConsts.TITLE[self:GetBreedId()])
	return self
end
function AdoptionStand.GetBreedId(standPart)
	return standPart._breedIdValue.Value
end
function AdoptionStand.Destroy(standPart)
	local _maid = standPart._maid
	assert(_maid ~= nil)
	standPart._maid = nil
	_maid:Destroy()
end
return AdoptionStand
