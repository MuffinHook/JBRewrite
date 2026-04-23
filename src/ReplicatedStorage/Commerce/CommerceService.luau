local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
return {
	init = function() --[[ Name: init | Line: 8 | Upvalues: Binder (copy), Maid (copy), CircleAction (copy) ]]
		Binder.new("CommerceNode", function(p1) --[[ Line: 9 | Upvalues: Maid (ref), CircleAction (ref) ]]
			local v1 = Maid.new()
			v1:GiveTask(CircleAction.Add({
				Part = p1,
				Name = "Buy",
				NoRay = true,
				Timed = false,
				Dist = 12,
				Callback = function(p12, p2) --[[ Name: action | Line: 12 | Upvalues: p1 (copy) ]]
					if p2 then
						local AttemptBuyRemote = p1:FindFirstChild("AttemptBuyRemote")
						if AttemptBuyRemote then
							AttemptBuyRemote:FireServer()
						end
					end
				end
			}, p1))
			return v1
		end):Start()
	end
}