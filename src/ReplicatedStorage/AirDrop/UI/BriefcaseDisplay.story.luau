-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
return function(target)
	local StoryApp = Roact.Component:extend("App")
	local BriefcaseDisplay = require(script.Parent.BriefcaseDisplay)
	function StoryApp.render(self)
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
	function StoryApp.willUnmount(self)end
	local storyHandle = Roact.mount(Roact.createElement(StoryApp), target)
	return function()
		Roact.unmount(storyHandle)
	end
end
