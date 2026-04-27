local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(parentElement)
	local TeamSelect = require(script.Parent.TeamSelect)
	local mountedComponent = Roact.mount(createElement(TeamSelect, {
		onTeamSelected = function(selectedTeam)
			print("team selected!", selectedTeam)
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
	}), parentElement)
	return function()
		Roact.unmount(mountedComponent)
	end
end
