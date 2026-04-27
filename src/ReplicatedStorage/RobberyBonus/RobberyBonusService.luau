local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobberyBonusConsts = require(script.Parent.RobberyBonusConsts)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
return {
	init = function(config)
 local eventManager = config.em
 waitForChild(ReplicatedStorage, RobberyBonusConsts.FIREWORK_FX_REMOTE_NAME):andThen(function(fireworkRemote)
 fireworkRemote.OnClientEvent:Connect(function()
 eventManager.l2atqdos(10)
 end)
 end)
	end
}
