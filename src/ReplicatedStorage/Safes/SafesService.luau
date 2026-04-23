local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CashBuyUI = require(ReplicatedStorage.Game.CashBuyUI)
local SafesConsts = require(ReplicatedStorage.Safes.SafesConsts)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local store = require(ReplicatedStorage.App.store)
local Audio = require(ReplicatedStorage.Std.Audio)
return {
	init = function(p1) --[[ Name: init | Line: 11 | Upvalues: waitForChild (copy), ReplicatedStorage (copy), SafesConsts (copy), Audio (copy), Players (copy), store (copy), CashBuyUI (copy) ]]
		local em = p1.em
		waitForChild(ReplicatedStorage, SafesConsts.FIREWORK_FX_REMOTE_NAME):andThen(function(p1) --[[ Line: 13 | Upvalues: em (copy) ]]
			p1.OnClientEvent:Connect(function() --[[ Line: 14 | Upvalues: em (ref) ]]
				em.l2atqdos(10)
			end)
		end)
		waitForChild(ReplicatedStorage, SafesConsts.SAFE_PURCHASE_REMOTE_NAME):andThen(function(p1) --[[ Line: 19 | Upvalues: Audio (ref), Players (ref), store (ref), CashBuyUI (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 20 | Upvalues: Audio (ref), Players (ref), store (ref), CashBuyUI (ref) ]]
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
		waitForChild(ReplicatedStorage, SafesConsts.UPDATE_SAFES_INVENTORY_REMOTE_NAME):andThen(function(p1) --[[ Line: 35 | Upvalues: store (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 36 | Upvalues: store (ref) ]]
				store:dispatch({
					type = "setSafesInventoryItems",
					itemsOwned = p1
				})
			end)
		end)
	end
}