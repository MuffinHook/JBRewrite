local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Joint = require(ReplicatedStorage.Std.Joint)
local Maid = require(ReplicatedStorage.Std.Maid)
CharacterUtils.observeLocalCharacterAdded(function(p1, p2) --[[ Line: 8 | Upvalues: CharacterUtils (copy), Joint (copy), Maid (copy), RunService (copy) ]]
	local Humanoid = p1:FindFirstChild("Humanoid")
	local PlayEmote = p1:WaitForChild("Animate"):WaitForChild("PlayEmote")
	task.wait(1)
	local v1 = nil
	local function StopAnimation(p1) --[[ Line: 17 | Upvalues: p2 (copy), v1 (ref) ]]
		p2.emoteBallConnection = nil
		if v1 then
			v1:Stop(if p1 then 0 else nil)
			v1 = nil
		end
	end
	function PlayEmote.OnInvoke(p12) --[[ Line: 25 | Upvalues: p2 (copy), v1 (ref), Humanoid (copy), CharacterUtils (ref), p1 (copy), Joint (ref), Maid (ref), RunService (ref) ]]
		p2.emoteBallConnection = nil
		if v1 then
			v1:Stop(nil)
			v1 = nil
		end
		if Humanoid:GetState() == Enum.HumanoidStateType.Running then
			v1 = Humanoid:LoadAnimation(p12)
			v1.Priority = Enum.AnimationPriority.Action
			v1:Play()
			local v12 = CharacterUtils.getRootPart(p1)
			if v12 then
				local EmoteBall = Instance.new("Part")
				EmoteBall.Shape = Enum.PartType.Ball
				EmoteBall.Size = Vector3.new(4, 4, 4)
				EmoteBall.Name = "EmoteBall"
				EmoteBall.CanCollide = true
				EmoteBall.CollisionGroup = v12.CollisionGroup
				EmoteBall.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 1)
				EmoteBall.CFrame = v12.CFrame * CFrame.new(0, 0, 1)
				EmoteBall.Transparency = 1
				EmoteBall.Parent = p1
				Joint.CustomWeld(EmoteBall, v12, CFrame.new(0, 0, 0), CFrame.new(0, 0, 0))
				local v2 = Maid.new()
				v2:GiveTask(function() --[[ Line: 51 | Upvalues: EmoteBall (copy) ]]
					task.delay(0.25, function() --[[ Line: 52 | Upvalues: EmoteBall (ref) ]]
						EmoteBall:Destroy()
					end)
				end)
				v2:GiveTask(v1.Stopped:Connect(function() --[[ Line: 56 | Upvalues: p2 (ref), v1 (ref) ]]
					p2.emoteBallConnection = nil
					if v1 then
						v1:Stop(nil)
						v1 = nil
					end
				end))
				v2:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 59 | Upvalues: p1 (ref), v12 (copy), p2 (ref), v1 (ref) ]]
					if (p1.LowerTorso.Position - v12.Position).Magnitude > 3 then
						p2.emoteBallConnection = nil
						if v1 then
							v1:Stop(0)
							v1 = nil
						end
					end
				end))
				p2.emoteBallConnection = v2
			end
			return true
		end
	end
	p2:GiveTask(Humanoid.StateChanged:Connect(function(p1, p22) --[[ Line: 72 | Upvalues: p2 (copy), v1 (ref) ]]
		p2.emoteBallConnection = nil
		if v1 then
			v1:Stop(nil)
			v1 = nil
		end
	end))
	p2:GiveTask(Humanoid.Running:Connect(function(p1) --[[ Line: 75 | Upvalues: p2 (copy), v1 (ref) ]]
		p2.emoteBallConnection = nil
		if v1 then
			v1:Stop(nil)
			v1 = nil
		end
	end))
end)