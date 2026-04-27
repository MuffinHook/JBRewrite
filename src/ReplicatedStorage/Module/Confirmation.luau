local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Localization = require(ReplicatedStorage.Module.Localization)
local instance = false
local confirmationQueue = {}
local function ProcessQueue()
	if #confirmationQueue > 0 then
		instance = true
		table.remove(confirmationQueue, 1):Hook()
	else
		instance = false
	end
end
local function SelectIfGamepad(button)
	EzUtils.selectIfGamepad(button)
end
local Confirmation = {}
Confirmation.__index = Confirmation
function Confirmation.Init(settings)
	local ConfirmationGui = ReplicatedStorage.StarterGui:FindFirstChild("ConfirmationGui")
	ConfirmationGui.Parent = LocalPlayer.PlayerGui
	Confirmation.Gui = ConfirmationGui
	ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerYes.Button.Message.Text = Localization:FormatByKey("General.Yes")
	ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerNo.Button.Message.Text = Localization:FormatByKey("General.No")
	function settings.em.p4rz6ffg(player, options)
		local confirmationDialog = Confirmation.new(player, options)
		confirmationDialog.OnYes:Connect(function()
			confirmationDialog = nil
		end)
		confirmationDialog.OnNo:Connect(function()
			confirmationDialog = nil
		end)
	end
	GameUtil.OnTeamChanged:Connect(function(newTeam)
		Confirmation.SetColor(Settings.TeamColor[newTeam])
	end)
	Confirmation.SetColor(Settings.TeamColor[GameUtil.Team])
end
function Confirmation.SetColor(teamColor)
	local Gui = Confirmation.Gui
	Gui.Confirmation.Background.ImageColor3 = teamColor
	Gui.Confirmation.Background.ContainerButtons.ContainerYes.Button.ImageColor3 = teamColor
	Gui.Confirmation.Background.ContainerButtons.ContainerNo.Button.ImageColor3 = teamColor
end
function Confirmation.new(messageText, dialogOptions)
	local dialogInstance = {}
	setmetatable(dialogInstance, Confirmation)
	dialogInstance.OptionSingleChoice = if dialogOptions == nil then false else dialogOptions.SingleChoice
	dialogInstance.Maid = Maid.new()
	dialogInstance.OnYes = Signal.new()
	dialogInstance.Maid:GiveTask(dialogInstance.OnYes)
	if not dialogInstance.OptionSingleChoice then
		dialogInstance.OnNo = Signal.new()
		dialogInstance.Maid:GiveTask(dialogInstance.OnNo)
	end
	dialogInstance.Text = messageText
	table.insert(confirmationQueue, dialogInstance)
	if instance == false then
		if #confirmationQueue > 0 then
			instance = true
			table.remove(confirmationQueue, 1):Hook()
			return dialogInstance
		end
		instance = false
	end
	return dialogInstance
end
function Confirmation.Hook(dialogInstance)
	local Gui = Confirmation.Gui
	Gui.Enabled = true
	Gui.Confirmation.Background.ContainerMessage.Message.Text = dialogInstance.Text
	local Button = Gui.Confirmation.Background.ContainerButtons.ContainerYes.Button
	EzUtils.selectIfGamepad(Button)
	dialogInstance.Maid:GiveTask(Button.MouseButton1Down:Connect(function()
		dialogInstance.OnYes:Fire()
		dialogInstance:Destroy()
	end))
	local ContainerNo = Gui.Confirmation.Background.ContainerButtons.ContainerNo
	ContainerNo.Visible = not dialogInstance.OptionSingleChoice
	local NoButton = ContainerNo.Button
	if not dialogInstance.OptionSingleChoice then
		dialogInstance.Maid:GiveTask(NoButton.MouseButton1Down:Connect(function()
			dialogInstance.OnNo:Fire()
			dialogInstance:Destroy()
		end))
	end
end
function Confirmation.Destroy(dialogInstance)
	if dialogInstance.Maid ~= nil then
		Confirmation.Gui.Enabled = false
		dialogInstance.Maid:Destroy()
		dialogInstance.Maid = nil
		if #confirmationQueue > 0 then
			instance = true
			table.remove(confirmationQueue, 1):Hook()
			return
		end
		instance = false
	end
end
return Confirmation
