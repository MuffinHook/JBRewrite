-- Reviewed by Claude
-- variables reassigned
local RunConsts = require(script.Parent.RunConsts)
local RunUtils = require(script.Parent.RunUtils)
local module = {
	isBadimo = function(player)
		local playerId = player.UserId
		return if playerId == 2025110 or playerId == 2837719 then true else playerId == 606723718
	end
}
function module.hasPerms(player)
	if not player then
		warn("Player missing from admin perm function.")
	end
	if RunUtils.isStudio() or player and module.isBadimo(player) then
		return true
	else
		return RunUtils.getEnv() == RunConsts.QA_NAME
	end
end
return module