local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local v1 = nil
local v2 = false
local v3 = false
v1 = InventoryItemBinder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 9 | Upvalues: v2 (ref), Players (copy), Notification (copy), v3 (ref), v1 (ref) ]]
	if v2 or (p1:GetOwner() ~= Players.LocalPlayer or p1:GetName() ~= "Key") then
		if not v3 and (p1:GetOwner() == Players.LocalPlayer and p1:GetName() == "CrimeKey") then
			Notification.new({
				Text = "This crime card grants you access into Criminal Bases!"
			})
			v3 = true
		end
	else
		Notification.new({
			Text = "This keycard grants you access into Police doors and Bank vaults!"
		})
		v2 = true
	end
	if v2 and v3 then
		v1:Disconnect()
	end
end)