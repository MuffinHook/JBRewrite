-- Reviewed by Claude
local Players = game:GetService("Players")
return {
	getHacker = function(p1)
		local v1 = p1:GetAttribute("VaultHackerId")
		if v1 then
			return Players:GetPlayerByUserId(v1)
		else
			return nil
		end
	end,
	setHacker = function(p1, p2)
		p1:SetAttribute("VaultHackerId", if p2 then p2.UserId else nil)
	end,
	getHackerChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal("VaultHackerId")
	end,
	getDirection = function(p1)
		return p1:GetAttribute("VaultDirection")
	end,
	setDirection = function(p1, p2)
		p1:SetAttribute("VaultDirection", p2)
	end,
	getDirectionChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal("VaultDirection")
	end,
	getDisabled = function(p1)
		return p1:GetAttribute("VaultDisabled")
	end,
	setDisabled = function(p1, p2)
		p1:SetAttribute("VaultDisabled", p2)
	end
}