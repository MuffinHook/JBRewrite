local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
return function(p1) --[[ Line: 6 | Upvalues: Roact (copy), Maid (copy), ActionButtonService (copy) ]]
	local v1 = Roact.Component:extend("App")
	local Runtime = require(script.Parent.Runtime)
	function v1.init(p1) --[[ Line: 10 | Upvalues: Maid (ref), ActionButtonService (ref) ]]
		p1._maid = Maid.new()
		p1._maid:GiveTask(ActionButtonService.add({
			primary = true,
			priority = 1000,
			saturateTo = 0,
			useEvery = 5,
			title = "drive",
			image = "rbxassetid://7858765663",
			keyCodes = { Enum.KeyCode.W, Enum.KeyCode.Up },
			onPressed = function() --[[ Name: onPressed | Line: 20 ]]
				print("asdf")
				return true
			end,
			onReleased = function() --[[ Name: onReleased | Line: 24 ]] end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			primary = true,
			priority = 700,
			saturateTo = 0,
			title = "brake",
			image = "rbxassetid://7858764373",
			keyCodes = { Enum.KeyCode.S, Enum.KeyCode.Down },
			onPressed = function() --[[ Name: onPressed | Line: 33 ]]
				print("asdf2")
			end,
			onReleased = function() --[[ Name: onReleased | Line: 36 ]] end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			priority = 900,
			image = "rbxassetid://4939735995",
			keyCodes = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonB },
			touchIsToggle = true,
			gamepadIsToggle = true,
			onPressed = function() --[[ Name: onPressed | Line: 45 ]] end,
			onReleased = function() --[[ Name: onReleased | Line: 46 ]] end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			priority = 950,
			image = "rbxassetid://4939759147",
			useEvery = 5,
			keyCodes = { Enum.KeyCode.C, Enum.KeyCode.Z, Enum.KeyCode.ButtonL3 },
			allowPassThrough = true,
			onPressed = function() --[[ Name: onPressed | Line: 57 ]]
				return true
			end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			priority = 975,
			image = "rbxassetid://4939740172",
			keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonR2 },
			onPressed = function() --[[ Name: onPressed | Line: 67 ]] end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			priority = 650,
			image = "rbxassetid://4970993126",
			keyCodes = { Enum.KeyCode.R },
			onPressed = function() --[[ Name: onPressed | Line: 75 ]] end
		}))
	end
	function v1.render(p1) --[[ Line: 79 | Upvalues: Roact (ref), Runtime (copy) ]]
		return Roact.createElement(Runtime, {
			enabled = true,
			color = Color3.new(255/255, 0/255, 0/255),
			DEBUG_forceRadial = true
		})
	end
	function v1.willUnmount(p1) --[[ Line: 86 ]]
		p1._maid:Destroy()
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 91 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end