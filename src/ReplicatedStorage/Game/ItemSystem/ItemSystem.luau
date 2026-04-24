-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local DefaultActions = require(ReplicatedStorage.Game.DefaultActions)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local Interval = require(ReplicatedStorage.Std.Interval)
local Audio = require(ReplicatedStorage.Std.Audio)
local JetPack = require(ReplicatedStorage.Game.JetPack.JetPack)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local Falling = require(ReplicatedStorage.Game.Falling)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local CharacterBinder = require(ReplicatedStorage.App.CharacterBinder)
local ItemDataUtils = require(ReplicatedStorage.App.ItemDataUtils)
local InventoryItemOwnerBinder = require(ReplicatedStorage.Inventory.InventoryItemOwnerBinder)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local v1 = nil
local t = {}
local t2 = {}
local t3 = {}
local t4 = {
	OnLocalItemEquipped = Signal.new(),
	OnLocalItemUnequipped = Signal.new(),
	onItemEquipped = Signal.new()
}
function t4.Init(p1)
	v1 = p1.Event
	local em = p1.em
	function em.ogsbqczn(p1, p2, p3)
		local v1 = t4.GetEquipped(p1)
		if v1 ~= nil then
			v1:InputBegan({
				UserInputType = p2,
				KeyCode = p3
			}, false)
		end
	end
	function em.p2ylc2nx(p1, p2, p3)
		local v1 = t4.GetEquipped(p1)
		if v1 ~= nil then
			v1:InputEnded({
				UserInputType = p2,
				KeyCode = p3
			}, false)
		end
	end
	InventoryItemSystem.addEquipCondition(function()
		return not t2[LocalPlayer]
	end)
	InventoryItemSystem.addEquipCondition(function()
		if CharacterUtil.IsCrawling or (Falling.IsRagdolling() or JetPack.IsFlying()) then
			return false
		else
			local v1 = PlayerUtils.getHumanoid(LocalPlayer)
			if v1 then
				return not (v1.Health <= 0.001)
			else
				return false
			end
		end
	end)
	InventoryItemSystem.addEquipCondition(function()
		local v1 = VehicleUtils.GetLocalVehiclePacket()
		local v2 = tick()
		if v1 then
			local v3 = false
			if v2 - VehicleUtils.LastVehicleExit > 0.1 then
				local Seat = v1.Seat
				if Seat:FindFirstChild("Lean") or Seat:FindFirstChild("Items") then
					v3 = true
				end
			end
			if v3 then
				return true
			else
				return false
			end
		else
			return true
		end
	end)
	local function handleEquipped(p1)
		if t2[p1:GetOwner()] then
			t4._unequip(p1:GetOwner())
			warn("An item was already equipped, choosing newer server state.")
		end
		local v1 = t4._equip(p1:GetOwner(), p1.obj)
		if v1.SetLeaning then
			local v2 = VehicleUtils.GetLocalVehiclePacket()
			if v2 then
				local Seat = v2.Seat
				if Seat:FindFirstChild("Lean") then
					v1:SetLeaning(true, v2.Model:FindFirstChild("Engine").CFrame:PointToObjectSpace(Seat.Position).X > 0)
				end
			end
		end
		if v1.Model then
			local Character = p1:GetOwner().Character
			local v4 = v1.Model.Parent
			local function updateParent()
				if v1.Model then
					if Character.Parent then
						v1.Model.Parent = v4
					else
						v1.Model.Parent = nil
					end
				end
			end
			if v1.Model then
				if Character.Parent then
					v1.Model.Parent = v4
				else
					v1.Model.Parent = nil
				end
			end
			p1._maid.listenParent = Character.AncestryChanged:Connect(updateParent)
		end
		if not InventoryItemUtils.getLocked(p1.obj) then
			Audio.ObjectLocal(v1.RootPart, 690572276, {
				Volume = 0.8
			})
		end
	end
	local function updateCharacter(p1)
		local obj = p1.obj
		p1.maid:GiveTask(InventoryItemSystem.onInventoryItemEquipped:Connect(function(p1)
			if p1:GetOwner().Character == obj then
				handleEquipped(p1)
			end
		end))
		for v1, v2 in InventoryItemSystem.getEquipped() do
			if v2:GetOwner().Character == obj then
				handleEquipped(v2)
			end
		end
	end
	for v12, v2 in CharacterBinder:GetAll() do
		updateCharacter(v2)
	end
	CharacterBinder:GetClassAddedSignal():Connect(updateCharacter)
	InventoryItemSystem.onInventoryItemEquipped:Connect(function(p1)
		local v1 = p1:GetOwner()
		if typeof(v1) == "table" and getmetatable(v1) == InventoryItemOwnerBinder:GetConstructor() then
			if v1.Character then
				handleEquipped(p1)
			end
			p1._maid:GiveTask(v1._onCharacterChanged:Connect(function()
				if v1.Character then
					handleEquipped(p1)
				end
			end))
		end
	end)
	local function handleUnequippedRaw(p1, p2)
		t3[p1] = p2
		task.delay(1, function()
			if t3[p1] == p2 then
				t3[p1] = nil
			end
		end)
		if p2.IsLeaning then
			p2:SetLeaning(false)
		end
		t4._unequip(p1)
	end
	local function clearUnknownOwners()
		for v2, v3 in t2 do
			local v1
			local Character = v2.Character
			v1 = not (Character and (Character.PrimaryPart and Character.PrimaryPart:IsDescendantOf(workspace)))
			if v1 then
				handleUnequippedRaw(v2, v3)
			end
		end
	end
	Interval.every(1):Connect(clearUnknownOwners)
	local function handleUnequipped(p1)
		local v1 = InventoryItemUtils.getName(p1.obj)
		local v2 = p1:GetOwner()
		if v2 then
			local v3 = t4.GetEquipped(v2)
			if v3 and v3.__ClassName == v1 then
				handleUnequippedRaw(v2, v3)
			end
		else
			clearUnknownOwners()
		end
	end
	InventoryItemSystem.onInventoryItemUnequipped:Connect(handleUnequipped)
	local priority = DefaultActions.crawlButton.priority
	local priority_2 = DefaultActions.sprintButton.priority
	t4.OnLocalItemEquipped:Connect(function(p1)
		local Maid = p1.Maid
		if p1.ShootBegin then
			local v1 = p1.ShootActionButtonConfig or {}
			local t = {}
			t.primary = if v1.primary == nil then true else v1.primary
			t.priority = if v1.priority == nil then 1050 else v1.priority
			t.saturateTo = if v1.saturateTo == nil then 0 else v1.saturateTo
			t.noSink = true
			t.keyCodes = v1.keyCodes
			t.image = "rbxassetid://4939736393"
			function t.onPressed()
				p1:InputBegan({
					UserInputType = Enum.UserInputType.MouseButton1
				})
			end
			function t.onReleased()
				if p1.InputEnded then
					p1:InputEnded({
						UserInputType = Enum.UserInputType.MouseButton1
					})
				end
			end
			Maid:GiveTask(ActionButtonService.add(t))
		end
		if p1.Reload then
			Maid:GiveTask(ActionButtonService.add({
				priority = 750,
				image = "rbxassetid://4939737424",
				keyCodes = { Enum.KeyCode.R },
				onPressed = function()
					p1:InputBegan({
						UserInputType = Enum.UserInputType.Keyboard,
						KeyCode = Enum.KeyCode.R
					})
				end
			}))
		end
		local ScopeBegin = p1.ScopeBegin
		if ScopeBegin then
			ScopeBegin = typeof(p1.ScopeBegin) == "function"
		end
		if ScopeBegin then
			Maid:GiveTask(ActionButtonService.add({
				priority = 975,
				image = "rbxassetid://4939736720",
				touchIsToggle = true,
				keyCodes = { Enum.KeyCode.Q, Enum.KeyCode.ButtonL2 },
				noSink = true,
				onPressed = function()
					p1:InputBegan({
						UserInputType = Enum.UserInputType.MouseButton2
					})
				end,
				onReleased = function()
					if p1.InputEnded then
						p1:InputEnded({
							UserInputType = Enum.UserInputType.MouseButton2
						})
					end
				end
			}))
		end
		if p1.ApplySkin and typeof(p1.ApplySkin) == "function" then
			local v5 = false
			local function checkFlagToggleSkins()
				local v1 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
				if v1 then
					local v2 = false
					for v3, v4 in CollectionService:GetTagged("GunSkinUIRegion") do
						if RegionUtils.isPointInPart(v4, v1.Position) then
							v2 = true
							break
						end
					end
					if v2 ~= v5 then
						p1:InputBegan({
							FlagToggleSkins = v2
						})
						v5 = v2
					end
				end
			end
			Maid:GiveTask(Interval.every(0.1):Connect(function()
				checkFlagToggleSkins()
			end))
			checkFlagToggleSkins()
		end
		if not ScopeBegin then
			ActionButtonService.setButtonPriority(DefaultActions.crawlButton, 900)
			ActionButtonService.setButtonPriority(DefaultActions.sprintButton, 950)
			Maid:GiveTask(function()
				ActionButtonService.setButtonPriority(DefaultActions.crawlButton, priority)
				ActionButtonService.setButtonPriority(DefaultActions.sprintButton, priority_2)
			end)
		end
		local v6 = VehicleUtils.GetLocalVehiclePacket()
		if v6 == nil or v6.Passenger then
			ActionButtonService.setButtonEnabled(DefaultActions.radioButton, false)
			Maid:GiveTask(function()
				ActionButtonService.setButtonEnabled(DefaultActions.radioButton, true)
			end)
		end
	end)
	InventoryItemBinder:GetClassAddedSignal():Connect(function(p1)
		p1._maid:GiveTask(p1.onAttemptDrop:Connect(function()
			if p1:GetOwner() == Players.LocalPlayer then
				v1:FireServer("x" .. ("cutr"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("sdartlwu"):sub(4, 5):reverse():reverse():reverse() .. "1qyd")
			end
		end))
	end)
end
function t4.Register(p1)
	assert(p1.__ClassName)
	assert(t[p1.__ClassName] == nil)
	t[p1.__ClassName] = p1
end
function t4.GetConfig(p1)
	return ItemDataUtils.getConfig(p1)
end
function t4.GetEquipped(p1)
	return t2[p1]
end
function t4.GetLocalEquipped()
	return t4.GetEquipped(LocalPlayer)
end
function t4._equip(p1, p2)
	assert(p1, "missing player")
	assert(p2, "missing inventoryItemValue")
	local v12 = InventoryItemUtils.getName(p2)
	local v5 = t[if InventoryItemUtils.getAttr(p2, "CustomItem") == true then "Custom" else v12]
	if not v5 then
		error(("No module for item: %s"):format(v12))
	end
	local v6 = v5.new(p1, p2, t3[p1])
	if v6.Local then
		v6.Maid:GiveTask(UserInputService.InputBegan:Connect(function(p1, p2)
			v6:InputBegan(p1, p2)
		end))
		v6.Maid:GiveTask(UserInputService.InputEnded:Connect(function(...)
			v6:InputEnded(...)
		end))
		if v6.ShootBegin == nil then
			v6.Maid:GiveTask(UserInputService.TouchStarted:connect(function(p1, p2)
				if p2 then
					return false
				end
				v6:InputBegan({
					UserInputType = Enum.UserInputType.MouseButton1,
					Position = p1.Position
				})
			end))
			v6.Maid:GiveTask(UserInputService.TouchEnded:connect(function(p1, p2)
				if p2 then
					return false
				end
				v6:InputEnded({
					UserInputType = Enum.UserInputType.MouseButton1,
					Position = p1.Position
				})
			end))
		end
		function v6.BroadcastInputBegan(p1, p2)
			assert(p2 ~= nil)
			v1:FireServer("ogsbqczn", p2.UserInputType, p2.KeyCode)
		end
		function v6.BroadcastInputEnded(p1, p2)
			assert(p2 ~= nil)
			v1:FireServer("p" .. ("t2dblf"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("lclyh"):sub(2, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("pn2l"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "x", p2.UserInputType, p2.KeyCode)
		end
	end
	t2[p1] = v6
	if v6.Local then
		for i, v in ipairs(UserInputService:GetKeysPressed()) do
			v6:InputBegan(v)
		end
		for i, v in ipairs(UserInputService:GetMouseButtonsPressed()) do
			if v.UserInputType ~= Enum.UserInputType.MouseButton1 then
				v6:InputBegan(v)
			end
		end
	end
	if v6.Local then
		t4.OnLocalItemEquipped:Fire(v6)
	end
	t4.onItemEquipped:Fire(v6)
	return v6
end
function t4._unequip(p1)
	assert(p1, "missing player")
	local v1 = t2[p1]
	if v1 then
		v1:Destroy()
		t2[p1] = nil
		if v1.Local then
			t4.OnLocalItemUnequipped:Fire()
		end
		return true
	else
		return false
	end
end
return t4
