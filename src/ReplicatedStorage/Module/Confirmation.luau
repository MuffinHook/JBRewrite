local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Localization = require(ReplicatedStorage.Module.Localization)
local v1 = false
local t = {}
local function ProcessQueue() --[[ Line: 16 | Upvalues: t (copy), v1 (ref) ]]
	if #t > 0 then
		v1 = true
		table.remove(t, 1):Hook()
	else
		v1 = false
	end
end
local function SelectIfGamepad(p1) --[[ Line: 26 | Upvalues: EzUtils (copy) ]]
	EzUtils.selectIfGamepad(p1)
end
local t2 = {}
t2.__index = t2
function t2.Init(p1) --[[ Line: 32 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t2 (copy), Localization (copy), GameUtil (copy), Settings (copy) ]]
	local ConfirmationGui = ReplicatedStorage.StarterGui:FindFirstChild("ConfirmationGui")
	ConfirmationGui.Parent = LocalPlayer.PlayerGui
	t2.Gui = ConfirmationGui
	ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerYes.Button.Message.Text = Localization:FormatByKey("General.Yes")
	ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerNo.Button.Message.Text = Localization:FormatByKey("General.No")
	function p1.em.p4rz6ffg(p1, p2) --[[ Line: 43 | Upvalues: t2 (ref) ]]
		local v1 = t2.new(p1, p2)
		v1.OnYes:Connect(function() --[[ Line: 46 | Upvalues: v1 (ref) ]]
			v1 = nil
		end)
		v1.OnNo:Connect(function() --[[ Line: 49 | Upvalues: v1 (ref) ]]
			v1 = nil
		end)
	end
	GameUtil.OnTeamChanged:Connect(function(p1) --[[ Line: 54 | Upvalues: Settings (ref), t2 (ref) ]]
		t2.SetColor(Settings.TeamColor[p1])
	end)
	t2.SetColor(Settings.TeamColor[GameUtil.Team])
end
function t2.SetColor(p1) --[[ Line: 61 | Upvalues: t2 (copy) ]]
	local Gui = t2.Gui
	Gui.Confirmation.Background.ImageColor3 = p1
	Gui.Confirmation.Background.ContainerButtons.ContainerYes.Button.ImageColor3 = p1
	Gui.Confirmation.Background.ContainerButtons.ContainerNo.Button.ImageColor3 = p1
end
function t2.new(p1, p2) --[[ Line: 69 | Upvalues: t2 (copy), Maid (copy), Signal (copy), t (copy), v1 (ref) ]]
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
	if v1 == false then
		if #t > 0 then
			v1 = true
			table.remove(t, 1):Hook()
			return t3
		end
		v1 = false
	end
	return t3
end
function t2.Hook(p1) --[[ Line: 93 | Upvalues: t2 (copy), EzUtils (copy) ]]
	local Gui = t2.Gui
	Gui.Enabled = true
	Gui.Confirmation.Background.ContainerMessage.Message.Text = p1.Text
	local Button = Gui.Confirmation.Background.ContainerButtons.ContainerYes.Button
	EzUtils.selectIfGamepad(Button)
	p1.Maid:GiveTask(Button.MouseButton1Down:Connect(function() --[[ Line: 100 | Upvalues: p1 (copy) ]]
		p1.OnYes:Fire()
		p1:Destroy()
	end))
	local ContainerNo = Gui.Confirmation.Background.ContainerButtons.ContainerNo
	ContainerNo.Visible = not p1.OptionSingleChoice
	local Button_2 = ContainerNo.Button
	if not p1.OptionSingleChoice then
		p1.Maid:GiveTask(Button_2.MouseButton1Down:Connect(function() --[[ Line: 109 | Upvalues: p1 (copy) ]]
			p1.OnNo:Fire()
			p1:Destroy()
		end))
	end
end
function t2.Destroy(p1) --[[ Line: 115 | Upvalues: t2 (copy), t (copy), v1 (ref) ]]
	if p1.Maid ~= nil then
		t2.Gui.Enabled = false
		p1.Maid:Destroy()
		p1.Maid = nil
		if #t > 0 then
			v1 = true
			table.remove(t, 1):Hook()
			return
		end
		v1 = false
	end
end
return t2