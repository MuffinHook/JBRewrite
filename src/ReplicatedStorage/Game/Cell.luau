local LocalPlayer = game:GetService("Players").LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local UI = require(ReplicatedStorage.Module.UI)
local Settings = require(ReplicatedStorage.Resource.Settings)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local InventoryModule = nil
local EventRemote = nil
local EventManager = nil
local CircleAction = UI.CircleAction
local lastUpdateTime = 0
local currentCharacter = nil
local drawerData = {}
local function ShowFun(drawerRoot)
	local ValidRoot = drawerRoot.ValidRoot
	ValidRoot:SetPrimaryPartCFrame(drawerData[ValidRoot.Drawer].Opened)
end
local function HideFun(drawerRoot)
	local ValidRoot = drawerRoot.ValidRoot
	ValidRoot:SetPrimaryPartCFrame(drawerData[ValidRoot.Drawer].Closed)
end
local function Update(drawerRoot)
	local currentTime = tick()
	if not (currentTime - lastUpdateTime < 0.1) then
		lastUpdateTime = currentTime
		local equippedItem = InventoryItemSystem.getEquippedFor(LocalPlayer)[1]
		local ValidRoot = drawerRoot.ValidRoot
		local isCharacterPresent = currentCharacter
		if isCharacterPresent then
			isCharacterPresent = currentCharacter.Model == ValidRoot.Parent.Parent
		end
		local actionDuration
		if isCharacterPresent then
			local drawerItem = BinderUtils.findFirstChild(InventoryItemBinder, ValidRoot)
			if equippedItem then
				if drawerItem then
					drawerRoot.Name = ("Replace %s with %s"):format(drawerItem:GetName(), equippedItem:GetName())
				else
					drawerRoot.Name = ("Store %s"):format(equippedItem:GetName())
				end
			elseif drawerItem then
				drawerRoot.Name = ("Take out %s"):format(drawerItem:GetName())
			else
				drawerRoot.Name = "Inspect Drawer"
			end
			actionDuration = 0.5
		else
			drawerRoot.Name = "Inspect Drawer"
			actionDuration = 3
		end
		assert(actionDuration)
		drawerRoot.Duration = actionDuration
	end
end
local function Action(drawerRoot, isPressed)
	if isPressed then
		local equippedItem = InventoryItemSystem.getEquippedFor(LocalPlayer)[1]
		local ValidRoot = drawerRoot.ValidRoot
		local isCharacterPresent = currentCharacter
		if isCharacterPresent then
			isCharacterPresent = currentCharacter.Model == ValidRoot.Parent.Parent
		end
		if isCharacterPresent then
			local drawerItem = BinderUtils.findFirstChild(InventoryItemBinder, ValidRoot)
			if equippedItem then
				EventRemote:FireServer("stashPlaceItem", ValidRoot, equippedItem.obj)
			elseif drawerItem then
				EventRemote:FireServer("stashGrabItem", ValidRoot)
			end
		else
			EventRemote:FireServer("stashInspectDrawer", ValidRoot)
		end
		return true
	end
	return nil
end
local function AddedFun(drawerInstance)
	CircleAction.Add({
		Part = drawerInstance.Parent.Handle,
		WorldPosition = drawerInstance.Parent.Handle.Position,
		ValidRoot = drawerInstance.Parent,
		Name = "Inspect Drawer",
		Timed = true,
		Duration = 1,
		Dist = 5,
		Callback = Action,
		Update = Update,
		ShowFun = ShowFun,
		HideFun = HideFun
	}, drawerInstance)
	drawerData[drawerInstance] = {
		Closed = drawerInstance.CFrame,
		Opened = drawerInstance.CFrame * CFrame.new(0, 0, -1.5)
	}
end
local function RemovedFun(drawerInstance)
	drawerData[drawerInstance] = nil
	CircleAction.Remove(drawerInstance)
end
return {
	Init = function(initConfig)
		InventoryModule = initConfig.Inventory
		local em = initConfig.em
		EventRemote = initConfig.Event
		EventManager = em
		local ScreenGui = initConfig.ScreenGui
		function em.updateCurrentCharacter(character)
			assert(character)
			currentCharacter = character
		end
		local cellTimerCounter = 0
		function em.startCellCountdown()
			local timerId = cellTimerCounter + 1
			cellTimerCounter = timerId
			local Cell = Settings.Time.Cell
			local CellTime = ScreenGui.CellTime
			CellTime.Time.Text = ("%ds"):format(Cell)
			CellTime.Visible = true
			local startTick = tick()
			while true do
				task.wait(1)
				if timerId ~= timerId then
					break
				end
				CellTime.Time.Text = ("%ds"):format(Settings.Time.Cell - tick() + startTick)
				if Cell <= tick() - startTick and timerId == timerId then
					CellTime.Visible = false
				end
			end
		end
		local nextIterator = next
		local taggedInstances, iteratorState = CollectionService:GetTagged("StashDrawer")
		for _, drawerInstance in nextIterator, taggedInstances, iteratorState do
			AddedFun(drawerInstance)
		end
		CollectionService:GetInstanceAddedSignal("StashDrawer"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("StashDrawer"):Connect(RemovedFun)
	end
}
