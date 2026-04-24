-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local AirDropConsts = require(ReplicatedStorage.AirDrop.AirDropConsts)
return {
	init = function(params)
		local effectManager = params.em
		waitForChild(ReplicatedStorage, AirDropConsts.FIREWORK_FX_REMOTE_NAME):andThen(function(fireworkRemote)
			fireworkRemote.OnClientEvent:Connect(function()
				effectManager:playFireworkEffect(10)
			end)
		end)
	end
}
