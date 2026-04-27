local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local keycardConnection = nil
local isEnabled = false
local isEnabled = false
keycardConnection = InventoryItemBinder:GetClassAddedSignal():Connect(function(inventoryItem)
	if isEnabled or (inventoryItem:GetOwner() ~= Players.LocalPlayer or inventoryItem:GetName() ~= "Key") then
		if not isEnabled and (inventoryItem:GetOwner() == Players.LocalPlayer and inventoryItem:GetName() == "CrimeKey") then
			Notification.new({
				Text = "This crime card grants you access into Criminal Bases!"
			})
			isEnabled = true
		end
	else
		Notification.new({
			Text = "This keycard grants you access into Police doors and Bank vaults!"
		})
		isEnabled = true
	end
	if isEnabled and isEnabled then
		keycardConnection:Disconnect()
	end
end)
