local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Std.Signal)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local PlayerModuleService = require(ReplicatedStorage.PlayerModule.PlayerModuleService)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local InventoryItemBinder = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local DefaultActions = {
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
function DefaultActions.init(playerModule)
	function DefaultActions.jumpButton.onPressed(inputType)
		if inputType ~= Enum.UserInputType.Keyboard and inputType ~= Enum.UserInputType.Gamepad1 then
			PlayerModuleService.setIsJumping(true)
		end
		DefaultActions.onJumpPressed:Fire()
	end
	function DefaultActions.jumpButton.onReleased()
		PlayerModuleService.setIsJumping(false)
		DefaultActions.onJumpReleased:Fire()
	end
	ActionButtonService.add(DefaultActions.jumpButton)
	function DefaultActions.sprintButton.onPressed()
		playerModule.setSprinting(true)
	end
	function DefaultActions.sprintButton.onReleased()
		playerModule.setSprinting(false)
	end
	ActionButtonService.add(DefaultActions.sprintButton)
	function DefaultActions.crawlButton.onPressed()
		playerModule.attemptToggleCrawling()
	end
	ActionButtonService.add(DefaultActions.crawlButton)
	function DefaultActions.punchButton.onPressed()
		playerModule.attemptPunch()
	end
	ActionButtonService.add(DefaultActions.punchButton)
	local Radio = require(ReplicatedStorage.Game.Radio.Radio)
	function DefaultActions.radioButton.onPressed()
		Radio.Toggle()
	end
	ActionButtonService.add(DefaultActions.radioButton)
	local function updatePunchVisibility(shouldUpdateJump)
		local isInVehicle = VehicleUtils.GetLocalVehiclePacket() ~= nil
		ActionButtonService.setButtonEnabled(DefaultActions.punchButton, not isInVehicle and not InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1])
		if shouldUpdateJump then
			ActionButtonService.setButtonPrimary(DefaultActions.jumpButton, not isInVehicle)
		end
	end
	VehicleUtils.OnVehicleEntered:Connect(updatePunchVisibility)
	VehicleUtils.OnVehicleExited:Connect(updatePunchVisibility)
	local function handleItem(item)
		item._maid:GiveTask(item:GetEquippedSignal():Connect(function()
			if item:GetOwner() == Players.LocalPlayer then
				local isInVehicle = VehicleUtils.GetLocalVehiclePacket() ~= nil
				ActionButtonService.setButtonEnabled(DefaultActions.punchButton, not isInVehicle and not InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1])
			end
		end))
		if item:GetOwner() == Players.LocalPlayer then
			item._maid:GiveTask(function()
				local isInVehicle = VehicleUtils.GetLocalVehiclePacket() ~= nil
				ActionButtonService.setButtonEnabled(DefaultActions.punchButton, not isInVehicle and not InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1])
			end)
		end
	end
	for itemKey, item in InventoryItemBinder:GetAll() do
		handleItem(item)
	end
	InventoryItemBinder:GetClassAddedSignal():Connect(handleItem)
	local isInVehicle = VehicleUtils.GetLocalVehiclePacket() ~= nil
	ActionButtonService.setButtonEnabled(DefaultActions.punchButton, not isInVehicle and not InventoryItemSystem.getEquippedFor(Players.LocalPlayer)[1])
end
return DefaultActions
