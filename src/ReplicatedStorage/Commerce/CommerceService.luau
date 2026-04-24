-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
return {
	init = function()
		Binder.new("CommerceNode", function(commerceNode)
			local maid = Maid.new()
			maid:GiveTask(CircleAction.Add({
				Part = commerceNode,
				Name = "Buy",
				NoRay = true,
				Timed = false,
				Dist = 12,
				Callback = function(player, isActivated)
					if isActivated then
						local AttemptBuyRemote = commerceNode:FindFirstChild("AttemptBuyRemote")
						if AttemptBuyRemote then
							AttemptBuyRemote:FireServer()
						end
					end
				end
			}, commerceNode))
			return maid
		end):Start()
	end
}
