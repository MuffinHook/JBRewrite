local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
return {
	init = function()
		local binders = {}
		for i, module in ipairs(script.Parent.Module:GetChildren()) do
			local moduleBinder = Binder.new(module.Name, require(module.Class))
			moduleBinder:Start()
			table.insert(binders, moduleBinder)
		end
	end
}
