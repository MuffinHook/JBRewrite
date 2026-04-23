local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
return Rodux.Store.new(Rodux.combineReducers({
	leaderboardInfo = require(ReplicatedStorage.PersistentCrewBattle.Reducer.leaderboardInfoReducer),
	crewsInServerDisplayInfo = require(ReplicatedStorage.PersistentCrewBattle.Reducer.crewsInServerDisplayInfoReducer)
}))