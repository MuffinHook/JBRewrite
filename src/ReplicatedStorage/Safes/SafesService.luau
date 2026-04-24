-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CashBuyUI = require(ReplicatedStorage.Game.CashBuyUI)
local SafesConsts = require(ReplicatedStorage.Safes.SafesConsts)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local store = require(ReplicatedStorage.App.store)
local Audio = require(ReplicatedStorage.Std.Audio)
return {
	init = function(p1)
 local em = p1.em
 waitForChild(ReplicatedStorage, SafesConsts.FIREWORK_FX_REMOTE_NAME):andThen(function(p1)
 p1.OnClientEvent:Connect(function()
 em.l2atqdos(10)
 end)
 end)
 waitForChild(ReplicatedStorage, SafesConsts.SAFE_PURCHASE_REMOTE_NAME):andThen(function(p1)
 p1.OnClientEvent:Connect(function(p1)
 if p1 then
 Audio.ObjectLocal(Players.LocalPlayer, 4977134975, {
 Volume = 0.3
 })
 else
 store:dispatch({
 type = "setSafesOpen",
 value = false
 })
 CashBuyUI.Open()
 end
 end)
 end)
 waitForChild(ReplicatedStorage, SafesConsts.UPDATE_SAFES_INVENTORY_REMOTE_NAME):andThen(function(p1)
 p1.OnClientEvent:Connect(function(p1)
 store:dispatch({
 type = "setSafesInventoryItems",
 itemsOwned = p1
 })
 end)
 end)
	end
}