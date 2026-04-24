-- Reviewed by Claude
local VaultConsts = require(script.Parent.VaultConsts)
local function validateObj(p1)
	assert(p1 ~= nil)
	assert(p1:IsA("Instance"))
end
return {
	getArmingTeamId = function(p1)
		assert(p1 ~= nil)
		assert(p1:IsA("Instance"))
		return p1:GetAttribute(VaultConsts.ARMING_TEAM_ID_ATTR_NAME)
	end,
	setArmingTeamId = function(p1, p2)
		assert(p1 ~= nil)
		assert(p1:IsA("Instance"))
		p1:SetAttribute(VaultConsts.ARMING_TEAM_ID_ATTR_NAME, p2)
	end
}
