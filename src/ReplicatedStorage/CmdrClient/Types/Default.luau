-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CmdrPermission = require(ReplicatedStorage.CmdrExt.CmdrPermission)
return function(p1)
	p1:RegisterHook("BeforeRun", function(p1)
		if not CmdrPermission.groupAllowed(p1.Executor, p1.Group) then
			return "You don\'t have permission to run this command"
		end
	end)
end
