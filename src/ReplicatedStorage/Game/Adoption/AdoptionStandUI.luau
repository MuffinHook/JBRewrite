-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Window = require(ReplicatedStorage.Module.Window.Window)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Format = require(ReplicatedStorage.Module.Format)
local Interval = require(ReplicatedStorage.Std.Interval)
local Settings = require(ReplicatedStorage.Resource.Settings)
local dogNames = {
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
local module = {}
function module.init()
	local AdoptionStandGui = ReplicatedStorage.StarterGui:FindFirstChild("AdoptionStandGui")
	AdoptionStandGui.Parent = LocalPlayer.PlayerGui
	module.gui = AdoptionStandGui
	local window = Window.new()
	window:GetOnOpenedSignal():Connect(module._open)
	window:GetOnClosedSignal():Connect(module._close)
	module._window = window
	GameUtil.getCenterWindowGroup():Add(window)
end
function module.setTitle(title)
	assert(title ~= nil)
	module.gui.Container.Right.Title.TextLabel.Text = title
end
function module.setImageId(imageId)
	assert(imageId ~= nil)
	module.gui.Container.Left.Icon.ImageLabel.Image = ("rbxassetid://%d"):format(imageId)
end
function module.setPrice(price)
	module.gui.Container.Right.Price.TextLabel.Text = if price == nil then "FREE" else Format.Currency(price) or "FREE"
end
function module.setFirstAdopt(isFirstAdopt)
	assert(isFirstAdopt ~= nil)
	assert(type(isFirstAdopt) == "boolean")
	module.gui.Container.Right.Adopt.TextLabel.Text = if isFirstAdopt then "ADOPT" else "RE-ADOPT"
end
function module.setDescriptionTeam(teamId)
	local teamName = nil
	if teamId == Settings.EnumTeam.Criminal then
		teamName = "criminal"
	elseif teamId == Settings.EnumTeam.Police then
		teamName = "police"
	else
		error("Invalid teamId for `setDescriptionTeam`")
	end
	module.gui.Container.Right.Description.TextLabel.Text = ("This breed does more damage when playing on the %s team!"):format(teamName)
end
function module.getName()
	local TextBox = module.gui.Container.Left.DogName.TextBox
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
function module.setName(name)
	module.gui.Container.Left.DogName.TextBox.Text = name
end
function module._open()
	assert(module._maid == nil)
	local maid = Maid.new()
	module._maid = maid
	local gui = module.gui
	gui.Enabled = true
	maid:GiveTask(function()
		gui.Enabled = false
	end)
	local TextBox = gui.Container.Left.DogName.TextBox
	maid:GiveTask(TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		local Text = TextBox.Text
		if #Text > 10 then
			Text = Text:sub(1, 10)
		end
		TextBox.Text = Text
	end))
	local randomDogName = dogNames[math.random(1, #dogNames)]
	local dotCount = 0
	maid:GiveTask(Interval.every(0.5):Connect(function()
		dotCount = dotCount % 3 + 1
		TextBox.PlaceholderText = ("%s%s"):format(randomDogName, ("."):rep(dotCount))
	end))
	maid:GiveTask(gui.Container.Close.MouseButton1Down:Connect(function()
		module.close()
	end))
end
function module._close()
	assert(module._maid ~= nil)
	local _maid = module._maid
	module._maid = nil
	_maid:Destroy()
end
function module.open()
	module._window:Open()
end
function module.close()
	module._window:Close()
end
function module.isOpen()
	return module._window:IsOpen()
end
function module.getOnClosedSignal()
	return module._window:GetOnClosedSignal()
end
function module.getOnClickAdoptSignal()
	return module.gui.Container.Right.Adopt.MouseButton1Down
end
return module
