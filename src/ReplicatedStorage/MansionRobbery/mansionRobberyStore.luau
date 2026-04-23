local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
return Rodux.Store.new(Rodux.combineReducers({
	dialogueText = require(ReplicatedStorage.MansionRobbery.UI.dialogueTextReducer)
}))