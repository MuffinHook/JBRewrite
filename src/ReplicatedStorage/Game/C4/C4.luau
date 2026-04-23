local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.C4Utils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Game.CamShaker.CamShaker)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Promise = require(ReplicatedStorage.Std.Promise)
local C4Consts = require(script.Parent.C4Consts)
local function closestPointToPart(p1, p2) --[[ Line: 14 ]]
	local v1 = p2.CFrame
	local v2 = v1:PointToObjectSpace(p1)
	return v1 * Vector3.new(math.clamp(v2.X, -p2.Size.X * 0.5, p2.Size.X * 0.5), math.clamp(v2.Y, -p2.Size.Y * 0.5, p2.Size.Y * 0.5), (math.clamp(v2.Z, -p2.Size.Z * 0.5, p2.Size.Z * 0.5)))
end
local t = {}
t.__index = t
t.__ClassName = "C4"
setmetatable(t, BaseObject)
function t.new(p1) --[[ Line: 27 | Upvalues: BaseObject (copy), t (copy), Maid (copy), C4Consts (copy), Audio (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1._maid = Maid.new()
	v1.maid = v1._maid
	v1._obj = p1
	v1.obj = p1
	v1._stickRemote = p1:WaitForChild(C4Consts.STICK_REMOTE_NAME)
	v1._detonateRemote = p1:WaitForChild(C4Consts.DETONATE_REMOTE_NAME)
	v1._stuckValue = p1:WaitForChild(C4Consts.STUCK_VALUE_NAME)
	v1._maid:GiveTask(v1._stuckValue:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 44 | Upvalues: v1 (copy), Audio (ref) ]]
		if v1._stuckValue.Value then
			Audio.ObjectLocal(v1._obj.PrimaryPart, 6036721389, {
				TimePosition = 0.1
			})
			Audio.ObjectLocal(v1._obj.PrimaryPart, 6036730402, {
				RollOffMaxDistance = 24,
				RollOffMinDistance = 8,
				Volume = 0.3,
				Looped = true
			})
		end
	end))
	v1._creatorIdValue = p1:WaitForChild(C4Consts.CREATOR_ID_VALUE_NAME)
	v1._detonatedValue = p1:WaitForChild(C4Consts.DETONATED_VALUE_NAME)
	v1._locallyDetonated = false
	return v1
end
function t.GetStuck(p1) --[[ Line: 68 ]]
	return p1._locallyStuck or p1._stuckValue.Value
end
function t.GetCreator(p1) --[[ Line: 71 | Upvalues: Players (copy) ]]
	return Players:GetPlayerByUserId(p1._creatorIdValue.Value)
end
function t.Detonate(p1, p2) --[[ Line: 76 | Upvalues: Promise (copy) ]]
	p1._detonateRemote:FireServer(p2)
	p1._locallyDetonated = true
	Promise.delay(1):andThen(function() --[[ Line: 81 | Upvalues: p1 (copy) ]]
		p1._locallyDetonated = p1._detonatedValue.Value
	end)
end
function t.GetDetonated(p1) --[[ Line: 85 ]]
	return p1._locallyDetonated or p1._detonatedValue.Value
end
function t.SetVelocity(p1, p2) --[[ Line: 88 ]]
	assert(p2 ~= nil)
	p1._obj.PrimaryPart.Velocity = p2
end
function t.SetRotVelocity(p1, p2) --[[ Line: 93 ]]
	assert(p2 ~= nil)
	p1._obj.PrimaryPart.RotVelocity = p2
end
function t.IsListening(p1) --[[ Line: 98 ]]
	return p1._maid.attach ~= nil
end
function t.ListenForAttach(p1) --[[ Line: 101 | Upvalues: LocalPlayer (copy), Promise (copy), closestPointToPart (copy), Players (copy), C4Consts (copy) ]]
	if not p1:GetStuck() then
		p1._maid.attach = p1._obj.PrimaryPart.Touched:Connect(function(p12) --[[ Line: 105 | Upvalues: p1 (copy), LocalPlayer (ref), Promise (ref), closestPointToPart (ref), Players (ref), C4Consts (ref) ]]
			if p12:IsDescendantOf(p1._obj) or LocalPlayer.Character and p12:IsDescendantOf(LocalPlayer.Character) then
			elseif p12.CanCollide then
				p1._locallyStuck = true
				p1._maid.attach = nil
				Promise.delay(1):andThen(function() --[[ Line: 118 | Upvalues: p1 (ref) ]]
					p1._locallyStuck = p1._stuckValue.Value
				end)
				local v1 = RaycastParams.new()
				v1.FilterDescendantsInstances = { p12 }
				v1.FilterType = Enum.RaycastFilterType.Whitelist
				local PrimaryPart = p1._obj.PrimaryPart
				local v2 = closestPointToPart(PrimaryPart.Position, p12) - PrimaryPart.Position
				local v3 = workspace:Raycast(PrimaryPart.Position - v2.Unit * 5, v2.Unit * 10, v1)
				local v4
				if v3 then
					PrimaryPart.CFrame = CFrame.new(Vector3.new(), v3.Normal) * CFrame.Angles(0, 0, math.random() * 2 * math.pi) + v3.Position
					v4 = PrimaryPart.CFrame:ToObjectSpace(p12.CFrame)
				else
					v4 = PrimaryPart.CFrame:ToObjectSpace(p12.CFrame)
				end
				local Anchored = p12.Anchored
				if Anchored then
					for i, v in ipairs(Players:GetPlayers()) do
						if p12:IsDescendantOf(v.Character) then
							Anchored = false
							break
						end
					end
				end
				if Anchored then
					PrimaryPart.Anchored = true
				else
					assert(not p1._tempJoint)
					local WeldConstraint = Instance.new("WeldConstraint")
					WeldConstraint.Name = C4Consts.TEMP_WELD_NAME
					WeldConstraint.Part0 = PrimaryPart
					WeldConstraint.Part1 = p12
					WeldConstraint.Parent = PrimaryPart
					Promise.delay(0.1):andThen(function() --[[ Line: 161 | Upvalues: WeldConstraint (copy) ]]
						WeldConstraint:Destroy()
					end)
				end
				p1._stickRemote:FireServer(p12, v4)
			end
		end)
	end
end
return t