-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local Rodux = require(ReplicatedStorage.Rodux)
local Players = game:GetService("Players")
return Rodux.createReducer({
	selectedPlayer = Players.LocalPlayer,
	allPlayers = {}
}, {
	setInventoryPlayers = function(p1, p2)
		assert(p2.allPlayers ~= nil, "missing allPlayers")
		return {
			selectedPlayer = p1.selectedPlayer,
			allPlayers = p2.allPlayers
		}
	end,
	setInventoryPlayer = function(p1, p2)
		assert(p2.selectedPlayer ~= nil, "missing selectedPlayer")
		ReplicatedStorage:FindFirstChild(TradeConsts.UPDATE_INVENTORY_PLAYER_REMOTE_NAME):FireServer(p2.selectedPlayer, true)
		return {
			allPlayers = p1.allPlayers,
			selectedPlayer = p2.selectedPlayer
		}
	end
})
