local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), EnumRarity (copy) ]]
	local v1 = Roact.Component:extend("App")
	local BriefcaseDisplay = require(script.Parent.BriefcaseDisplay)
	function v1.render(p1) --[[ Line: 8 | Upvalues: Roact (ref), BriefcaseDisplay (copy), EnumRarity (ref) ]]
		return Roact.createElement(BriefcaseDisplay, {
			probs = {
				[EnumRarity.Common] = 75,
				[EnumRarity.Rare] = 20,
				[EnumRarity.UltraRare] = 5,
				[EnumRarity.Epic] = 0,
				[EnumRarity.Legendary] = 0
			}
		})
	end
	function v1.willUnmount(p1) --[[ Line: 19 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 22 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end