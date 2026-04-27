local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CmdrPermission = require(ReplicatedStorage.CmdrExt.CmdrPermission)
return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		if not CmdrPermission.groupAllowed(context.Executor, context.Group) then
			return "You don\'t have permission to run this command"
		end
	end)
end
