-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local Rodux = require(ReplicatedStorage.Rodux)
local Players = game:GetService("Players")
return Rodux.createReducer({
	selectedPlayer = Players.LocalPlayer,
	allPlayers = {}
}, {
	setInventoryPlayers = function(state, action)
		assert(action.allPlayers ~= nil, "missing allPlayers")
		return {
			selectedPlayer = state.selectedPlayer,
			allPlayers = action.allPlayers
		}
	end,
	setInventoryPlayer = function(state, action)
		assert(action.selectedPlayer ~= nil, "missing selectedPlayer")
		ReplicatedStorage:FindFirstChild(TradeConsts.UPDATE_INVENTORY_PLAYER_REMOTE_NAME):FireServer(action.selectedPlayer, true)
		return {
			allPlayers = state.allPlayers,
			selectedPlayer = action.selectedPlayer
		}
	end
})
