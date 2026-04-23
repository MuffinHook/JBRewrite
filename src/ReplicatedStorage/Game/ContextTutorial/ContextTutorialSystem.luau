local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
return {
	init = function() --[[ Name: init | Line: 5 | Upvalues: Binder (copy) ]]
		local t = {}
		for i, v in ipairs(script.Parent.Module:GetChildren()) do
			local v1 = Binder.new(v.Name, require(v.Class))
			v1:Start()
			table.insert(t, v1)
		end
	end
}