local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), createElement (copy) ]]
	local TeamSelect = require(script.Parent.TeamSelect)
	local v1 = Roact.mount(createElement(TeamSelect, {
		onTeamSelected = function(p1) --[[ Name: onTeamSelected | Line: 10 ]]
			print("team selected!", p1)
		end,
		serverButtons = {
			{
				onClicked = function() --[[ Name: onClicked | Line: 15 ]]
					print("CLICKED")
				end,
				text = "OG JAILBREAK",
				textColor = Color3.fromHex("e88839")
			},
			{
				onClicked = function() --[[ Name: onClicked | Line: 22 ]]
					print("CLICKED")
				end,
				text = "VOICECHAT SERVER"
			},
			{
				onClicked = function() --[[ Name: onClicked | Line: 28 ]]
					print("CLICKED")
				end,
				text = "TRADE WORLD"
			}
		}
	}), p1)
	return function() --[[ Line: 37 | Upvalues: Roact (ref), v1 (copy) ]]
		Roact.unmount(v1)
	end
end