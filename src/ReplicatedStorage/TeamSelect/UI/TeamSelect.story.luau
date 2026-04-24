-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1)
	local TeamSelect = require(script.Parent.TeamSelect)
	local v1 = Roact.mount(createElement(TeamSelect, {
		onTeamSelected = function(p1)
			print("team selected!", p1)
		end,
		serverButtons = {
			{
				onClicked = function()
					print("CLICKED")
				end,
				text = "OG JAILBREAK",
				textColor = Color3.fromHex("e88839")
			},
			{
				onClicked = function()
					print("CLICKED")
				end,
				text = "VOICECHAT SERVER"
			},
			{
				onClicked = function()
					print("CLICKED")
				end,
				text = "TRADE WORLD"
			}
		}
	}), p1)
	return function()
		Roact.unmount(v1)
	end
end
