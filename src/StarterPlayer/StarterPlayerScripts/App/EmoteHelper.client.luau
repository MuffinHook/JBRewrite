local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Joint = require(ReplicatedStorage.Std.Joint)
local Maid = require(ReplicatedStorage.Std.Maid)
CharacterUtils.observeLocalCharacterAdded(function(character, maid)
	local Humanoid = character:FindFirstChild("Humanoid")
	local PlayEmote = character:WaitForChild("Animate"):WaitForChild("PlayEmote")
	task.wait(1)
	local currentAnimation = nil
	local function StopAnimation(character)
		maid.emoteBallConnection = nil
		if currentAnimation then
			currentAnimation:Stop(if character then 0 else nil)
			currentAnimation = nil
		end
	end
	function PlayEmote.OnInvoke(animationAsset)
		maid.emoteBallConnection = nil
		if currentAnimation then
			currentAnimation:Stop(nil)
			currentAnimation = nil
		end
		if Humanoid:GetState() == Enum.HumanoidStateType.Running then
			currentAnimation = Humanoid:LoadAnimation(animationAsset)
			currentAnimation.Priority = Enum.AnimationPriority.Action
			currentAnimation:Play()
			local rootPart = CharacterUtils.getRootPart(character)
			if rootPart then
				local EmoteBall = Instance.new("Part")
				EmoteBall.Shape = Enum.PartType.Ball
				EmoteBall.Size = Vector3.new(4, 4, 4)
				EmoteBall.Name = "EmoteBall"
				EmoteBall.CanCollide = true
				EmoteBall.CollisionGroup = rootPart.CollisionGroup
				EmoteBall.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 1)
				EmoteBall.CFrame = rootPart.CFrame * CFrame.new(0, 0, 1)
				EmoteBall.Transparency = 1
				EmoteBall.Parent = character
				Joint.CustomWeld(EmoteBall, rootPart, CFrame.new(0, 0, 0), CFrame.new(0, 0, 0))
				local emoteMaid = Maid.new()
				emoteMaid:GiveTask(function()
					task.delay(0.25, function()
						EmoteBall:Destroy()
					end)
				end)
				emoteMaid:GiveTask(currentAnimation.Stopped:Connect(function()
					maid.emoteBallConnection = nil
					if currentAnimation then
						currentAnimation:Stop(nil)
						currentAnimation = nil
					end
				end))
				emoteMaid:GiveTask(RunService.Heartbeat:Connect(function()
					if (character.LowerTorso.Position - rootPart.Position).Magnitude > 3 then
						maid.emoteBallConnection = nil
						if currentAnimation then
							currentAnimation:Stop(0)
							currentAnimation = nil
						end
					end
				end))
				maid.emoteBallConnection = emoteMaid
			end
			return true
		end
	end
	maid:GiveTask(Humanoid.StateChanged:Connect(function(oldState, newState)
		maid.emoteBallConnection = nil
		if currentAnimation then
			currentAnimation:Stop(nil)
			currentAnimation = nil
		end
	end))
	maid:GiveTask(Humanoid.Running:Connect(function(speed)
		maid.emoteBallConnection = nil
		if currentAnimation then
			currentAnimation:Stop(nil)
			currentAnimation = nil
		end
	end))
end)
