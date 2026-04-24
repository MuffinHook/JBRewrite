-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Localization = require(ReplicatedStorage.Module.Localization)
local instance = false
local t = {}
local function ProcessQueue()
	if #t > 0 then
		instance = true
		table.remove(t, 1):Hook()
	else
		instance = false
	end
end
local function SelectIfGamepad(p1)
	EzUtils.selectIfGamepad(p1)
end
local t2 = {}
t2.__index = t2
function t2.Init(p1)
	local ConfirmationGui = ReplicatedStorage.StarterGui:FindFirstChild("ConfirmationGui")
	ConfirmationGui.Parent = LocalPlayer.PlayerGui
	t2.Gui = ConfirmationGui
	ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerYes.Button.Message.Text = Localization:FormatByKey("General.Yes")
	ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerNo.Button.Message.Text = Localization:FormatByKey("General.No")
	function p1.em.p4rz6ffg(p1, p2)
		local instance = t2.new(p1, p2)
		instance.OnYes:Connect(function()
			instance = nil
		end)
		instance.OnNo:Connect(function()
			instance = nil
		end)
	end
	GameUtil.OnTeamChanged:Connect(function(p1)
		t2.SetColor(Settings.TeamColor[p1])
	end)
	t2.SetColor(Settings.TeamColor[GameUtil.Team])
end
function t2.SetColor(p1)
	local Gui = t2.Gui
	Gui.Confirmation.Background.ImageColor3 = p1
	Gui.Confirmation.Background.ContainerButtons.ContainerYes.Button.ImageColor3 = p1
	Gui.Confirmation.Background.ContainerButtons.ContainerNo.Button.ImageColor3 = p1
end
function t2.new(p1, p2)
	local t3 = {}
	setmetatable(t3, t2)
	t3.OptionSingleChoice = if p2 == nil then false else p2.SingleChoice
	t3.Maid = Maid.new()
	t3.OnYes = Signal.new()
	t3.Maid:GiveTask(t3.OnYes)
	if not t3.OptionSingleChoice then
		t3.OnNo = Signal.new()
		t3.Maid:GiveTask(t3.OnNo)
	end
	t3.Text = p1
	table.insert(t, t3)
	if instance == false then
		if #t > 0 then
			instance = true
			table.remove(t, 1):Hook()
			return t3
		end
		instance = false
	end
	return t3
end
function t2.Hook(p1)
	local Gui = t2.Gui
	Gui.Enabled = true
	Gui.Confirmation.Background.ContainerMessage.Message.Text = p1.Text
	local Button = Gui.Confirmation.Background.ContainerButtons.ContainerYes.Button
	EzUtils.selectIfGamepad(Button)
	p1.Maid:GiveTask(Button.MouseButton1Down:Connect(function()
		p1.OnYes:Fire()
		p1:Destroy()
	end))
	local ContainerNo = Gui.Confirmation.Background.ContainerButtons.ContainerNo
	ContainerNo.Visible = not p1.OptionSingleChoice
	local Button_2 = ContainerNo.Button
	if not p1.OptionSingleChoice then
		p1.Maid:GiveTask(Button_2.MouseButton1Down:Connect(function()
			p1.OnNo:Fire()
			p1:Destroy()
		end))
	end
end
function t2.Destroy(p1)
	if p1.Maid ~= nil then
		t2.Gui.Enabled = false
		p1.Maid:Destroy()
		p1.Maid = nil
		if #t > 0 then
			instance = true
			table.remove(t, 1):Hook()
			return
		end
		instance = false
	end
end
return t2
