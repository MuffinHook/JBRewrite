local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Format = require(ReplicatedStorage.Module.Format)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local t = {
	Formatter = {},
	CurrentTier = 1
}
local function Cash(p1, p2) --[[ Line: 13 | Upvalues: Format (copy) ]]
	return ("%s / %s"):format(Format.Currency(p1), Format.Currency(p2))
end
t.Formatter.Cash = Cash
local function CashNoMax(p1) --[[ Line: 16 | Upvalues: Format (copy) ]]
	return ("%s Cash"):format(Format.Currency(p1))
end
t.Formatter.CashNoMax = CashNoMax
local function Weight(p1, p2) --[[ Line: 19 ]]
	return ("%d kg / %d kg"):format(p1, p2)
end
t.Formatter.Weight = Weight
t.SelectedFormatter = t.Formatter.Cash
function t.Init() --[[ Line: 23 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t (copy) ]]
	local RobberyMoneyGui = ReplicatedStorage.StarterGui:FindFirstChild("RobberyMoneyGui")
	RobberyMoneyGui.Parent = LocalPlayer.PlayerGui
	t.Gui = RobberyMoneyGui.Frame
end
function t.GetMaxSizeForTier(p1) --[[ Line: 29 | Upvalues: t (copy) ]]
	assert(p1 ~= nil)
	assert(p1 >= 1)
	return t.Gui.Container.Bottom.Progress.Tiers:FindFirstChild("Tier" .. p1).Position.X.Scale
end
local v1 = nil
local v2 = TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
function t.Show() --[[ Line: 40 | Upvalues: t (copy), Maid (copy), v1 (ref), TweenService (copy), v2 (copy), v3 (copy) ]]
	if t.Maid ~= nil then
		return false
	end
	local Gui = t.Gui
	local v12 = Maid.new()
	t.Maid = v12
	if v1 then
		v1:Cancel()
	end
	Gui.Position = UDim2.fromScale(1, 0)
	Gui.Visible = true
	v1 = TweenService:Create(Gui, v2, {
		Position = UDim2.fromScale(0, 0)
	})
	v1:Play()
	v12:GiveTask(function() --[[ Line: 55 | Upvalues: v1 (ref), TweenService (ref), Gui (copy), v3 (ref) ]]
		if v1 then
			v1:Cancel()
		end
		v1 = TweenService:Create(Gui, v3, {
			Position = UDim2.fromScale(1, 0)
		})
		v1:Play()
		v1.Completed:Once(function(p1) --[[ Line: 61 | Upvalues: Gui (ref) ]]
			if p1 == Enum.PlaybackState.Completed then
				Gui.Visible = false
			end
		end)
	end)
	Gui.Container.Bottom.Progress.Slider.Value.Size = UDim2.new(0, 0, 1, 0)
	v12:GiveTask(function() --[[ Line: 68 | Upvalues: Gui (copy) ]]
		Gui.Container.Bottom.Progress.Slider.Value.Size = UDim2.new(0, 0, 1, 0)
	end)
end
function t.getUpgradeButton() --[[ Line: 72 | Upvalues: t (copy) ]]
	return t.Gui.Container.Top.Upgrade
end
function t.SetFormatter(p1) --[[ Line: 76 | Upvalues: t (copy) ]]
	t.SelectedFormatter = p1
end
function t.SetTime(p1) --[[ Line: 79 | Upvalues: t (copy) ]]
	local Gui = t.Gui
	Gui.Container.Time.Visible = p1 ~= nil
	if p1 ~= nil then
		if p1 > 60 then
			local v2 = math.floor(p1 / 60)
			local v3 = math.floor(p1 % 60)
			Gui.Container.Time.Text = ("%d:%02d"):format(math.max(v2, 0), (math.max(v3, 0)))
			return
		end
		Gui.Container.Time.Text = ("%d"):format((math.max(p1, 0)))
	end
end
function t.SetTier(p1, p2) --[[ Line: 95 | Upvalues: t (copy) ]]
	assert(p1 ~= nil)
	assert(p1 >= 1)
	assert(p2 ~= nil)
	local Gui = t.Gui
	local Tiers = Gui.Container.Bottom.Progress.Tiers
	local count = 0
	for i, v in ipairs(Tiers:GetChildren()) do
		if v:IsA("Frame") then
			count = count + 1
		end
	end
	assert(p1 <= count)
	for i = 1, count do
		local v5 = Tiers:FindFirstChild("Tier" .. i)
		if i == p1 then
			v5.BackgroundTransparency = 0
			v5.Circle.Tier.UIGradient.Enabled = false
		else
			v5.BackgroundTransparency = 0.7
			v5.Circle.Tier.UIGradient.Enabled = true
		end
		v5.Visible = p2
	end
	local Top = Gui.Container.Top
	local v6 = if p1 < count then if t.SelectedFormatter == t.Formatter.CashNoMax then false else p2 else false
	Top.Upgrade.Visible = v6
	Top.Alternative.Visible = not v6
	if v6 then
		Top.Upgrade.Title.Text = ("Unlock Tier %d"):format(p1 + 1)
	end
	t.CurrentTier = p2 and p1 or count
end
local v4 = nil
local v5 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
function t.SetMoney(p1, p2, p3) --[[ Line: 145 | Upvalues: t (copy), v4 (ref), TweenService (copy), v5 (copy) ]]
	assert(p1)
	assert(p2)
	local Gui = t.Gui
	Gui.Container.Bottom.Progress.Amount.Text = t.SelectedFormatter(p1, p2)
	if v4 then
		v4:Cancel()
	end
	if t.SelectedFormatter == t.Formatter.CashNoMax then
		if p3 then
			Gui.Container.Bottom.Progress.Slider.Value.Size = UDim2.new(1, 0, 1, 0)
		else
			Gui.Container.Bottom.Progress.Slider.Value.Size = UDim2.new(0, 0, 1, 0)
			v4 = TweenService:Create(Gui.Container.Bottom.Progress.Slider.Value, v5, {
				Size = UDim2.new(1, 0, 1, 0)
			})
			v4:Play()
		end
		Gui.Container.Bottom.Progress.Tiers.Visible = false
	else
		local v3 = UDim2.new(t.GetMaxSizeForTier(t.CurrentTier) * p1 / p2, 0, 1, 0)
		if p3 then
			Gui.Container.Bottom.Progress.Slider.Value.Size = v3
		else
			v4 = TweenService:Create(Gui.Container.Bottom.Progress.Slider.Value, v5, {
				Size = v3
			})
			v4:Play()
		end
		Gui.Container.Bottom.Progress.Tiers.Visible = true
	end
end
function t.SetMessage(p1) --[[ Line: 182 | Upvalues: t (copy) ]]
	local Gui = t.Gui
	if p1 == nil then
		Gui.Container.Message.Visible = false
	else
		Gui.Container.Message.Visible = true
		Gui.Container.Message.Text = p1
	end
end
local function setColor(p1, p2) --[[ Line: 192 ]]
	if p1:IsA("Frame") then
		p1.BackgroundColor3 = p2
	elseif p1:IsA("TextLabel") or p1:IsA("TextButton") then
		p1.BackgroundColor3 = p2
		p1.TextColor3 = p2
	elseif p1:IsA("UIStroke") then
		p1.Color = p2
	elseif p1:IsA("UIGradient") then
		p1.Color = ColorSequence.new(p2)
	end
end
local function changeColor(p1, p2) --[[ Line: 205 | Upvalues: ColorUtils (copy), setColor (copy) ]]
	local v1 = ColorUtils.saturateBy(ColorUtils.brightenBy(p2, -0.455), 0.093)
	if p2 == Color3.fromRGB(194, 248, 117) then
		v1 = ColorUtils.hueBy(v1, 0.102)
	end
	local v3 = ColorUtils.brightenTo(p2, 1)
	for v4, v5 in p1:QueryDescendants("[$baseColor]") do
		setColor(v5, p2)
	end
	for v6, v7 in p1:QueryDescendants("[$darkColor]") do
		setColor(v7, v1)
	end
	for v8, v9 in p1:QueryDescendants("[$brightColor]") do
		setColor(v9, v3)
	end
end
function t.SetRobbery(p1) --[[ Line: 222 | Upvalues: t (copy), RobberyConsts (copy), changeColor (copy) ]]
	local Container = t.Gui.Container
	local v1 = RobberyConsts.DATA_ROBBERY[p1].frameData or {}
	changeColor(Container, v1.color or Color3.fromRGB(194, 248, 117))
	Container.Icon.Image = "rbxassetid://" .. (v1.topImageId or 83554444602066)
	Container.Bottom.Progress.Icon.Image = "rbxassetid://" .. (v1.cashImageId or 4912231216)
	Container.Top.Alternative.Title.Text = v1.alternativeText or "COLLECTING..."
end
function t.Hide() --[[ Line: 237 | Upvalues: t (copy) ]]
	if t.Maid == nil then
		return false
	end
	t.Maid:Destroy()
	t.Maid = nil
end
return t