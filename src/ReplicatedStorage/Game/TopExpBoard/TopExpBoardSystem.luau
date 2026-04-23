local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local TopExpBoardConsts = require(script.Parent.TopExpBoardConsts)
return {
	init = function() --[[ Name: init | Line: 7 | Upvalues: Binder (copy), TopExpBoardConsts (copy) ]]
		Binder.new(TopExpBoardConsts.TAG_NAME, require(script.Parent.TopExpBoard)):Start()
	end
}