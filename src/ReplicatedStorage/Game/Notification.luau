local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local TypeWrite = require(ReplicatedStorage.Game.TypeWrite)
require(ReplicatedStorage.Game.GameUtil)
require(ReplicatedStorage.Resource.Settings)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local notificationCounter = 0
local CurrentCamera = workspace.CurrentCamera
local referenceScreenSize = Vector2.new(1539, 804)
local tweenAnimation = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
local function getBox(vector)
	return math.min(vector.X, vector.Y)
end
local function getScreenRatio()
	local ViewportSize = CurrentCamera.ViewportSize
	local minViewportSize = math.min(ViewportSize.X, ViewportSize.Y)
	local referenceSize = referenceScreenSize
	return minViewportSize / math.min(referenceSize.X, referenceSize.Y)
end
local function ScaleNotification(notificationFrame)
	notificationFrame.Message.TextSize = math.floor(24 * (CurrentCamera.ViewportSize.Y / referenceScreenSize.Y))
	local ViewportSize = CurrentCamera.ViewportSize
	local minViewportSize = math.min(ViewportSize.X, ViewportSize.Y)
	local referenceSize = referenceScreenSize
	notificationFrame.UIStroke.Thickness = minViewportSize / math.min(referenceSize.X, referenceSize.Y) * 3
end
local notificationQueue = {}
local activeNotifications = {}
local function ProcessQueue()
	if #notificationQueue > 0 then
		local queuedNotification = table.remove(notificationQueue, 1)
		table.insert(activeNotifications, queuedNotification)
		queuedNotification:Hook()
	end
end
local notificationStyles = {
	Default = {
		Color = Color3.fromRGB(249, 210, 49),
		Sound = 131184732929614
	},
	Alert = {
		Color = Color3.fromRGB(249, 92, 49),
		Sound = 700153902,
		TimePosition = 0.07
	},
	Boss = {
		Color = Color3.fromRGB(255, 30, 0),
		Sound = 1843025542
	},
	Gift = {
		Color = Color3.fromRGB(0, 255, 0),
		Sound = 2671105631
	}
}
local Notification = {}
Notification.__index = Notification
function Notification.Init(config)
	local em = config.em
	local NotificationGui = ReplicatedStorage.StarterGui:FindFirstChild("NotificationGui")
	NotificationGui.Parent = LocalPlayer.PlayerGui
	NotificationGui.DisplayOrder = 9
	Notification.Gui = NotificationGui
	Notification.Templates = NotificationGui:WaitForChild("Templates")
	CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		for index, notification in activeNotifications do
			local Frame = notification.Frame
			Frame.Message.TextSize = math.floor(24 * (CurrentCamera.ViewportSize.Y / referenceScreenSize.Y))
			local ViewportSize = CurrentCamera.ViewportSize
			local minViewportSize = math.min(ViewportSize.X, ViewportSize.Y)
			local referenceSize = referenceScreenSize
			Frame.UIStroke.Thickness = minViewportSize / math.min(referenceSize.X, referenceSize.Y) * 3
		end
	end)
end
local function GetTextLines(text)
	local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
	GetTextBoundsParams.Text = text
	GetTextBoundsParams.Font = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic)
	GetTextBoundsParams.Size = 24
	GetTextBoundsParams.Width = 312
	return math.ceil(TextService:GetTextBoundsAsync(GetTextBoundsParams).Y / 24)
end
function Notification.notifyBoss(robberyTypes, isOpening)
	local Gui = Notification.Gui
	local notificationFrame = Notification.Templates.BossAlert:Clone()
	local robberyName = robberyTypes[1] and RobberyConsts.PRETTY_NAME[robberyTypes[1]] or ""
	if isOpening then
		notificationFrame.TitleMessage.Text = "CRIME BOSS ALERT"
		notificationFrame.OpenMessage.Text = "The " .. robberyName .. " is about to open"
	else
		notificationFrame.TitleMessage.Text = "ROBBERY ALERT"
		notificationFrame.OpenMessage.Text = "The " .. robberyName .. " is open"
	end
	for robberyIndex, robberyType in robberyTypes do
		local robberyData = RobberyConsts.DATA_ROBBERY[robberyType]
		if robberyData then
			local robberyFrame = Notification.Templates.RobberyFrame:Clone()
			robberyFrame.LayoutOrder = robberyIndex
			robberyFrame.ImageLabel.RobberyIcon.Image = "rbxassetid://" .. robberyData.imageId
			robberyFrame.Visible = true
			robberyFrame.Parent = notificationFrame.ListFrame
		end
	end
	ContentProvider:PreloadAsync(notificationFrame:GetDescendants())
	notificationFrame.LayoutOrder = 10
	notificationFrame.Parent = Gui.Container
	if Gui.Enabled then
		Audio.ObjectLocal(Gui, 1837831357, {
			Volume = 0.15,
			YieldForLoaded = true
		})
	end
	for descendantIndex, descendant in notificationFrame:GetDescendants() do
		if descendant:IsA("TextLabel") then
			descendant.TextTransparency = 1
			TweenService:Create(descendant, tweenAnimation, {
				TextTransparency = 0
			}):Play()
		elseif descendant:IsA("ImageLabel") then
			descendant.ImageTransparency = 1
			TweenService:Create(descendant, tweenAnimation, {
				ImageTransparency = 0
			}):Play()
		end
	end
	notificationFrame.Visible = true
	task.delay(3.5, function()
		for descendantIndex, descendant in notificationFrame:GetDescendants() do
			if descendant:IsA("TextLabel") then
				TweenService:Create(descendant, tweenAnimation, {
					TextTransparency = 1
				}):Play()
			elseif descendant:IsA("ImageLabel") then
				TweenService:Create(descendant, tweenAnimation, {
					ImageTransparency = 1
				}):Play()
			end
		end
		task.wait(tweenAnimation.Time)
		notificationFrame:Destroy()
	end)
end
local function getNumOfNotificationsWith(text)
	local count = 0
	for index, notification in activeNotifications do
		if notification.Text == text then
			count = count + 1
		end
	end
	for queueIndex, queuedNotification in notificationQueue do
		if queuedNotification.Text == text then
			count = count + 1
		end
	end
	return count
end
function Notification.new(config)
	assert(config ~= nil)
	assert(config.Text ~= nil)
	if config.Duration == nil then
		config.Duration = math.min(5, 4 * utf8.len(config.Text) / 50)
	end
	if config.Style == nil then
		config.Style = "Default"
	end
	if not notificationStyles[config.Style] then
		warn("INVALID NOTIFICATION STYLE FOR STRING:", config.Text)
		config.Style = "Default"
	end
	if config.Style ~= "Default" or not (getNumOfNotificationsWith(config.Text) >= 3) then
		assert(config.Duration ~= nil)
		assert(config.Style ~= nil)
		local newNotification = {}
		setmetatable(newNotification, Notification)
		newNotification.Maid = Maid.new()
		newNotification.Text = config.Text
		newNotification.Duration = config.Duration
		newNotification.Style = config.Style
		table.insert(notificationQueue, newNotification)
		if #activeNotifications < 3 and #notificationQueue > 0 then
			local queuedNotification = table.remove(notificationQueue, 1)
			table.insert(activeNotifications, queuedNotification)
			queuedNotification:Hook()
		end
		return newNotification
	end
end
function Notification.Hook(notification)
	notificationCounter = notificationCounter + 1
	local Gui = Notification.Gui
	local notificationFrame = Notification.Templates.Notification:Clone()
	local styleConfig = notificationStyles[notification.Style]
	notification.Frame = notificationFrame
	notificationFrame.Visible = true
	notificationFrame.UIStroke.Color = styleConfig.Color
	notificationFrame.LayoutOrder = -notificationCounter
	notificationFrame.Message.Text = notification.Text
	notificationFrame.Message.MaxVisibleGraphemes = 0
	local Size = notificationFrame.Size
	local lineCount = GetTextLines(notification.Text)
	if lineCount > 1 then
		Size = UDim2.fromScale(notificationFrame.Size.X.Scale, notificationFrame.Size.Y.Scale * (1 + 0.5 * (lineCount - 1)))
	end
	notificationFrame.Message.TextSize = math.floor(24 * (CurrentCamera.ViewportSize.Y / referenceScreenSize.Y))
	local ViewportSize = CurrentCamera.ViewportSize
	local minViewportSize = math.min(ViewportSize.X, ViewportSize.Y)
	local referenceSize = referenceScreenSize
	notificationFrame.UIStroke.Thickness = minViewportSize / math.min(referenceSize.X, referenceSize.Y) * 3
	notificationFrame.Size = UDim2.fromScale(notificationFrame.Size.X.Scale, 0)
	TweenService:Create(notificationFrame, TweenInfo.new(0.2, 0), {
		Size = Size
	}):Play()
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(215658476)
	Sound.Volume = 0.3
	Sound.Parent = notificationFrame
	notification.Maid:GiveTask(Sound)
	notificationFrame.Parent = Gui.Container
	local characterIndex = 1
	notification.Maid:GiveTask(TypeWrite(notification.Text, function(typedText)
		if notification.Maid == nil then
			return false
		end
		if characterIndex == 1 and Gui.Enabled then
			Sound:Play()
		end
		characterIndex = characterIndex % 3 + 1
		notificationFrame.Message.MaxVisibleGraphemes = #typedText
	end, 50))
	if Gui.Enabled then
		Audio.ObjectLocal(Gui, styleConfig.Sound, {
			Volume = 0.25,
			TimePosition = styleConfig.TimePosition or 0
		})
	end
	task.delay(notification.Duration, function()
		notification:Destroy()
	end)
end
function Notification.Destroy(notification)
	if notification.Maid ~= nil then
		local Gui = Notification.Gui
		TweenService:Create(notification.Frame, tweenAnimation, {
			BackgroundTransparency = 1
		}):Play()
		TweenService:Create(notification.Frame.Message, tweenAnimation, {
			TextTransparency = 1
		}):Play()
		TweenService:Create(notification.Frame.UIStroke, tweenAnimation, {
			Transparency = 1
		}):Play()
		task.delay(tweenAnimation.Time, function()
			notification.Frame:Destroy()
			local foundIndex = table.find(activeNotifications, notification)
			if foundIndex then
				table.remove(activeNotifications, foundIndex)
			end
			notification.Maid:Destroy()
			notification.Maid = nil
			if #notificationQueue > 0 then
				local queuedNotification = table.remove(notificationQueue, 1)
				table.insert(activeNotifications, queuedNotification)
				queuedNotification:Hook()
			end
		end)
	end
end
return Notification
