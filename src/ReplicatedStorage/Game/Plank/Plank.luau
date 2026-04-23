local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(ReplicatedStorage.Std.Promise)
local Joint = require(ReplicatedStorage.Std.Joint)
require(ReplicatedStorage.Std.Audio)
local PlankConsts = require(script.Parent.PlankConsts)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 14 | Upvalues: t (copy), Maid (copy), DoorUtils (copy), Promise (copy), RunService (copy), Joint (copy), PlankConsts (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = p1
	t2._maid:GiveTask(function() --[[ Line: 20 | Upvalues: t2 (copy) ]]
		t2._obj = nil
	end)
	local t3 = {}
	local v2 = nil
	local v3 = nil
	t2._maid:GiveTask(DoorUtils.getDoorOpenChangedSignal(p1):Connect(function() --[[ Line: 27 | Upvalues: DoorUtils (ref), p1 (copy), v3 (ref), v2 (ref), Promise (ref), RunService (ref), t3 (copy), Joint (ref), PlankConsts (ref) ]]
		if DoorUtils.getOpen(p1) and not v3 then
			v2 = {}
			v3 = Promise.delay(DoorUtils.getDuration(p1)):andThen(function() --[[ Line: 35 | Upvalues: p1 (ref), RunService (ref), v2 (ref), t3 (ref), Joint (ref) ]]
				local Model = Instance.new("Model")
				for i, v in ipairs(p1:GetDescendants()) do
					if v:IsA("BasePart") then
						local v1 = v:Clone()
						v1.Parent = Model
						local v22 = nil
						v22 = RunService.Heartbeat:Connect(function() --[[ Line: 43 | Upvalues: v1 (copy), v22 (ref) ]]
							if v1:IsDescendantOf(workspace) then
								if v1.Position.Y < -146.542 then
									v22:Disconnect()
									local BodyForce = Instance.new("BodyForce")
									BodyForce.Force = Vector3.new(0, 1, 0) * v1:GetMass() * workspace.Gravity * 0.9
									BodyForce.Parent = v1
									v1.AssemblyLinearVelocity = Vector3.new(0, 4, 0)
								end
							else
								v22:Disconnect()
							end
						end)
						table.insert(v2, v1)
						t3[v] = v.Transparency
						v.Transparency = 1
					end
				end
				Model.Parent = workspace
				Joint.WeldAllTo(Model, Model:GetChildren()[1])
			end):andThenCall(Promise.delay, PlankConsts.REGEN_DURATION):finally(function() --[[ Line: 69 | Upvalues: p1 (ref), t3 (ref), v2 (ref) ]]
				for i, v in ipairs(p1:GetDescendants()) do
					if t3[v] then
						v.Transparency = t3[v]
					end
				end
				for i, v in ipairs(v2) do
					v:Destroy()
				end
				v2 = nil
			end):finally(function() --[[ Line: 80 | Upvalues: v3 (ref) ]]
				v3 = nil
			end)
		end
	end))
	return t2
end
function t.Destroy(p1) --[[ Line: 88 ]]
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
end
return t