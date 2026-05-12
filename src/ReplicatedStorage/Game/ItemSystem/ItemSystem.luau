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
local itemDropEvent = nil
local itemRegistry = {}
local equippedItemsByPlayer = {}
local recentlyUnequippedItems = {}
local ItemSystem = {
	OnLocalItemEquipped = Signal.new(),
	OnLocalItemUnequipped = Signal.new(),
	onItemEquipped = Signal.new()
}
function ItemSystem.Init(configData)
	itemDropEvent = configData.Event
	local eventManager = configData.em
	function eventManager.itemInputBegan(player, inputType, keyCode)
		local equippedItem = ItemSystem.GetEquipped(player)
		if equippedItem ~= nil then
			equippedItem:InputBegan({
				UserInputType = inputType,
				KeyCode = keyCode
			}, false)
		end
	end
	function eventManager.itemInputEnded(player, inputType, keyCode)
		local equippedItem = ItemSystem.GetEquipped(player)
		if equippedItem ~= nil then
			equippedItem:InputEnded({
				UserInputType = inputType,
				KeyCode = keyCode
			}, false)
		end
	end
	InventoryItemSystem.addEquipCondition(function()
		return not equippedItemsByPlayer[LocalPlayer]
	end)
	InventoryItemSystem.addEquipCondition(function()
		if CharacterUtil.IsCrawling or (Falling.IsRagdolling() or JetPack.IsFlying()) then
			return false
		else
			local humanoid = PlayerUtils.getHumanoid(LocalPlayer)
			if humanoid then
				return not (humanoid.Health <= 0.001)
			else
				return false
			end
		end
	end)
	InventoryItemSystem.addEquipCondition(function()
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		local currentTime = tick()
		if vehiclePacket then
			local isValidForEquip = false
			if currentTime - VehicleUtils.LastVehicleExit > 0.1 then
				local Seat = vehiclePacket.Seat
				if Seat:FindFirstChild("Lean") or Seat:FindFirstChild("Items") then
					isValidForEquip = true
				end
			end
			if isValidForEquip then
				return true
			else
				return false
			end
		else
			return true
		end
	end)
	local function handleEquipped(inventoryItem)
		if equippedItemsByPlayer[inventoryItem:GetOwner()] then
			ItemSystem._unequip(inventoryItem:GetOwner())
			warn("An item was already equipped, choosing newer server state.")
		end
		local equippedItem = ItemSystem._equip(inventoryItem:GetOwner(), inventoryItem.obj)
		if equippedItem.SetLeaning then
			local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
			if vehiclePacket then
				local Seat = vehiclePacket.Seat
				if Seat:FindFirstChild("Lean") then
					equippedItem:SetLeaning(true, vehiclePacket.Model:FindFirstChild("Engine").CFrame:PointToObjectSpace(Seat.Position).X > 0)
				end
			end
		end
		if equippedItem.Model then
			local Character = inventoryItem:GetOwner().Character
			local itemModelParent = equippedItem.Model.Parent
			local function updateParent()
				if equippedItem.Model then
					if Character.Parent then
						equippedItem.Model.Parent = itemModelParent
					else
						equippedItem.Model.Parent = nil
					end
				end
			end
			if equippedItem.Model then
				if Character.Parent then
					equippedItem.Model.Parent = itemModelParent
				else
					equippedItem.Model.Parent = nil
				end
			end
			inventoryItem._maid.listenParent = Character.AncestryChanged:Connect(updateParent)
		end
		if not InventoryItemUtils.getLocked(inventoryItem.obj) then
			Audio.ObjectLocal(equippedItem.RootPart, 690572276, {
				Volume = 0.8
			})
		end
	end
	local function updateCharacter(characterData)
		local obj = characterData.obj
		characterData.maid:GiveTask(InventoryItemSystem.onInventoryItemEquipped:Connect(function(inventoryItem)
			if inventoryItem:GetOwner().Character == obj then
				handleEquipped(inventoryItem)
			end
		end))
		for _, equippedItem in InventoryItemSystem.getEquipped() do
			if equippedItem:GetOwner().Character == obj then
				handleEquipped(equippedItem)
			end
		end
	end
	for _, characterBinding in CharacterBinder:GetAll() do
		updateCharacter(characterBinding)
	end
	CharacterBinder:GetClassAddedSignal():Connect(updateCharacter)
	InventoryItemSystem.onInventoryItemEquipped:Connect(function(inventoryItem)
		local owner = inventoryItem:GetOwner()
		if typeof(owner) == "table" and getmetatable(owner) == InventoryItemOwnerBinder:GetConstructor() then
			if owner.Character then
				handleEquipped(inventoryItem)
			end
			inventoryItem._maid:GiveTask(owner._onCharacterChanged:Connect(function()
				if owner.Character then
					handleEquipped(inventoryItem)
				end
			end))
		end
	end)
	local function handleUnequippedRaw(player, unequippedItem)
		recentlyUnequippedItems[player] = unequippedItem
		task.delay(1, function()
			if recentlyUnequippedItems[player] == unequippedItem then
				recentlyUnequippedItems[player] = nil
			end
		end)
		if unequippedItem.IsLeaning then
			unequippedItem:SetLeaning(false)
		end
		ItemSystem._unequip(player)
	end
	local function clearUnknownOwners()
		for player, equippedItem in equippedItemsByPlayer do
			local isInvalid
			local Character = player.Character
			isInvalid = not (Character and (Character.PrimaryPart and Character.PrimaryPart:IsDescendantOf(workspace)))
			if isInvalid then
				handleUnequippedRaw(player, equippedItem)
			end
		end
	end
	Interval.every(1):Connect(clearUnknownOwners)
	local function handleUnequipped(inventoryItem)
		local itemName = InventoryItemUtils.getName(inventoryItem.obj)
		local owner = inventoryItem:GetOwner()
		if owner then
			local equippedItem = ItemSystem.GetEquipped(owner)
			if equippedItem and equippedItem.__ClassName == itemName then
				handleUnequippedRaw(owner, equippedItem)
			end
		else
			clearUnknownOwners()
		end
	end
	InventoryItemSystem.onInventoryItemUnequipped:Connect(handleUnequipped)
	local priority = DefaultActions.crawlButton.priority
	local priority_2 = DefaultActions.sprintButton.priority
	ItemSystem.OnLocalItemEquipped:Connect(function(equippedItem)
		local Maid = equippedItem.Maid
		if equippedItem.ShootBegin then
			local shootConfig = equippedItem.ShootActionButtonConfig or {}
			local shootButton = {}
			shootButton.primary = if shootConfig.primary == nil then true else shootConfig.primary
			shootButton.priority = if shootConfig.priority == nil then 1050 else shootConfig.priority
			shootButton.saturateTo = if shootConfig.saturateTo == nil then 0 else shootConfig.saturateTo
			shootButton.noSink = true
			shootButton.keyCodes = shootConfig.keyCodes
			shootButton.image = "rbxassetid://4939736393"
			function shootButton.onPressed()
				equippedItem:InputBegan({
					UserInputType = Enum.UserInputType.MouseButton1
				})
			end
			function shootButton.onReleased()
				if equippedItem.InputEnded then
					equippedItem:InputEnded({
						UserInputType = Enum.UserInputType.MouseButton1
					})
				end
			end
			Maid:GiveTask(ActionButtonService.add(shootButton))
		end
		if equippedItem.Reload then
			Maid:GiveTask(ActionButtonService.add({
				priority = 750,
				image = "rbxassetid://4939737424",
				keyCodes = { Enum.KeyCode.R },
				onPressed = function()
					equippedItem:InputBegan({
						UserInputType = Enum.UserInputType.Keyboard,
						KeyCode = Enum.KeyCode.R
					})
				end
			}))
		end
		local ScopeBegin = equippedItem.ScopeBegin
		if ScopeBegin then
			ScopeBegin = typeof(equippedItem.ScopeBegin) == "function"
		end
		if ScopeBegin then
			Maid:GiveTask(ActionButtonService.add({
				priority = 975,
				image = "rbxassetid://4939736720",
				touchIsToggle = true,
				keyCodes = { Enum.KeyCode.Q, Enum.KeyCode.ButtonL2 },
				noSink = true,
				onPressed = function()
					equippedItem:InputBegan({
						UserInputType = Enum.UserInputType.MouseButton2
					})
				end,
				onReleased = function()
					if equippedItem.InputEnded then
						equippedItem:InputEnded({
							UserInputType = Enum.UserInputType.MouseButton2
						})
					end
				end
			}))
		end
		if equippedItem.ApplySkin and typeof(equippedItem.ApplySkin) == "function" then
			local inSkinRegion = false
			local function checkFlagToggleSkins()
				local rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
				if rootPart then
					local isInRegion = false
					for _, region in CollectionService:GetTagged("GunSkinUIRegion") do
						if RegionUtils.isPointInPart(region, rootPart.Position) then
							isInRegion = true
							break
						end
					end
					if isInRegion ~= inSkinRegion then
						equippedItem:InputBegan({
							FlagToggleSkins = isInRegion
						})
						inSkinRegion = isInRegion
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
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		if vehiclePacket == nil or vehiclePacket.Passenger then
			ActionButtonService.setButtonEnabled(DefaultActions.radioButton, false)
			Maid:GiveTask(function()
				ActionButtonService.setButtonEnabled(DefaultActions.radioButton, true)
			end)
		end
	end)
	InventoryItemBinder:GetClassAddedSignal():Connect(function(inventoryItem)
		inventoryItem._maid:GiveTask(inventoryItem.onAttemptDrop:Connect(function()
			if inventoryItem:GetOwner() == Players.LocalPlayer then
				itemDropEvent:FireServer("dropItem")
			end
		end))
	end)
end
function ItemSystem.Register(itemModule)
	assert(itemModule.__ClassName)
	assert(itemRegistry[itemModule.__ClassName] == nil)
	itemRegistry[itemModule.__ClassName] = itemModule
end
function ItemSystem.GetConfig(player)
	return ItemDataUtils.getConfig(player)
end
function ItemSystem.GetEquipped(player)
	return equippedItemsByPlayer[player]
end
function ItemSystem.GetLocalEquipped()
	return ItemSystem.GetEquipped(LocalPlayer)
end
function ItemSystem._equip(player, inventoryItemValue)
	assert(player, "missing player")
	assert(inventoryItemValue, "missing inventoryItemValue")
	local itemClassName = InventoryItemUtils.getName(inventoryItemValue)
	local itemModule = itemRegistry[if InventoryItemUtils.getAttr(inventoryItemValue, "CustomItem") == true then "Custom" else itemClassName]
	if not itemModule then
		error(("No module for item: %s"):format(itemClassName))
	end
	local equippedItem = itemModule.new(player, inventoryItemValue, recentlyUnequippedItems[player])
	if equippedItem.Local then
		equippedItem.Maid:GiveTask(UserInputService.InputBegan:Connect(function(inputEvent, gameProcessed)
			equippedItem:InputBegan(inputEvent, gameProcessed)
		end))
		equippedItem.Maid:GiveTask(UserInputService.InputEnded:Connect(function(...)
			equippedItem:InputEnded(...)
		end))
		if equippedItem.ShootBegin == nil then
			equippedItem.Maid:GiveTask(UserInputService.TouchStarted:connect(function(touchInput, gameProcessed)
				if gameProcessed then
					return false
				end
				equippedItem:InputBegan({
					UserInputType = Enum.UserInputType.MouseButton1,
					Position = touchInput.Position
				})
			end))
			equippedItem.Maid:GiveTask(UserInputService.TouchEnded:connect(function(touchInput, gameProcessed)
				if gameProcessed then
					return false
				end
				equippedItem:InputEnded({
					UserInputType = Enum.UserInputType.MouseButton1,
					Position = touchInput.Position
				})
			end))
		end
		function equippedItem.BroadcastInputBegan(self, inputEvent)
			assert(inputEvent ~= nil)
			itemDropEvent:FireServer("itemInputBegan", inputEvent.UserInputType, inputEvent.KeyCode)
		end
		function equippedItem.BroadcastInputEnded(self, inputEvent)
			assert(inputEvent ~= nil)
			itemDropEvent:FireServer("itemInputEnded", inputEvent.UserInputType, inputEvent.KeyCode)
		end
	end
	equippedItemsByPlayer[player] = equippedItem
	if equippedItem.Local then
		for i, pressedInput in ipairs(UserInputService:GetKeysPressed()) do
			equippedItem:InputBegan(pressedInput)
		end
		for i, pressedInput in ipairs(UserInputService:GetMouseButtonsPressed()) do
			if pressedInput.UserInputType ~= Enum.UserInputType.MouseButton1 then
				equippedItem:InputBegan(pressedInput)
			end
		end
	end
	if equippedItem.Local then
		ItemSystem.OnLocalItemEquipped:Fire(equippedItem)
	end
	ItemSystem.onItemEquipped:Fire(equippedItem)
	return equippedItem
end
function ItemSystem._unequip(player)
	assert(player, "missing player")
	local equippedItem = equippedItemsByPlayer[player]
	if equippedItem then
		equippedItem:Destroy()
		equippedItemsByPlayer[player] = nil
		if equippedItem.Local then
			ItemSystem.OnLocalItemUnequipped:Fire()
		end
		return true
	else
		return false
	end
end
return ItemSystem
