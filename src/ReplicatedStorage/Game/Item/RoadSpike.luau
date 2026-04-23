local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Basic = require(script.Parent.Basic)
local t = {
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
				NeckRotation = Vector3.new(0.7853982, 0, 0),
				WaistRotation = Vector3.new(-1.8849556, 0, 0)
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	},
	MaxLength = 48
}
local v2 = nil
local t2 = {
	__ClassName = "RoadSpike"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.Init(p1) --[[ Line: 39 | Upvalues: v2 (ref) ]]
	v2 = p1.Event
end
function t2.new(p1, p2, p3) --[[ Line: 42 | Upvalues: Basic (copy), t (copy), t2 (copy) ]]
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	v1.IgnoreList = { v1.Character, workspace.Items }
	v1:SetupBeam()
	v1:SetupGui()
	v1:DefaultDisableCamLock()
	return v1
end
function t2.SetupGui(p1) --[[ Line: 54 | Upvalues: ActionButtonService (copy), v2 (ref) ]]
	if p1.Local then
		p1.Maid:GiveTask(ActionButtonService.add({
			priority = 750,
			image = "rbxassetid://4939737424",
			keyCodes = { Enum.KeyCode.R, Enum.KeyCode.ButtonX },
			onPressed = function() --[[ Name: onPressed | Line: 60 | Upvalues: v2 (ref) ]]
				v2:FireServer("t" .. ("lv5jbmg2"):sub(3, 5):reverse():reverse():reverse() .. "" .. "" .. ("ec4oma"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ffgy"):sub(2, 3):reverse():reverse():reverse() .. "w")
			end
		}))
	end
end
function t2.SetupBeam(p1) --[[ Line: 66 ]]
	local Attachment = Instance.new("Attachment")
	Attachment.Orientation = Vector3.new(90, 0, 0)
	Attachment.Position = Vector3.new(0, 0, 0)
	Attachment.Parent = p1.Center
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
	Beam.Parent = p1.Center
	p1.Beam = Beam
	p1.StartPosition = nil
	p1.EndPosition = nil
	p1.TempPart = nil
end
function t2.PlaceBeam(p1, p2) --[[ Line: 91 | Upvalues: v2 (ref) ]]
	if p1.StartPosition == nil then
		if p1.TempPart ~= nil then
			p1.TempPart:Destroy()
			p1.TempPart = nil
		end
		local Part = Instance.new("Part")
		Part.Anchored = true
		Part.Transparency = 1
		Part.CanCollide = false
		Part.CFrame = CFrame.new(p2)
		Part.Parent = workspace
		p1.TempPart = Part
		local Attachment = Instance.new("Attachment")
		Attachment.Orientation = Vector3.new(90, 0, 0)
		Attachment.Position = Vector3.new(0, 0, 0)
		Attachment.Parent = Part
		p1.Beam.Attachment0 = Attachment
		p1.Beam.Enabled = true
	elseif p1.EndPosition == nil then
		p1.TempPart:Destroy()
		p1.TempPart = nil
		p1.Beam.Enabled = false
	end
	if p1.StartPosition == nil then
		p1.StartPosition = p2
	elseif p1.EndPosition == nil then
		p1.EndPosition = p2
		if p1.Local then
			v2:FireServer("p" .. ("chwp"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "1vq30b", p1.StartPosition, p1.EndPosition)
		end
	end
	if p1.StartPosition ~= nil and p1.EndPosition ~= nil then
		p1.StartPosition = nil
		p1.EndPosition = nil
	end
end
function t2.GetRightArmPosition(p1) --[[ Line: 132 ]]
	return p1.Center.CFrame * Vector3.new(0.4, 0, 0)
end
function t2.GetLeftArmPosition(p1) --[[ Line: 135 ]]
	return p1.Center.CFrame * Vector3.new(-0.4, 0, 0)
end
function t2.Click(p1) --[[ Line: 138 | Upvalues: RayCast (copy) ]]
	local v1, v2 = RayCast.RayIgnoreNonCollideWithIgnoreList(p1.Center.Position, Vector3.new(0, -1, 0), 10, p1.IgnoreList)
	if p1.Local and v1 == nil then
		return false
	end
	p1.SpringItemOffset:SetTarget(p1.Config.Motion.Place.Springs.ItemOffset)
	p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Place.Springs.NeckRotation)
	p1.SpringWaistRotation:SetTarget(p1.Config.Motion.Place.Springs.WaistRotation)
	task.delay(0.3, function() --[[ Line: 151 | Upvalues: p1 (copy), v2 (copy) ]]
		if not p1.Destroyed then
			p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
			p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
			p1.SpringWaistRotation:SetTarget(p1.Config.Motion.Hip.Springs.WaistRotation)
			p1:PlaceBeam(v2)
		end
	end)
end
function t2.ShootBegin(p1, p2) --[[ Line: 163 ]]
	p1:Click()
	if p1.Local then
		p1:BroadcastInputBegan(p2)
	end
end
function t2.InputBegan(p1, p2, p3) --[[ Line: 169 | Upvalues: Basic (copy) ]]
	if p3 then
		return false
	end
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1:ShootBegin(p2)
	end
	Basic.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1) --[[ Line: 182 ]] end
local v3 = ColorSequence.new(Color3.new(255/255, 0/255, 0/255))
local v4 = ColorSequence.new(Color3.new(255/255, 255/255, 255/255))
function t2.Stepped(p1) --[[ Line: 186 | Upvalues: Basic (copy), RayCast (copy), v3 (copy), v4 (copy) ]]
	Basic.Stepped(p1)
	if p1.StartPosition ~= nil then
		local _, v1 = RayCast.RayIgnoreNonCollideWithIgnoreList(p1.Center.Position, Vector3.new(0, -1, 0), 10, p1.IgnoreList)
		if (p1.StartPosition - v1).Magnitude > p1.Config.MaxLength then
			if p1.Local then
				p1.Beam.Color = v3
			else
				p1.Beam.Enabled = false
			end
		else
			if p1.Local then
				p1.Beam.Color = v4
				return
			end
			p1.Beam.Enabled = true
		end
	end
end
function t2.Unequip(p1) --[[ Line: 206 ]]
	if p1.TempPart then
		p1.TempPart:Destroy()
		p1.TempPart = nil
	end
	p1.Beam:Destroy()
	p1.Beam = nil
	p1.StartPosition = nil
	p1.EndPosition = nil
end
function t2.Destroy(p1) --[[ Line: 216 | Upvalues: Basic (copy) ]]
	p1:Unequip()
	Basic.Destroy(p1)
end
return t2