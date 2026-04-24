-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Std.Signal)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local PlayerModuleService = require(ReplicatedStorage.PlayerModule.PlayerModuleService)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local t = {
	onJumpPressed = Signal.new(),
	onJumpReleased = Signal.new(),
	jumpButton = {
		primary = true,
		priority = 1000,
		saturateTo = 0,
		image = "rbxassetid://7858404863",
		keyCodes = { Enum.KeyCode.Space, Enum.KeyCode.ButtonA }
	},
	sprintButton = {
		priority = 900,
		image = "rbxassetid://4939735995",
		keyCodes = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonB },
		touchIsToggle = true,
		gamepadIsToggle = true
	},
	crawlButton = {
		priority = 950,
		image = "rbxassetid://4939759147",
		keyCodes = { Enum.KeyCode.C, Enum.KeyCode.Z, Enum.KeyCode.DPadDown },
		allowPassThrough = true
	},
	punchButton = {
		priority = 975,
		image = "rbxassetid://4939740172",
		keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonR2 }
	},
	radioButton = {
		priority = 650,
		image = "rbxassetid://4970993126",
		keyCodes = { Enum.KeyCode.R, Enum.KeyCode.DPadLeft }
	}
}
function t.init(p1)
	function t.jumpButton.onPressed(p1)
		if p1 ~= Enum.UserInputType.Keyboard and p1 ~= Enum.UserInputType.Gamepad1 then
			PlayerModuleService.setIsJumping(true)
		end
		t.onJumpPressed:Fire()
	end
	function t.jumpButton.onReleased()
		PlayerModuleService.setIsJumping(false)
		t.onJumpReleased:Fire()
	end
	ActionButtonService.add(t.jumpButton)
	function t.sprintButton.onPressed()
		p1.setSprinting(true)
	end
	function t.sprintButton.onReleased()
		p1.setSprinting(false)
	end
	ActionButtonService.add(t.sprintButton)
	function t.crawlButton.onPressed()
		p1.attemptToggleCrawling()
	end
	ActionButtonService.add(t.crawlButton)
	function t.punchButton.onPressed()
		p1.attemptPunch()
	end
	ActionButtonService.add(t.punchButton)
	local Radio = require(ReplicatedStorage.Game.Radio.Radio)
	function t.radioButton.onPressed()
		Radio.Toggle()
	end
	ActionButtonService.add(t.radioButton)
	local function updatePunchVisibility(p1)
		local v1 = VehicleUtils.GetLocalVehiclePacket() ~= nil
		ActionButtonService.setButtonEnabled(t.punchButton, not v1 and not InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1])
		if p1 then
			ActionButtonService.setButtonPrimary(t.jumpButton, not v1)
		end
	end
	VehicleUtils.OnVehicleEntered:Connect(updatePunchVisibility)
	VehicleUtils.OnVehicleExited:Connect(updatePunchVisibility)
	local function handleItem(p1)
		p1._maid:GiveTask(p1:GetEquippedSignal():Connect(function()
			if p1:GetOwner() == Players.LocalPlayer then
				local v1 = VehicleUtils.GetLocalVehiclePacket() ~= nil
				ActionButtonService.setButtonEnabled(t.punchButton, not v1 and not InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1])
			end
		end))
		if p1:GetOwner() == Players.LocalPlayer then
			p1._maid:GiveTask(function()
				local v1 = VehicleUtils.GetLocalVehiclePacket() ~= nil
				ActionButtonService.setButtonEnabled(t.punchButton, not v1 and not InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1])
			end)
		end
	end
	for v1, v2 in InventoryItemBinder:GetAll() do
		handleItem(v2)
	end
	InventoryItemBinder:GetClassAddedSignal():Connect(handleItem)
	local v3 = VehicleUtils.GetLocalVehiclePacket() ~= nil
	ActionButtonService.setButtonEnabled(t.punchButton, not v3 and not InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1])
end
return t
