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
local v2 = nil
local t = {
	__ClassName = "Taser"
}
t.__index = t
setmetatable(t, Basic)
function t.Init(p1) --[[ Line: 29 | Upvalues: v2 (ref), ItemSystem (copy) ]]
	v2 = p1.Event
	function p1.em.enmm5zqj(p1, p2) --[[ Line: 32 | Upvalues: ItemSystem (ref) ]]
		local v1 = ItemSystem.GetEquipped(p1)
		if v1 ~= nil and v1.Draw then
			v1:Draw(p2)
		end
	end
end
function t.new(p1, p2, p3) --[[ Line: 41 | Upvalues: Basic (copy), Taser (copy), t (copy), InventoryItemUtils (copy), GunUtils (copy), GunSystemConsts (copy) ]]
	local v1 = Basic.new(p1, p2, Taser, p3)
	setmetatable(v1, t)
	v1.Tip = v1.Model.Skeleton.Tip
	v1.IgnoreList = { v1.Character, v1.Model }
	if not InventoryItemUtils.getAttr(v1.inventoryItemValue, "NextUse") then
		InventoryItemUtils.setAttr(v1.inventoryItemValue, "NextUse", os.clock())
		InventoryItemUtils.setAttr(v1.inventoryItemValue, "LastUsedAt", 0)
	end
	if v1.Local then
		v1:SetupCrossHair()
	end
	v1._customCollidableFunc = v1:_buildCustomCollidableFunc()
	if v1.Local then
		local v3 = GunUtils.getShouldAddEquipTime(v1)
		local v4 = InventoryItemUtils.getAttr(v1.inventoryItemValue, "NextUse") or 0
		local v5 = InventoryItemUtils.getAttr(v1.inventoryItemValue, "LastUsedAt") or 0
		local v6 = os.clock()
		if v6 < v4 then
			v1:StartReloadProgressCircle(v4 - v5, os.clock() - (v6 - v5))
			return v1
		elseif v3 then
			v1.IsEquipping = true
			v1:StartReloadProgressCircle(GunSystemConsts.GUN_EQUIP_TIME)
			v1.maid:GiveTask(task.delay(GunSystemConsts.GUN_EQUIP_TIME, function() --[[ Line: 71 | Upvalues: v1 (copy) ]]
				v1.IsEquipping = false
			end))
		end
	end
	return v1
end
function t._buildCustomCollidableFunc(p1) --[[ Line: 80 ]]
	return function(p12) --[[ Line: 81 | Upvalues: p1 (copy) ]]
		if not p12.CanCollide and p1._lastListCharacter then
			for i, v in ipairs(p1._lastListCharacter) do
				local _ = p12:IsDescendantOf(v)
			end
		end
		return true
	end
end
function t.UpdateCrossHair(p1) --[[ Line: 94 ]]
	p1.CrossHair:Update(p1:GetMouseLocation())
end
function t.SetupCrossHair(p1) --[[ Line: 97 | Upvalues: CrossHair (copy) ]]
	p1.CrossHair = CrossHair.Make()
	p1.CrossHair.Gui.Parent = p1.Player.PlayerGui
	p1.Maid:GiveTask(function() --[[ Line: 101 | Upvalues: p1 (copy) ]]
		p1.CrossHair:Destroy()
		p1.CrossHair = nil
	end)
end
function t.Heartbeat(p1) --[[ Line: 107 | Upvalues: Basic (copy) ]]
	Basic.Heartbeat(p1)
	if p1.Local then
		p1:UpdateCrossHair()
	end
end
function t.GetLeftArmPosition(p1) --[[ Line: 113 ]]
	return nil
end
function t.Draw(p1, p2) --[[ Line: 116 | Upvalues: LightningUtils (copy), v2 (ref) ]]
	local v1 = os.clock()
	if not (p1._lastDraw and v1 - p1._lastDraw < 1) then
		p1._lastDraw = v1
		local v22 = LightningUtils.strikePosition({
			Origin = p1.Tip.Position,
			Target = p2,
			NumSegments = 10,
			OffsetRadius = 2,
			PartWidth = 0.1,
			Transparency = 0,
			Color = Color3.fromRGB(175, 130, 90)
		})
		game:GetService("Debris"):AddItem(v22, 0.1)
		if p1.Local then
			v2:FireServer("e" .. ("auynrozj"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ppemmyz"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "5zqj", p2)
		end
	end
end
function t.Tase(p1, p2) --[[ Line: 155 | Upvalues: InventoryItemUtils (copy), Players (copy), TagUtils (copy), Notification (copy), Audio (copy), LocalPlayer (copy), Raycast (copy), GeomUtils (copy), PlayerUtils (copy), v2 (ref), GunUtils (copy) ]]
	if not p1.IsEquipping then
		local v1 = os.clock()
		if not (v1 - InventoryItemUtils.getAttr(p1.inventoryItemValue, "NextUse") < 0) then
			local Character = Players.LocalPlayer.Character
			if Character and TagUtils.isPointInTag(Character.PrimaryPart.Position, "NoTaser") then
				if p1.Local then
					Notification.new({
						Text = "Tasers not allowed here."
					})
				end
			elseif Character then
				Audio.ObjectLocal(p1.Tip, p1.Config.Sound.taser_buzz)
				p1:UpdateMousePosition()
				if p1.Local then
					p1.CrossHair.Spring:Accelerate(600)
					local t = {}
					for v22, v3 in Players:GetPlayers() do
						if v3 ~= LocalPlayer and v3.Character then
							table.insert(t, v3.Character)
						end
					end
					p1._lastListCharacter = t
					local Position = p1.Tip.Position
					local v4 = p1.MousePosition - p1.Tip.Position
					RaycastParams.new().FilterDescendantsInstances = p1.IgnoreList
					local v5 = Raycast.collidable(Position, v4.Unit, p1.Config.Range)
					local v6 = nil
					local v7
					if v5 then
						v7 = v5.Position
						v6 = v5.Instance
					else
						v7 = Position + v4.Unit * p1.Config.Range
					end
					if not v6 then
						for v8, v9 in t do
							local PrimaryPart = v9.PrimaryPart
							if PrimaryPart then
								local v10 = GeomUtils.calcRayIntersectSphere(Position, Position + v4, PrimaryPart.Position, 3)
								if v10 then
									v6 = v9.PrimaryPart
									v7 = v10
								end
							end
						end
					end
					p1:Draw(v7)
					local ReloadTime = p1.Config.ReloadTime
					local v11 = v1 + ReloadTime
					if v6 then
						local v12 = PlayerUtils.getPlayerFromDescendant(v6)
						if v12 then
							v2:FireServer("q" .. ("upskomtezlii"):sub(4, 9):reverse():reverse():reverse():reverse():reverse() .. "e", v12.Character:FindFirstChild("Humanoid"), v6, v7)
							v11 = v1 + p1.Config.ReloadTimeHit
							p1.CrossHair:Flare()
							ReloadTime = p1.Config.ReloadTimeHit
						end
					end
					if p1.Local then
						p1:StartReloadProgressCircle(ReloadTime)
					end
					InventoryItemUtils.setAttr(p1.inventoryItemValue, "LastUsedAt", v1)
					InventoryItemUtils.setAttr(p1.inventoryItemValue, "NextUse", v11)
					p1:BroadcastInputBegan(p2)
				end
				GunUtils.setLastShotTime(p1.Player, workspace:GetServerTimeNow())
				return true
			end
		end
	end
	return false
end
function t.InputBegan(p1, p2, p3) --[[ Line: 244 | Upvalues: Basic (copy) ]]
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1:Tase(p2)
	end
	Basic.InputBegan(p1, p2, p3)
end
function t.InputEnded(p1) --[[ Line: 254 ]] end
return t