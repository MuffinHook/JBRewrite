-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local UI = require(ReplicatedStorage.Module.UI)
local Settings = require(ReplicatedStorage.Resource.Settings)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local v1 = nil
local v2 = nil
local v3 = nil
local CircleAction = UI.CircleAction
local lastUpdateTime = 0
local currentCharacter = nil
local drawerData = {}
local function ShowFun(p1)
	local ValidRoot = p1.ValidRoot
	ValidRoot:SetPrimaryPartCFrame(drawerData[ValidRoot.Drawer].Opened)
end
local function HideFun(p1)
	local ValidRoot = p1.ValidRoot
	ValidRoot:SetPrimaryPartCFrame(drawerData[ValidRoot.Drawer].Closed)
end
local function Update(p1)
	local v1 = tick()
	if not (v1 - lastUpdateTime < 0.1) then
		lastUpdateTime = v1
		local v2 = InventoryItemSystem.getEquippedFor(LocalPlayer)[1]
		local ValidRoot = p1.ValidRoot
		local v3 = currentCharacter
		if v3 then
			v3 = currentCharacter.Model == ValidRoot.Parent.Parent
		end
		local actionDuration
		if v3 then
			local v52 = BinderUtils.findFirstChild(InventoryItemBinder, ValidRoot)
			if v2 then
				if v52 then
					p1.Name = ("Replace %s with %s"):format(v52:GetName(), v2:GetName())
				else
					p1.Name = ("Store %s"):format(v2:GetName())
				end
			elseif v52 then
				p1.Name = ("Take out %s"):format(v52:GetName())
			else
				p1.Name = "Inspect Drawer"
			end
			actionDuration = 0.5
		else
			p1.Name = "Inspect Drawer"
			actionDuration = 3
		end
		assert(actionDuration)
		p1.Duration = actionDuration
	end
end
local function Action(p1, p2)
	if p2 then
		local v1 = InventoryItemSystem.getEquippedFor(LocalPlayer)[1]
		local ValidRoot = p1.ValidRoot
		local v22 = currentCharacter
		if v22 then
			v22 = currentCharacter.Model == ValidRoot.Parent.Parent
		end
		if v22 then
			local v3 = BinderUtils.findFirstChild(InventoryItemBinder, ValidRoot)
			if v1 then
				v2:FireServer("e" .. ("toq2s"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("z58gxgqjb"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("e1ax"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("k45p4la3y"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "io", ValidRoot, v1.obj)
			elseif v3 then
				v2:FireServer("l" .. ("c18xqfs"):sub(3, 4):reverse() .. "" .. "" .. ("ekbeg"):sub(2, 4):reverse():reverse():reverse() .. "" .. "" .. ("sfcvqbwg9"):sub(5, 5):reverse() .. "c", ValidRoot)
			end
		else
			v2:FireServer("b" .. "" .. ("jp0yh"):sub(3, 3):reverse():reverse():reverse() .. "" .. "" .. ("t46s1s13"):sub(3, 5):reverse() .. "" .. "" .. ("tw3g3"):sub(2, 3):reverse():reverse():reverse() .. "c", ValidRoot)
		end
		return true
	end
end
local function AddedFun(p1)
	CircleAction.Add({
		Part = p1.Parent.Handle,
		WorldPosition = p1.Parent.Handle.Position,
		ValidRoot = p1.Parent,
		Name = "Inspect Drawer",
		Timed = true,
		Duration = 1,
		Dist = 5,
		Callback = Action,
		Update = Update,
		ShowFun = ShowFun,
		HideFun = HideFun
	}, p1)
	drawerData[p1] = {
		Closed = p1.CFrame,
		Opened = p1.CFrame * CFrame.new(0, 0, -1.5)
	}
end
local function RemovedFun(p1)
	drawerData[p1] = nil
	CircleAction.Remove(p1)
end
return {
	Init = function(p1)
		v1 = p1.Inventory
		local em = p1.em
		v2 = p1.Event
		v3 = em
		local ScreenGui = p1.ScreenGui
		function em.aa02dq4j(p1)
			assert(p1)
			currentCharacter = p1
		end
		local v22 = 0
		function em.fwrmzn28()
			local v1 = v22 + 1
			v22 = v1
			local Cell = Settings.Time.Cell
			local CellTime = ScreenGui.CellTime
			CellTime.Time.Text = ("%ds"):format(Cell)
			CellTime.Visible = true
			local v2 = tick()
			while true do
				wait(1)
				if v1 ~= v1 then
					break
				end
				CellTime.Time.Text = ("%ds"):format(Settings.Time.Cell - tick() + v2)
				if Cell <= tick() - v2 and v1 == v1 then
					CellTime.Visible = false
				end
			end
		end
		local v32 = next
		local v4, v52 = CollectionService:GetTagged("StashDrawer")
		for v6, v7 in v32, v4, v52 do
			AddedFun(v7)
		end
		CollectionService:GetInstanceAddedSignal("StashDrawer"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("StashDrawer"):Connect(RemovedFun)
	end
}
