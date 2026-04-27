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
local radiusThresholds = {
	4,
	{ 48, 0 },
	{ 192, 24 },
	{ (1 / 0), 8 }
}
local WorldMarker = {}
WorldMarker.__index = WorldMarker
function WorldMarker.new()
	local self = {}
	setmetatable(self, WorldMarker)
	self._maid = Maid.new()
	self.ScreenGui = nil
	self.Position = nil
	self.Radius = 8
	self.AnimRadius = nil
	self.StartRadius = nil
	self.EndRadius = nil
	self.Enabled = false
	local WorldMarkerFrame = Instance.new("ImageLabel")
	WorldMarkerFrame.BorderSizePixel = 0
	WorldMarkerFrame.BackgroundTransparency = 1
	WorldMarkerFrame.ImageColor3 = Color3.new(0/255, 0/255, 0/255)
	WorldMarkerFrame.Image = "rbxassetid://2819326547"
	WorldMarkerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	WorldMarkerFrame.ZIndex = 1
	WorldMarkerFrame.Name = "WorldMarker"
	self.Frame = WorldMarkerFrame
	self._maid:GiveTask(self.Frame)
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.BorderSizePixel = 0
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
	ImageLabel.Image = "rbxassetid://2819326547"
	ImageLabel.Size = UDim2.new(0.85, 0, 0.85, 0)
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.ZIndex = 2
	ImageLabel.Parent = WorldMarkerFrame
	self.FrameInner = ImageLabel
	self:SetSizes(radiusThresholds)
	self:SetRadius(self.Radius)
	self:SetEnabled(true)
	return self
end
function WorldMarker.SetSizes(self, sizes)
	sizes = sizes or radiusThresholds
	self._sizes = sizes
end
function WorldMarker.SetEnabled(self, isEnabled)
	self.Enabled = isEnabled
	self.Frame.Visible = isEnabled
	if self.Frame.Name == "ImportantLocationMarker" then
		print("setting enabled", isEnabled)
	end
end
function WorldMarker.SetScreenGui(self, screenGui)
	self.ScreenGui = screenGui
	self.Frame.Parent = self.ScreenGui
end
function WorldMarker.CreateFrameIcon(self)
	assert(self.FrameIcon == nil)
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.BorderSizePixel = 0
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.ZIndex = 3
	ImageLabel.Parent = self.FrameInner
	self.FrameIcon = ImageLabel
end
function WorldMarker.DestroyFrameIcon(self)
	assert(self.FrameIcon ~= nil)
	self.FrameIcon:Destroy()
	self.FrameIcon = nil
end
function WorldMarker.SetIcon(self, assetId, color)
	if assetId == nil then
		if self.FrameIcon ~= nil then
			self:DestroyFrameIcon()
		end
	else
		if self.FrameIcon == nil then
			self:CreateFrameIcon()
		end
		self.FrameIcon.Image = ("rbxassetid://%d"):format(assetId)
		if color then
			self.FrameIcon.ImageColor3 = color
		end
		self:SetRadius(self.Radius)
	end
end
function WorldMarker.SetPosition(self, position)
	self.Position = position
end
function WorldMarker.GetPosition(self)
	return self.Position
end
function WorldMarker.SetRadius(self, radius)
	self.Radius = radius
	self.Frame.Size = UDim2.new(0, 2 * radius, 0, 2 * radius)
	if self.FrameIcon ~= nil then
		if radius < 8 then
			if self.FrameIcon.Visible == true then
				self.FrameIcon.Visible = false
			end
		elseif self.FrameIcon.Visible == false then
			self.FrameIcon.Visible = true
		end
	end
end
function WorldMarker.AnimateRadius(self, targetRadius)
	if self.AnimRadius ~= nil then
		self.AnimRadius:Destroy()
		self.AnimRadius = nil
	end
	self.StartRadius = self.Radius
	self.EndRadius = targetRadius
	local radiusAnimation = Anim.new(0.1)
	radiusAnimation.OnCompleted:Connect(function()
		self.AnimRadius:Destroy()
		self.AnimRadius = nil
		self:SetRadius(self.EndRadius)
	end)
	self.AnimRadius = radiusAnimation
end
function WorldMarker.SetAdornee(self, adornee)
	self._adornee = adornee
	self.Position = self._adornee.Position
end
function WorldMarker.GetAdornee(self)
	return self._adornee
end
function WorldMarker.Update(self)
	if self.Enabled then
		local AbsoluteSize = self.ScreenGui.AbsoluteSize
		local X = AbsoluteSize.X
		local Y = AbsoluteSize.Y
		if self._adornee then
			self.Position = self._adornee.Position
		end
		if self.Position then
			local viewportPoint = CurrentCamera:WorldToViewportPoint(self.Position)
			local X_2 = viewportPoint.X
			local Y_2 = viewportPoint.Y
			local minX = self.Radius + 4
			local minY = self.Radius + 4
			local isOutOfBounds
			if X_2 < minX then
				X_2 = minX
				isOutOfBounds = true
			else
				isOutOfBounds = false
			end
			if X - minX < X_2 then
				X_2 = X - minX
				isOutOfBounds = true
			end
			if Y_2 < minY then
				Y_2 = minY
				isOutOfBounds = true
			end
			if Y - minY < Y_2 then
				Y_2 = Y - minY
				isOutOfBounds = true
			end
			local frameX, frameY
			if viewportPoint.Z < 0 then
				isOutOfBounds = true
				frameX = X - X_2
				frameY = Y - Y_2
				if math.min(frameX, X_2) < math.min(frameY, Y_2) then
					if frameX < X_2 then
						frameX = minX
					else
						frameX = X - minX
					end
				elseif frameY < Y_2 then
					frameY = minY
				else
					frameY = Y - minY
				end
			else
				frameY = Y_2
				frameX = X_2
			end
			self.Frame.Position = UDim2.new(0, frameX, 0, frameY)
			local distanceToPlayer = (1 / 0)
			local Character = LocalPlayer.Character
			local playerRootPart
			if Character == nil then
				playerRootPart = nil
			else
				local Humanoid = Character:FindFirstChild("Humanoid")
				playerRootPart = if Humanoid == nil then nil else Humanoid.RootPart
			end
			if playerRootPart then
				distanceToPlayer = (playerRootPart.Position - self.Position).Magnitude
			end
			local targetRadius = nil
			if isOutOfBounds then
				targetRadius = self._sizes[1]
			else
				for i = 2, #self._sizes do
					local distanceThreshold = self._sizes[i][2]
					if distanceToPlayer <= self._sizes[i][1] then
						targetRadius = distanceThreshold
						break
					end
				end
			end
			assert(targetRadius)
			if self.EndRadius ~= targetRadius then
				self:AnimateRadius(targetRadius)
			end
			if self.AnimRadius ~= nil then
				local animationProgress = self.AnimRadius:Update()
				self:SetRadius(self.StartRadius * (1 - animationProgress) + self.EndRadius * animationProgress)
			end
		end
	end
end
function WorldMarker.Destroy(self)
	self._maid:Destroy()
	self._maid = nil
	self.ScreenGui = nil
	self.Position = nil
	setmetatable(self, nil)
end
return WorldMarker
