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
local v1 = 0
local CurrentCamera = workspace.CurrentCamera
local v2 = Vector2.new(1539, 804)
local v3 = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
local function getBox(p1) --[[ Line: 26 ]]
	return math.min(p1.X, p1.Y)
end
local function getScreenRatio() --[[ Line: 29 | Upvalues: CurrentCamera (copy), v2 (copy) ]]
	local ViewportSize = CurrentCamera.ViewportSize
	local v1 = math.min(ViewportSize.X, ViewportSize.Y)
	local v22 = v2
	return v1 / math.min(v22.X, v22.Y)
end
local function ScaleNotification(p1) --[[ Line: 32 | Upvalues: CurrentCamera (copy), v2 (copy) ]]
	p1.Message.TextSize = math.floor(24 * (CurrentCamera.ViewportSize.Y / v2.Y))
	local ViewportSize = CurrentCamera.ViewportSize
	local v22 = math.min(ViewportSize.X, ViewportSize.Y)
	local v3 = v2
	p1.UIStroke.Thickness = v22 / math.min(v3.X, v3.Y) * 3
end
local t = {}
local t2 = {}
local function ProcessQueue() --[[ Line: 39 | Upvalues: t (copy), t2 (copy) ]]
	if #t > 0 then
		local v1 = table.remove(t, 1)
		table.insert(t2, v1)
		v1:Hook()
	end
end
local t3 = {
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
local t4 = {}
t4.__index = t4
function t4.Init(p1) --[[ Line: 69 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t4 (copy), CurrentCamera (copy), t2 (copy), v2 (copy) ]]
	local em = p1.em
	local NotificationGui = ReplicatedStorage.StarterGui:FindFirstChild("NotificationGui")
	NotificationGui.Parent = LocalPlayer.PlayerGui
	NotificationGui.DisplayOrder = 9
	t4.Gui = NotificationGui
	t4.Templates = NotificationGui:WaitForChild("Templates")
	CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 81 | Upvalues: t2 (ref), CurrentCamera (ref), v2 (ref) ]]
		for v1, v22 in t2 do
			local Frame = v22.Frame
			Frame.Message.TextSize = math.floor(24 * (CurrentCamera.ViewportSize.Y / v2.Y))
			local ViewportSize = CurrentCamera.ViewportSize
			local v4 = math.min(ViewportSize.X, ViewportSize.Y)
			local v5 = v2
			Frame.UIStroke.Thickness = v4 / math.min(v5.X, v5.Y) * 3
		end
	end)
end
local function GetTextLines(p1) --[[ Line: 88 | Upvalues: TextService (copy) ]]
	local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
	GetTextBoundsParams.Text = p1
	GetTextBoundsParams.Font = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic)
	GetTextBoundsParams.Size = 24
	GetTextBoundsParams.Width = 312
	return math.ceil(TextService:GetTextBoundsAsync(GetTextBoundsParams).Y / 24)
end
function t4.notifyBoss(p1, p2) --[[ Line: 98 | Upvalues: t4 (copy), RobberyConsts (copy), ContentProvider (copy), Audio (copy), TweenService (copy), v3 (copy) ]]
	local Gui = t4.Gui
	local v1 = t4.Templates.BossAlert:Clone()
	local v2 = p1[1] and RobberyConsts.PRETTY_NAME[p1[1]] or ""
	if p2 then
		v1.TitleMessage.Text = "CRIME BOSS ALERT"
		v1.OpenMessage.Text = "The " .. v2 .. " is about to open"
	else
		v1.TitleMessage.Text = "ROBBERY ALERT"
		v1.OpenMessage.Text = "The " .. v2 .. " is open"
	end
	for v32, v4 in p1 do
		local v5 = RobberyConsts.DATA_ROBBERY[v4]
		if v5 then
			local v6 = t4.Templates.RobberyFrame:Clone()
			v6.LayoutOrder = v32
			v6.ImageLabel.RobberyIcon.Image = "rbxassetid://" .. v5.imageId
			v6.Visible = true
			v6.Parent = v1.ListFrame
		end
	end
	ContentProvider:PreloadAsync(v1:GetDescendants())
	v1.LayoutOrder = 10
	v1.Parent = Gui.Container
	if Gui.Enabled then
		Audio.ObjectLocal(Gui, 1837831357, {
			Volume = 0.15,
			YieldForLoaded = true
		})
	end
	for v7, v8 in v1:GetDescendants() do
		if v8:IsA("TextLabel") then
			v8.TextTransparency = 1
			TweenService:Create(v8, v3, {
				TextTransparency = 0
			}):Play()
		elseif v8:IsA("ImageLabel") then
			v8.ImageTransparency = 1
			TweenService:Create(v8, v3, {
				ImageTransparency = 0
			}):Play()
		end
	end
	v1.Visible = true
	task.delay(3.5, function() --[[ Line: 138 | Upvalues: v1 (copy), TweenService (ref), v3 (ref) ]]
		for v12, v2 in v1:GetDescendants() do
			if v2:IsA("TextLabel") then
				TweenService:Create(v2, v3, {
					TextTransparency = 1
				}):Play()
			elseif v2:IsA("ImageLabel") then
				TweenService:Create(v2, v3, {
					ImageTransparency = 1
				}):Play()
			end
		end
		task.wait(v3.Time)
		v1:Destroy()
	end)
end
local function getNumOfNotificationsWith(p1) --[[ Line: 151 | Upvalues: t2 (copy), t (copy) ]]
	local count = 0
	for v1, v2 in t2 do
		if v2.Text == p1 then
			count = count + 1
		end
	end
	for v3, v4 in t do
		if v4.Text == p1 then
			count = count + 1
		end
	end
	return count
end
function t4.new(p1) --[[ Line: 166 | Upvalues: t3 (copy), getNumOfNotificationsWith (copy), t4 (copy), Maid (copy), t (copy), t2 (copy) ]]
	assert(p1 ~= nil)
	assert(p1.Text ~= nil)
	if p1.Duration == nil then
		p1.Duration = math.min(5, 4 * utf8.len(p1.Text) / 50)
	end
	if p1.Style == nil then
		p1.Style = "Default"
	end
	if not t3[p1.Style] then
		warn("INVALID NOTIFICATION STYLE FOR STRING:", p1.Text)
		p1.Style = "Default"
	end
	if p1.Style ~= "Default" or not (getNumOfNotificationsWith(p1.Text) >= 3) then
		assert(p1.Duration ~= nil)
		assert(p1.Style ~= nil)
		local t5 = {}
		setmetatable(t5, t4)
		t5.Maid = Maid.new()
		t5.Text = p1.Text
		t5.Duration = p1.Duration
		t5.Style = p1.Style
		table.insert(t, t5)
		if #t2 < 3 and #t > 0 then
			local v5 = table.remove(t, 1)
			table.insert(t2, v5)
			v5:Hook()
		end
		return t5
	end
end
function t4.Hook(p1) --[[ Line: 214 | Upvalues: v1 (ref), t4 (copy), t3 (copy), GetTextLines (copy), CurrentCamera (copy), v2 (copy), TweenService (copy), TypeWrite (copy), Audio (copy) ]]
	v1 = v1 + 1
	local Gui = t4.Gui
	local v12 = t4.Templates.Notification:Clone()
	local v22 = t3[p1.Style]
	p1.Frame = v12
	v12.Visible = true
	v12.UIStroke.Color = v22.Color
	v12.LayoutOrder = -v1
	v12.Message.Text = p1.Text
	v12.Message.MaxVisibleGraphemes = 0
	local Size = v12.Size
	local v3 = GetTextLines(p1.Text)
	if v3 > 1 then
		Size = UDim2.fromScale(v12.Size.X.Scale, v12.Size.Y.Scale * (1 + 0.5 * (v3 - 1)))
	end
	v12.Message.TextSize = math.floor(24 * (CurrentCamera.ViewportSize.Y / v2.Y))
	local ViewportSize = CurrentCamera.ViewportSize
	local v5 = math.min(ViewportSize.X, ViewportSize.Y)
	local v6 = v2
	v12.UIStroke.Thickness = v5 / math.min(v6.X, v6.Y) * 3
	v12.Size = UDim2.fromScale(v12.Size.X.Scale, 0)
	TweenService:Create(v12, TweenInfo.new(0.2, 0), {
		Size = Size
	}):Play()
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(215658476)
	Sound.Volume = 0.3
	Sound.Parent = v12
	p1.Maid:GiveTask(Sound)
	v12.Parent = Gui.Container
	local v7 = 1
	p1.Maid:GiveTask(TypeWrite(p1.Text, function(p12) --[[ Line: 246 | Upvalues: p1 (copy), v7 (ref), Gui (copy), Sound (copy), v12 (copy) ]]
		if p1.Maid == nil then
			return false
		end
		if v7 == 1 and Gui.Enabled then
			Sound:Play()
		end
		v7 = v7 % 3 + 1
		v12.Message.MaxVisibleGraphemes = #p12
	end, 50))
	if Gui.Enabled then
		Audio.ObjectLocal(Gui, v22.Sound, {
			Volume = 0.25,
			TimePosition = v22.TimePosition or 0
		})
	end
	task.delay(p1.Duration, function() --[[ Line: 261 | Upvalues: p1 (copy) ]]
		p1:Destroy()
	end)
end
function t4.Destroy(p1) --[[ Line: 265 | Upvalues: t4 (copy), TweenService (copy), v3 (copy), t2 (copy), t (copy) ]]
	if p1.Maid ~= nil then
		local Gui = t4.Gui
		TweenService:Create(p1.Frame, v3, {
			BackgroundTransparency = 1
		}):Play()
		TweenService:Create(p1.Frame.Message, v3, {
			TextTransparency = 1
		}):Play()
		TweenService:Create(p1.Frame.UIStroke, v3, {
			Transparency = 1
		}):Play()
		task.delay(v3.Time, function() --[[ Line: 273 | Upvalues: p1 (copy), t2 (ref), t (ref) ]]
			p1.Frame:Destroy()
			local v1 = table.find(t2, p1)
			if v1 then
				table.remove(t2, v1)
			end
			p1.Maid:Destroy()
			p1.Maid = nil
			if #t > 0 then
				local v2 = table.remove(t, 1)
				table.insert(t2, v2)
				v2:Hook()
			end
		end)
	end
end
return t4