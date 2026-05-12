local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Basic = require(script.Parent.Basic)
local itemConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 0.5, -1),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		Place = {
			Springs = {
				ItemOffset = Vector3.new(0, 2.4, -1.7),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(math.pi / 4, 0, 0),
				WaistRotation = Vector3.new(-1.8849556, 0, 0)
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	},
	MaxLength = 48
}
local itemEvent = nil
local RoadSpike = {
	__ClassName = "RoadSpike"
}
RoadSpike.__index = RoadSpike
setmetatable(RoadSpike, Basic)
function RoadSpike.Init(self)
	itemEvent = self.Event
end
function RoadSpike.new(self, p2, p3)
	local instance = Basic.new(self, p2, itemConfig, p3)
	setmetatable(instance, RoadSpike)
	instance.IgnoreList = { instance.Character, workspace.Items }
	instance:SetupBeam()
	instance:SetupGui()
	instance:DefaultDisableCamLock()
	return instance
end
function RoadSpike.SetupGui(self)
	if self.Local then
		self.Maid:GiveTask(ActionButtonService.add({
			priority = 750,
			image = "rbxassetid://4939737424",
			keyCodes = { Enum.KeyCode.R, Enum.KeyCode.ButtonX },
			onPressed = function()
				itemEvent:FireServer("clearRoadSpike")
			end
		}))
	end
end
function RoadSpike.SetupBeam(self)
	local Attachment = Instance.new("Attachment")
	Attachment.Orientation = Vector3.new(90, 0, 0)
	Attachment.Position = Vector3.new(0, 0, 0)
	Attachment.Parent = self.Center
	local Beam = Instance.new("Beam")
	Beam.Transparency = NumberSequence.new(0)
	Beam.TextureMode = Enum.TextureMode.Static
	Beam.Texture = ("rbxassetid://%d"):format(4556309780)
	Beam.TextureLength = 6
	Beam.Width0 = 6
	Beam.Width1 = 6
	Beam.Attachment1 = Attachment
	Beam.Segments = 1
	Beam.FaceCamera = true
	Beam.Enabled = false
	Beam.Parent = self.Center
	self.Beam = Beam
	self.StartPosition = nil
	self.EndPosition = nil
	self.TempPart = nil
end
function RoadSpike.PlaceBeam(self, targetPosition)
	if self.StartPosition == nil then
		if self.TempPart ~= nil then
			self.TempPart:Destroy()
			self.TempPart = nil
		end
		local Part = Instance.new("Part")
		Part.Anchored = true
		Part.Transparency = 1
		Part.CanCollide = false
		Part.CFrame = CFrame.new(targetPosition)
		Part.Parent = workspace
		self.TempPart = Part
		local Attachment = Instance.new("Attachment")
		Attachment.Orientation = Vector3.new(90, 0, 0)
		Attachment.Position = Vector3.new(0, 0, 0)
		Attachment.Parent = Part
		self.Beam.Attachment0 = Attachment
		self.Beam.Enabled = true
	elseif self.EndPosition == nil then
		self.TempPart:Destroy()
		self.TempPart = nil
		self.Beam.Enabled = false
	end
	if self.StartPosition == nil then
		self.StartPosition = targetPosition
	elseif self.EndPosition == nil then
		self.EndPosition = targetPosition
		if self.Local then
			itemEvent:FireServer("placeRoadSpike", self.StartPosition, self.EndPosition)
		end
	end
	if self.StartPosition ~= nil and self.EndPosition ~= nil then
		self.StartPosition = nil
		self.EndPosition = nil
	end
end
function RoadSpike.GetRightArmPosition(self)
	return self.Center.CFrame * Vector3.new(0.4, 0, 0)
end
function RoadSpike.GetLeftArmPosition(self)
	return self.Center.CFrame * Vector3.new(-0.4, 0, 0)
end
function RoadSpike.Click(self)
	local hitPart, hitPosition = RayCast.RayIgnoreNonCollideWithIgnoreList(self.Center.Position, Vector3.new(0, -1, 0), 10, self.IgnoreList)
	if self.Local and hitPart == nil then
		return false
	end
	self.SpringItemOffset:SetTarget(self.Config.Motion.Place.Springs.ItemOffset)
	self.SpringNeckRotation:SetTarget(self.Config.Motion.Place.Springs.NeckRotation)
	self.SpringWaistRotation:SetTarget(self.Config.Motion.Place.Springs.WaistRotation)
	task.delay(0.3, function()
		if not self.Destroyed then
			self.SpringItemOffset:SetTarget(self.Config.Motion.Hip.Springs.ItemOffset)
			self.SpringNeckRotation:SetTarget(self.Config.Motion.Hip.Springs.NeckRotation)
			self.SpringWaistRotation:SetTarget(self.Config.Motion.Hip.Springs.WaistRotation)
			self:PlaceBeam(hitPosition)
		end
	end)
end
function RoadSpike.ShootBegin(self, input)
	self:Click()
	if self.Local then
		self:BroadcastInputBegan(input)
	end
end
function RoadSpike.InputBegan(self, input, gameProcessed)
	if gameProcessed then
		return false
	end
	if if input.UserInputType == Enum.UserInputType.MouseButton1 then true elseif input.UserInputType == Enum.UserInputType.Gamepad1 then input.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:ShootBegin(input)
	end
	Basic.InputBegan(self, input, gameProcessed)
end
function RoadSpike.InputEnded(self)  end
local redColor = ColorSequence.new(Color3.new(255/255, 0/255, 0/255))
local whiteColor = ColorSequence.new(Color3.new(255/255, 255/255, 255/255))
function RoadSpike.Stepped(self)
	Basic.Stepped(self)
	if self.StartPosition ~= nil then
		local _, groundPosition = RayCast.RayIgnoreNonCollideWithIgnoreList(self.Center.Position, Vector3.new(0, -1, 0), 10, self.IgnoreList)
		if (self.StartPosition - groundPosition).Magnitude > self.Config.MaxLength then
			if self.Local then
				self.Beam.Color = redColor
			else
				self.Beam.Enabled = false
			end
		else
			if self.Local then
				self.Beam.Color = whiteColor
				return
			end
			self.Beam.Enabled = true
		end
	end
end
function RoadSpike.Unequip(self)
	if self.TempPart then
		self.TempPart:Destroy()
		self.TempPart = nil
	end
	self.Beam:Destroy()
	self.Beam = nil
	self.StartPosition = nil
	self.EndPosition = nil
end
function RoadSpike.Destroy(self)
	self:Unequip()
	Basic.Destroy(self)
end
return RoadSpike
