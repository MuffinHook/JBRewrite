-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local TopExpBoardConsts = require(script.Parent.TopExpBoardConsts)
return {
	init = function()
		Binder.new(TopExpBoardConsts.TAG_NAME, require(script.Parent.TopExpBoard)):Start()
	end
}
