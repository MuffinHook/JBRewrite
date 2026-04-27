local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunUtils = require(ReplicatedStorage.Game.GunShop.GunUtils)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local CrossHair = require(ReplicatedStorage.Game.CrossHair)
local Audio = require(ReplicatedStorage.Std.Audio)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local TagUtils = require(ReplicatedStorage.Tag.TagUtils)
local Notification = require(ReplicatedStorage.Game.Notification)
local LightningUtils = require(ReplicatedStorage.Game.LightningUtils)
local Basic = require(script.Parent.Basic)
local Taser = require(ReplicatedStorage.Game.ItemConfig.Taser)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local eventDispatcher = nil
local TaserClass = {
	__ClassName = "Taser"
}
TaserClass.__index = TaserClass
setmetatable(TaserClass, Basic)
function TaserClass.Init(self)
	eventDispatcher = self.Event
	function self.em.enmm5zqj(self, eventData)
		local equippedItem = ItemSystem.GetEquipped(self)
		if equippedItem ~= nil and equippedItem.Draw then
			equippedItem:Draw(eventData)
		end
	end
end
function TaserClass.new(self, itemConfig, additionalConfig)
	local instance = Basic.new(self, itemConfig, Taser, additionalConfig)
	setmetatable(instance, TaserClass)
	instance.Tip = instance.Model.Skeleton.Tip
	instance.IgnoreList = { instance.Character, instance.Model }
	if not InventoryItemUtils.getAttr(instance.inventoryItemValue, "NextUse") then
		InventoryItemUtils.setAttr(instance.inventoryItemValue, "NextUse", os.clock())
		InventoryItemUtils.setAttr(instance.inventoryItemValue, "LastUsedAt", 0)
	end
	if instance.Local then
		instance:SetupCrossHair()
	end
	instance._customCollidableFunc = instance:_buildCustomCollidableFunc()
	if instance.Local then
		local shouldAddEquipTime = GunUtils.getShouldAddEquipTime(instance)
		local nextUseTime = InventoryItemUtils.getAttr(instance.inventoryItemValue, "NextUse") or 0
		local lastUsedAt = InventoryItemUtils.getAttr(instance.inventoryItemValue, "LastUsedAt") or 0
		local currentTime = os.clock()
		if currentTime < nextUseTime then
			instance:StartReloadProgressCircle(nextUseTime - lastUsedAt, os.clock() - (currentTime - lastUsedAt))
			return instance
		elseif shouldAddEquipTime then
			instance.IsEquipping = true
			instance:StartReloadProgressCircle(GunSystemConsts.GUN_EQUIP_TIME)
			instance.maid:GiveTask(task.delay(GunSystemConsts.GUN_EQUIP_TIME, function()
				instance.IsEquipping = false
			end))
		end
	end
	return instance
end
function TaserClass._buildCustomCollidableFunc(self)
	return function(part)
		if not part.CanCollide and self._lastListCharacter then
			for i, v in ipairs(self._lastListCharacter) do
				local _ = part:IsDescendantOf(v)
			end
		end
		return true
	end
end
function TaserClass.UpdateCrossHair(self)
	self.CrossHair:Update(self:GetMouseLocation())
end
function TaserClass.SetupCrossHair(self)
	self.CrossHair = CrossHair.Make()
	self.CrossHair.Gui.Parent = self.Player.PlayerGui
	self.Maid:GiveTask(function()
		self.CrossHair:Destroy()
		self.CrossHair = nil
	end)
end
function TaserClass.Heartbeat(self)
	Basic.Heartbeat(self)
	if self.Local then
		self:UpdateCrossHair()
	end
end
function TaserClass.GetLeftArmPosition(self)
	return nil
end
function TaserClass.Draw(self, targetPosition)
	local currentTime = os.clock()
	if not (self._lastDraw and currentTime - self._lastDraw < 1) then
		self._lastDraw = currentTime
		local lightningEffect = LightningUtils.strikePosition({
			Origin = self.Tip.Position,
			Target = targetPosition,
			NumSegments = 10,
			OffsetRadius = 2,
			PartWidth = 0.1,
			Transparency = 0,
			Color = Color3.fromRGB(175, 130, 90)
		})
		game:GetService("Debris"):AddItem(lightningEffect, 0.1)
		if self.Local then
			eventDispatcher:FireServer("enmm5zqj", targetPosition)
		end
	end
end
function TaserClass.Tase(self, keycode)
	if not self.IsEquipping then
		local currentTime = os.clock()
		if not (currentTime - InventoryItemUtils.getAttr(self.inventoryItemValue, "NextUse") < 0) then
			local Character = Players.LocalPlayer.Character
			if Character and TagUtils.isPointInTag(Character.PrimaryPart.Position, "NoTaser") then
				if self.Local then
					Notification.new({
						Text = "Tasers not allowed here."
					})
				end
			elseif Character then
				Audio.ObjectLocal(self.Tip, self.Config.Sound.taser_buzz)
				self:UpdateMousePosition()
				if self.Local then
					self.CrossHair.Spring:Accelerate(600)
					local otherCharactersList = {}
					for index, player in Players:GetPlayers() do
						if player ~= LocalPlayer and player.Character then
							table.insert(otherCharactersList, player.Character)
						end
					end
					self._lastListCharacter = otherCharactersList
					local tipPosition = self.Tip.Position
					local directionVector = self.MousePosition - self.Tip.Position
					RaycastParams.new().FilterDescendantsInstances = self.IgnoreList
					local raycastHit = Raycast.collidable(tipPosition, directionVector.Unit, self.Config.Range)
					local hitInstance = nil
					local targetPosition
					if raycastHit then
						targetPosition = raycastHit.Position
						hitInstance = raycastHit.Instance
					else
						targetPosition = tipPosition + directionVector.Unit * self.Config.Range
					end
					if not hitInstance then
						for i, character in otherCharactersList do
							local PrimaryPart = character.PrimaryPart
							if PrimaryPart then
								local intersectionPoint = GeomUtils.calcRayIntersectSphere(tipPosition, tipPosition + directionVector, PrimaryPart.Position, 3)
								if intersectionPoint then
									hitInstance = character.PrimaryPart
									targetPosition = intersectionPoint
								end
							end
						end
					end
					self:Draw(targetPosition)
					local reloadTime = self.Config.ReloadTime
					local nextUseTime = currentTime + reloadTime
					if hitInstance then
						local hitPlayer = PlayerUtils.getPlayerFromDescendant(hitInstance)
						if hitPlayer then
							eventDispatcher:FireServer("qzetmoke", hitPlayer.Character:FindFirstChild("Humanoid"), hitInstance, targetPosition)
							nextUseTime = currentTime + self.Config.ReloadTimeHit
							self.CrossHair:Flare()
							reloadTime = self.Config.ReloadTimeHit
						end
					end
					if self.Local then
						self:StartReloadProgressCircle(reloadTime)
					end
					InventoryItemUtils.setAttr(self.inventoryItemValue, "LastUsedAt", currentTime)
					InventoryItemUtils.setAttr(self.inventoryItemValue, "NextUse", nextUseTime)
					self:BroadcastInputBegan(keycode)
				end
				GunUtils.setLastShotTime(self.Player, workspace:GetServerTimeNow())
				return true
			end
		end
	end
	return false
end
function TaserClass.InputBegan(self, inputData, gameProcessed)
	if if inputData.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputData.UserInputType == Enum.UserInputType.Gamepad1 then inputData.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:Tase(inputData)
	end
	Basic.InputBegan(self, inputData, gameProcessed)
end
function TaserClass.InputEnded(self)  end
return TaserClass
