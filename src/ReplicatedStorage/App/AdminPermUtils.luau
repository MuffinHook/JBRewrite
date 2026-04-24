-- Reviewed by Claude
local RunConsts = require(script.Parent.RunConsts)
local RunUtils = require(script.Parent.RunUtils)
local module = {
	isBadimo = function(p1)
		local UserId = p1.UserId
		return if UserId == 2025110 or UserId == 2837719 then true else UserId == 606723718
	end
}
function module.hasPerms(p1)
	if not p1 then
		warn("Player missing from admin perm function.")
	end
	if RunUtils.isStudio() or p1 and module.isBadimo(p1) then
		return true
	else
		return RunUtils.getEnv() == RunConsts.QA_NAME
	end
end
return module