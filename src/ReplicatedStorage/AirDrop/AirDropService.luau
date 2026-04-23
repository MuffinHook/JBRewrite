-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local AirDropConsts = require(ReplicatedStorage.AirDrop.AirDropConsts)
return {
	init = function(p1)
		local em = p1.em
		waitForChild(ReplicatedStorage, AirDropConsts.FIREWORK_FX_REMOTE_NAME):andThen(function(p1)
			p1.OnClientEvent:Connect(function()
				em.l2atqdos(10)
			end)
		end)
	end
}