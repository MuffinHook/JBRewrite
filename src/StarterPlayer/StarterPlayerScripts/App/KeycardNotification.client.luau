-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local v1 = nil
local isEnabled = false
local isEnabled = false
v1 = InventoryItemBinder:GetClassAddedSignal():Connect(function(p1)
	if isEnabled or (p1:GetOwner() ~= Players.LocalPlayer or p1:GetName() ~= "Key") then
		if not isEnabled and (p1:GetOwner() == Players.LocalPlayer and p1:GetName() == "CrimeKey") then
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
		v1:Disconnect()
	end
end)
