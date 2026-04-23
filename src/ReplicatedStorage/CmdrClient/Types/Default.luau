local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CmdrPermission = require(ReplicatedStorage.CmdrExt.CmdrPermission)
return function(p1) --[[ Line: 5 | Upvalues: CmdrPermission (copy) ]]
	p1:RegisterHook("BeforeRun", function(p1) --[[ Line: 6 | Upvalues: CmdrPermission (ref) ]]
		if not CmdrPermission.groupAllowed(p1.Executor, p1.Group) then
			return "You don\'t have permission to run this command"
		end
	end)
end