local RunConsts = require(script.Parent.RunConsts)
local RunUtils = require(script.Parent.RunUtils)
local t = {
	isBadimo = function(p1) --[[ Name: isBadimo | Line: 7 ]]
		local UserId = p1.UserId
		return if UserId == 2025110 or UserId == 2837719 then true else UserId == 606723718
	end
}
function t.hasPerms(p1) --[[ Line: 12 | Upvalues: RunUtils (copy), t (copy), RunConsts (copy) ]]
	if not p1 then
		warn("Player missing from admin perm function.")
	end
	if RunUtils.isStudio() or p1 and t.isBadimo(p1) then
		return true
	else
		return RunUtils.getEnv() == RunConsts.QA_NAME
	end
end
return t