-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local Runtime = require(script.Parent.Runtime)
	function v1.init(p1)
		p1._maid = Maid.new()
		p1._maid:GiveTask(ActionButtonService.add({
			primary = true,
			priority = 1000,
			saturateTo = 0,
			useEvery = 5,
			title = "drive",
			image = "rbxassetid://7858765663",
			keyCodes = { Enum.KeyCode.W, Enum.KeyCode.Up },
			onPressed = function()
				print("asdf")
				return true
			end,
			onReleased = function()  end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			primary = true,
			priority = 700,
			saturateTo = 0,
			title = "brake",
			image = "rbxassetid://7858764373",
			keyCodes = { Enum.KeyCode.S, Enum.KeyCode.Down },
			onPressed = function()
				print("asdf2")
			end,
			onReleased = function()  end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			priority = 900,
			image = "rbxassetid://4939735995",
			keyCodes = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonB },
			touchIsToggle = true,
			gamepadIsToggle = true,
			onPressed = function()  end,
			onReleased = function()  end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			priority = 950,
			image = "rbxassetid://4939759147",
			useEvery = 5,
			keyCodes = { Enum.KeyCode.C, Enum.KeyCode.Z, Enum.KeyCode.ButtonL3 },
			allowPassThrough = true,
			onPressed = function()
				return true
			end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			priority = 975,
			image = "rbxassetid://4939740172",
			keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonR2 },
			onPressed = function()  end
		}))
		p1._maid:GiveTask(ActionButtonService.add({
			priority = 650,
			image = "rbxassetid://4970993126",
			keyCodes = { Enum.KeyCode.R },
			onPressed = function()  end
		}))
	end
	function v1.render(p1)
		return Roact.createElement(Runtime, {
			enabled = true,
			color = Color3.new(255/255, 0/255, 0/255),
			DEBUG_forceRadial = true
		})
	end
	function v1.willUnmount(p1)
		p1._maid:Destroy()
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
