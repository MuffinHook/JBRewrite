-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Anim = require(ReplicatedStorage.Module.Anim)
local Maid = require(ReplicatedStorage.Std.Maid)
local CurrentCamera = workspace.CurrentCamera
local function GetRootPart()
	local Character = LocalPlayer.Character
	if Character == nil then
		return nil
	else
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid == nil then
			return nil
		else
			return Humanoid.RootPart
		end
	end
end
local t = {
	4,
	{ 48, 0 },
	{ 192, 24 },
	{ (1 / 0), 8 }
}
local t2 = {}
t2.__index = t2
function t2.new()
	local t3 = {}
	setmetatable(t3, t2)
	t3._maid = Maid.new()
	t3.ScreenGui = nil
	t3.Position = nil
	t3.Radius = 8
	t3.AnimRadius = nil
	t3.StartRadius = nil
	t3.EndRadius = nil
	t3.Enabled = false
	local WorldMarker = Instance.new("ImageLabel")
	WorldMarker.BorderSizePixel = 0
	WorldMarker.BackgroundTransparency = 1
	WorldMarker.ImageColor3 = Color3.new(0/255, 0/255, 0/255)
	WorldMarker.Image = "rbxassetid://2819326547"
	WorldMarker.AnchorPoint = Vector2.new(0.5, 0.5)
	WorldMarker.ZIndex = 1
	WorldMarker.Name = "WorldMarker"
	t3.Frame = WorldMarker
	t3._maid:GiveTask(t3.Frame)
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.BorderSizePixel = 0
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
	ImageLabel.Image = "rbxassetid://2819326547"
	ImageLabel.Size = UDim2.new(0.85, 0, 0.85, 0)
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.ZIndex = 2
	ImageLabel.Parent = WorldMarker
	t3.FrameInner = ImageLabel
	t3:SetSizes(t)
	t3:SetRadius(t3.Radius)
	t3:SetEnabled(true)
	return t3
end
function t2.SetSizes(p1, p2)
	p2 = p2 or t
	p1._sizes = p2
end
function t2.SetEnabled(p1, p2)
	p1.Enabled = p2
	p1.Frame.Visible = p2
	if p1.Frame.Name == "ImportantLocationMarker" then
		print("setting enabled", p2)
	end
end
function t2.SetScreenGui(p1, p2)
	p1.ScreenGui = p2
	p1.Frame.Parent = p1.ScreenGui
end
function t2.CreateFrameIcon(p1)
	assert(p1.FrameIcon == nil)
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.BorderSizePixel = 0
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.ZIndex = 3
	ImageLabel.Parent = p1.FrameInner
	p1.FrameIcon = ImageLabel
end
function t2.DestroyFrameIcon(p1)
	assert(p1.FrameIcon ~= nil)
	p1.FrameIcon:Destroy()
	p1.FrameIcon = nil
end
function t2.SetIcon(p1, p2, p3)
	if p2 == nil then
		if p1.FrameIcon ~= nil then
			p1:DestroyFrameIcon()
		end
	else
		if p1.FrameIcon == nil then
			p1:CreateFrameIcon()
		end
		p1.FrameIcon.Image = ("rbxassetid://%d"):format(p2)
		if p3 then
			p1.FrameIcon.ImageColor3 = p3
		end
		p1:SetRadius(p1.Radius)
	end
end
function t2.SetPosition(p1, p2)
	p1.Position = p2
end
function t2.GetPosition(p1)
	return p1.Position
end
function t2.SetRadius(p1, p2)
	p1.Radius = p2
	p1.Frame.Size = UDim2.new(0, 2 * p2, 0, 2 * p2)
	if p1.FrameIcon ~= nil then
		if p2 < 8 then
			if p1.FrameIcon.Visible == true then
				p1.FrameIcon.Visible = false
			end
		elseif p1.FrameIcon.Visible == false then
			p1.FrameIcon.Visible = true
		end
	end
end
function t2.AnimateRadius(p1, p2)
	if p1.AnimRadius ~= nil then
		p1.AnimRadius:Destroy()
		p1.AnimRadius = nil
	end
	p1.StartRadius = p1.Radius
	p1.EndRadius = p2
	local v1 = Anim.new(0.1)
	v1.OnCompleted:Connect(function()
		p1.AnimRadius:Destroy()
		p1.AnimRadius = nil
		p1:SetRadius(p1.EndRadius)
	end)
	p1.AnimRadius = v1
end
function t2.SetAdornee(p1, p2)
	p1._adornee = p2
	p1.Position = p1._adornee.Position
end
function t2.GetAdornee(p1)
	return p1._adornee
end
function t2.Update(p1)
	if p1.Enabled then
		local AbsoluteSize = p1.ScreenGui.AbsoluteSize
		local X = AbsoluteSize.X
		local Y = AbsoluteSize.Y
		if p1._adornee then
			p1.Position = p1._adornee.Position
		end
		if p1.Position then
			local v1 = CurrentCamera:WorldToViewportPoint(p1.Position)
			local X_2 = v1.X
			local Y_2 = v1.Y
			local v3 = p1.Radius + 4
			local v4 = p1.Radius + 4
			local v5
			if X_2 < v3 then
				X_2 = v3
				v5 = true
			else
				v5 = false
			end
			if X - v3 < X_2 then
				X_2 = X - v3
				v5 = true
			end
			if Y_2 < v4 then
				Y_2 = v4
				v5 = true
			end
			if Y - v4 < Y_2 then
				Y_2 = Y - v4
				v5 = true
			end
			local v6, v7
			if v1.Z < 0 then
				v5 = true
				v6 = X - X_2
				v7 = Y - Y_2
				if math.min(v6, X_2) < math.min(v7, Y_2) then
					if v6 < X_2 then
						v6 = v3
					else
						v6 = X - v3
					end
				elseif v7 < Y_2 then
					v7 = v4
				else
					v7 = Y - v4
				end
			else
				v7 = Y_2
				v6 = X_2
			end
			p1.Frame.Position = UDim2.new(0, v6, 0, v7)
			local v8 = (1 / 0)
			local Character = LocalPlayer.Character
			local v9
			if Character == nil then
				v9 = nil
			else
				local Humanoid = Character:FindFirstChild("Humanoid")
				v9 = if Humanoid == nil then nil else Humanoid.RootPart
			end
			if v9 then
				v8 = (v9.Position - p1.Position).Magnitude
			end
			local v10 = nil
			if v5 then
				v10 = p1._sizes[1]
			else
				for i = 2, #p1._sizes do
					local v12 = p1._sizes[i][2]
					if v8 <= p1._sizes[i][1] then
						v10 = v12
						break
					end
				end
			end
			assert(v10)
			if p1.EndRadius ~= v10 then
				p1:AnimateRadius(v10)
			end
			if p1.AnimRadius ~= nil then
				local v13 = p1.AnimRadius:Update()
				p1:SetRadius(p1.StartRadius * (1 - v13) + p1.EndRadius * v13)
			end
		end
	end
end
function t2.Destroy(p1)
	p1._maid:Destroy()
	p1._maid = nil
	p1.ScreenGui = nil
	p1.Position = nil
	setmetatable(p1, nil)
end
return t2
