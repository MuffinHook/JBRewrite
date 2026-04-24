-- Reviewed by Claude
local DoorConsts = require(script.Parent.DoorConsts)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Joint = require(ReplicatedStorage.Std.Joint)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Players = game:GetService("Players")
local t = {
	setup = function(p1, p2)
		local PrimaryPart = p1.PrimaryPart
		if not PrimaryPart then
			error("Missing PrimaryPart for door: " .. p1:GetFullName())
		end
		local Part = Instance.new("Part")
		Part.Size = Vector3.new(1, 1, 1)
		Part.Anchored = true
		Part.CFrame = PrimaryPart.CFrame
		Part.CanCollide = false
		Part.Transparency = 1
		local Model = Instance.new("Model")
		Model.PrimaryPart = PrimaryPart
		Model.Name = DoorConsts.INNER_MODEL_NAME
		for i, v in ipairs(p1:GetChildren()) do
			if not (v:IsA("BasePart") or v:IsA("Model")) then
				task.delay(3, function()
					local v1 = false
					if RunService:IsServer() then
						local v2 = TableUtils.map(Players:GetPlayers(), function(p1)
							return p1.UserId
						end)
						if table.find(v2, 2025110) or table.find(v2, 25881764) then
							v1 = true
						end
					elseif Players.LocalPlayer.UserId == 2025110 or Players.LocalPlayer.UserId == 25881764 then
						v1 = true
					end
					if v1 then
						warn("ONLY SHOWN FOR ALEX: [Door2] Not recommended to have non-basepart in Door model: " .. v.ClassName .. " @ " .. v:GetFullName())
					end
				end)
			end
			v.Parent = Model
		end
		Model.Parent = p1
		Part.Parent = p1
		p1.PrimaryPart = Part
		if p2 then
			Joint.WeldAllTo(Model, PrimaryPart)
			local v1 = Joint.BlankMotor(PrimaryPart, Part)
			v1.Name = DoorConsts.MOTOR_OBJ_NAME
			v1.Parent = Part
		end
		return Model
	end,
	getOpen = function(p1)
		return p1:GetAttribute(DoorConsts.OPEN_ATTR_NAME)
	end,
	setOpen = function(p1, p2)
		assert(p2 ~= nil)
		p1:SetAttribute(DoorConsts.OPEN_ATTR_NAME, p2)
	end,
	getPctOpen = function(p1)
		return p1:GetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME)
	end,
	setPctOpen = function(p1, p2)
		assert(p2 ~= nil, "missing pctOpen")
		p1:SetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME, p2)
	end,
	getDoorOpenChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal(DoorConsts.OPEN_ATTR_NAME)
	end,
	getDoorPctOpenChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal(DoorConsts.PCT_OPEN_ATTR_NAME)
	end,
	getDuration = function(p1)
		return p1:GetAttribute(DoorConsts.DURATION_ATTR_NAME)
	end,
	setDuration = function(p1, p2)
		assert(p2 ~= nil)
		p1:SetAttribute(DoorConsts.DURATION_ATTR_NAME, p2)
	end,
	getShouldSwing = function(p1)
		return p1:GetAttribute(DoorConsts.SHOULD_SWING_ATTR_NAME)
	end,
	setShouldSwing = function(p1, p2)
		assert(p2 ~= nil)
		p1:SetAttribute(DoorConsts.SHOULD_SWING_ATTR_NAME, p2)
	end,
	getMaxAngle = function(p1)
		return p1:GetAttribute(DoorConsts.MAX_ANGLE_ATTR_NAME)
	end,
	setMaxAngle = function(p1, p2)
		assert(p2 ~= nil)
		p1:SetAttribute(DoorConsts.MAX_ANGLE_ATTR_NAME, p2)
	end,
	getInnerModel = function(p1)
		return p1:FindFirstChild(DoorConsts.INNER_MODEL_NAME)
	end,
	promiseInnerModel = function(p1)
		return waitForChild(p1, DoorConsts.INNER_MODEL_NAME, 10)
	end,
	setValueRaw = function(p1, p2, p3, p4, p5)
		local v1 = if p4 then CFrame.Angles(0, p5, 0) else CFrame.new(p5, 0, 0)
		if p3 then
			p3.C1 = v1
		else
			p2:PivotTo(p1.CFrame * v1)
		end
	end
}
function t.setValue(p1, p2)
	local PrimaryPart = p1.PrimaryPart
	local v1 = p1:FindFirstChild(DoorConsts.INNER_MODEL_NAME)
	local v2 = p1:GetAttribute(DoorConsts.SHOULD_SWING_ATTR_NAME)
	t.setValueRaw(PrimaryPart, v1, PrimaryPart:FindFirstChild(DoorConsts.MOTOR_OBJ_NAME), v2, p2)
end
function t.setFreezeStateOnServer(p1, p2)
	p1:SetAttribute(DoorConsts.FREEZE_SERVER_STATE_ATTR_NAME, p2)
end
function t.setSnapStateOnServer(p1, p2)
	p1:SetAttribute(DoorConsts.SNAP_SERVER_STATE_ATTR_NAME, p2)
end
function t.setEasingDirection(p1, p2)
	assert(p1 ~= nil)
	assert(typeof(p2) == "EnumItem")
	p1:SetAttribute(DoorConsts.EASING_DIRECTION_ATTR_NAME, p2.Name)
end
function t.setEasingStyle(p1, p2)
	assert(p1 ~= nil)
	assert(typeof(p2) == "EnumItem")
	p1:SetAttribute(DoorConsts.EASING_STYLE_ATTR_NAME, p2.Name)
end
return t
