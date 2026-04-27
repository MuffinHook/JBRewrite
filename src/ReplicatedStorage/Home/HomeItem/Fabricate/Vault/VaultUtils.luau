local VaultConsts = require(script.Parent.VaultConsts)
local function validateObj(vaultInstance)
	assert(vaultInstance ~= nil)
	assert(vaultInstance:IsA("Instance"))
end
return {
	getArmingTeamId = function(vaultInstance)
		assert(vaultInstance ~= nil)
		assert(vaultInstance:IsA("Instance"))
		return vaultInstance:GetAttribute(VaultConsts.ARMING_TEAM_ID_ATTR_NAME)
	end,
	setArmingTeamId = function(vaultInstance, teamId)
		assert(vaultInstance ~= nil)
		assert(vaultInstance:IsA("Instance"))
		vaultInstance:SetAttribute(VaultConsts.ARMING_TEAM_ID_ATTR_NAME, teamId)
	end
}
