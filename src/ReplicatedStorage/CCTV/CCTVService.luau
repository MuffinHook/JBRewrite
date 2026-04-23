local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local CameraBinder = require(script.Parent.CameraBinder)
local t = {
	onRequestPrompt = Signal.new()
}
function t.init() --[[ Line: 12 | Upvalues: CameraBinder (copy), Binder (copy), Maid (copy), t (copy), CircleAction (copy) ]]
	CameraBinder:Start()
	Binder.new("CCTVPrompt", function(p1) --[[ Line: 15 | Upvalues: Maid (ref), t (ref), CircleAction (ref) ]]
		local v1 = Maid.new()
		CircleAction.Add({
			Part = p1,
			Name = "Open Security Cameras",
			Timed = false,
			Dist = 8,
			Callback = function(p1, p2) --[[ Name: action | Line: 17 | Upvalues: t (ref) ]]
				if p2 then
					t.onRequestPrompt:Fire()
				end
				return true
			end
		}, p1)
		v1:GiveTask(function() --[[ Line: 31 | Upvalues: CircleAction (ref), p1 (copy) ]]
			CircleAction.Remove(p1)
		end)
		return v1
	end):Start()
end
return t