-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
return Rodux.Store.new(Rodux.combineReducers({
	groupVisible = require(script.Parent.Reducer.groupVisibleReducer),
	currentClanInfo = require(script.Parent.Reducer.currentClanInfoReducer),
	viewingClanInfo = require(script.Parent.Reducer.viewingClanInfoReducer),
	members = require(script.Parent.Reducer.membersReducer),
	membersOnlineMap = require(script.Parent.Reducer.membersOnlineMapReducer),
	joinRequests = require(script.Parent.Reducer.joinRequestsReducer),
	isReadiedUp = require(script.Parent.Reducer.isReadiedUpReducer),
	networkMutexLocked = require(script.Parent.Reducer.networkMutexLockedReducer),
	battleInvites = require(ReplicatedStorage.PersistentCrewBattle.Reducer.battleInvitesReducer),
	timeTook = require(ReplicatedStorage.PersistentCrewBattle.Reducer.timeTookReducer),
	startedAt = require(ReplicatedStorage.PersistentCrewBattle.Reducer.startedAtReducer),
	isBattleServer = require(ReplicatedStorage.PersistentCrewBattle.Reducer.isBattleServerReducer),
	robberiesCompleted = require(ReplicatedStorage.PersistentCrewBattle.Reducer.robberiesCompletedReducer),
	clanName = require(ReplicatedStorage.PersistentCrewBattle.Reducer.clanNameReducer),
	attackingClanId = require(ReplicatedStorage.PersistentCrewBattle.Reducer.attackingClanIdReducer),
	battleResponseData = require(ReplicatedStorage.PersistentCrewBattle.Reducer.battleResponseDataReducer),
	penalty = require(ReplicatedStorage.PersistentCrewBattle.Reducer.penaltyReducer)
}))
