local Players = game:GetService("Players")
return {
	getHacker = function(vaultObject)
		local hackerId = vaultObject:GetAttribute("VaultHackerId")
		if hackerId then
			return Players:GetPlayerByUserId(hackerId)
		else
			return nil
		end
	end,
	setHacker = function(vaultObject, player)
		vaultObject:SetAttribute("VaultHackerId", if player then player.UserId else nil)
	end,
	getHackerChangedSignal = function(vaultObject)
		return vaultObject:GetAttributeChangedSignal("VaultHackerId")
	end,
	getDirection = function(vaultObject)
		return vaultObject:GetAttribute("VaultDirection")
	end,
	setDirection = function(vaultObject, direction)
		vaultObject:SetAttribute("VaultDirection", direction)
	end,
	getDirectionChangedSignal = function(vaultObject)
		return vaultObject:GetAttributeChangedSignal("VaultDirection")
	end,
	getDisabled = function(vaultObject)
		return vaultObject:GetAttribute("VaultDisabled")
	end,
	setDisabled = function(vaultObject, disabled)
		vaultObject:SetAttribute("VaultDisabled", disabled)
	end
}
