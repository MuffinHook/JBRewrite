local ReplicatedStorage = game:GetService("ReplicatedStorage")
local var3_upvw = false
local Players_upvr = game:GetService("Players")
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
local var6_upvw = false
local var7_upvw
var7_upvw = require(ReplicatedStorage.Inventory.InventoryItemBinder):GetClassAddedSignal():Connect(function(arg1) -- Line 9
    if not var3_upvw and arg1:GetOwner() == Players_upvr.LocalPlayer and arg1:GetName() == "Key" then
        Notification_upvr.new({
            Text = "This keycard grants you access into Police doors and Bank vaults!";
        })
        var3_upvw = true
    elseif not var6_upvw and arg1:GetOwner() == Players_upvr.LocalPlayer and arg1:GetName() == "CrimeKey" then
        Notification_upvr.new({
            Text = "This crime card grants you access into Criminal Bases!";
        })
        var6_upvw = true
    end
    if var3_upvw and var6_upvw then
        var7_upvw:Disconnect()
    end
end)