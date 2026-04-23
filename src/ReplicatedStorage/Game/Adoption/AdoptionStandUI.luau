local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Window = require(ReplicatedStorage.Module.Window.Window)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Format = require(ReplicatedStorage.Module.Format)
local Interval = require(ReplicatedStorage.Std.Interval)
local Settings = require(ReplicatedStorage.Resource.Settings)
local t = {
	"ACE",
	"RACER",
	"HENRY",
	"HARLEY",
	"ROMEO",
	"DAVE",
	"MAX",
	"ZEUS",
	"SCOOTER",
	"RUFUS",
	"OREO",
	"OSCAR",
	"ATHENA",
	"DAISY",
	"COCO",
	"LILY",
	"OLIVE",
	"WILLOW",
	"SIERRA",
	"MISTY",
	"LUCY",
	"LACEY",
	"GRACIE",
	"MOLLY"
}
local t2 = {}
function t2.init() --[[ Line: 40 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t2 (copy), Window (copy), GameUtil (copy) ]]
	local AdoptionStandGui = ReplicatedStorage.StarterGui:FindFirstChild("AdoptionStandGui")
	AdoptionStandGui.Parent = LocalPlayer.PlayerGui
	t2.gui = AdoptionStandGui
	local v1 = Window.new()
	v1:GetOnOpenedSignal():Connect(t2._open)
	v1:GetOnClosedSignal():Connect(t2._close)
	t2._window = v1
	GameUtil.getCenterWindowGroup():Add(v1)
end
function t2.setTitle(p1) --[[ Line: 51 | Upvalues: t2 (copy) ]]
	assert(p1 ~= nil)
	t2.gui.Container.Right.Title.TextLabel.Text = p1
end
function t2.setImageId(p1) --[[ Line: 57 | Upvalues: t2 (copy) ]]
	assert(p1 ~= nil)
	t2.gui.Container.Left.Icon.ImageLabel.Image = ("rbxassetid://%d"):format(p1)
end
function t2.setPrice(p1) --[[ Line: 63 | Upvalues: t2 (copy), Format (copy) ]]
	t2.gui.Container.Right.Price.TextLabel.Text = if p1 == nil then "FREE" else Format.Currency(p1) or "FREE"
end
function t2.setFirstAdopt(p1) --[[ Line: 68 | Upvalues: t2 (copy) ]]
	assert(p1 ~= nil)
	assert(type(p1) == "boolean")
	t2.gui.Container.Right.Adopt.TextLabel.Text = if p1 then "ADOPT" else "RE-ADOPT"
end
function t2.setDescriptionTeam(p1) --[[ Line: 76 | Upvalues: Settings (copy), t2 (copy) ]]
	local v1 = nil
	if p1 == Settings.EnumTeam.Criminal then
		v1 = "criminal"
	elseif p1 == Settings.EnumTeam.Police then
		v1 = "police"
	else
		error("Invalid teamId for `setDescriptionTeam`")
	end
	t2.gui.Container.Right.Description.TextLabel.Text = ("This breed does more damage when playing on the %s team!"):format(v1)
end
function t2.getName() --[[ Line: 89 | Upvalues: t2 (copy) ]]
	local TextBox = t2.gui.Container.Left.DogName.TextBox
	local Text = TextBox.Text
	if #Text == 0 then
		Text = TextBox.PlaceholderText:match("%w+")
	end
	if #Text == 0 then
		Text = nil
	end
	if Text then
		Text = Text:upper()
	end
	return Text
end
function t2.setName(p1) --[[ Line: 104 | Upvalues: t2 (copy) ]]
	t2.gui.Container.Left.DogName.TextBox.Text = p1
end
function t2._open() --[[ Line: 109 | Upvalues: t2 (copy), Maid (copy), t (copy), Interval (copy) ]]
	assert(t2._maid == nil)
	local v1 = Maid.new()
	t2._maid = v1
	local gui = t2.gui
	gui.Enabled = true
	v1:GiveTask(function() --[[ Line: 116 | Upvalues: gui (copy) ]]
		gui.Enabled = false
	end)
	local TextBox = gui.Container.Left.DogName.TextBox
	v1:GiveTask(TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 121 | Upvalues: TextBox (copy) ]]
		local Text = TextBox.Text
		if #Text > 10 then
			Text = Text:sub(1, 10)
		end
		TextBox.Text = Text
	end))
	local v2 = t[math.random(1, #t)]
	local v3 = 0
	v1:GiveTask(Interval.every(0.5):Connect(function() --[[ Line: 130 | Upvalues: v3 (ref), TextBox (copy), v2 (copy) ]]
		v3 = v3 % 3 + 1
		TextBox.PlaceholderText = ("%s%s"):format(v2, ("."):rep(v3))
	end))
	v1:GiveTask(gui.Container.Close.MouseButton1Down:Connect(function() --[[ Line: 135 | Upvalues: t2 (ref) ]]
		t2.close()
	end))
end
function t2._close() --[[ Line: 139 | Upvalues: t2 (copy) ]]
	assert(t2._maid ~= nil)
	local _maid = t2._maid
	t2._maid = nil
	_maid:Destroy()
end
function t2.open() --[[ Line: 145 | Upvalues: t2 (copy) ]]
	t2._window:Open()
end
function t2.close() --[[ Line: 148 | Upvalues: t2 (copy) ]]
	t2._window:Close()
end
function t2.isOpen() --[[ Line: 151 | Upvalues: t2 (copy) ]]
	return t2._window:IsOpen()
end
function t2.getOnClosedSignal() --[[ Line: 154 | Upvalues: t2 (copy) ]]
	return t2._window:GetOnClosedSignal()
end
function t2.getOnClickAdoptSignal() --[[ Line: 157 | Upvalues: t2 (copy) ]]
	return t2.gui.Container.Right.Adopt.MouseButton1Down
end
return t2