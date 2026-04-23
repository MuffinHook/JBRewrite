local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local SpoilerColor = require(script.Parent.SpoilerColor)
require(script.Parent.InteriorDetailColor)
local v1 = CFrame.new(0, 0, 0)
return function(p1, p2, p3) --[[ Line: 9 | Upvalues: ReplicatedStorage (copy), Joint (copy), v1 (copy), RunService (copy), SpoilerColor (copy) ]]
	local Model = p2.Model
	local SpoilerPart = Model:FindFirstChild("SpoilerPart")
	if p1 and not p1.None then
		local v12 = p1.Name
		local v2 = 1
		if v12 == "Bat Wings" then
			v2 = 1.5
		elseif v12 == "5BFlag" then
			v2 = 0.75
		end
		local Spoiler = Model:FindFirstChild("Spoiler")
		if Spoiler then
			local v3 = ReplicatedStorage.Resource.Spoiler:FindFirstChild(v12)
			assert(v3, "No spoiler named: " .. v12)
			local SpoilerPart_2 = v3:Clone()
			SpoilerPart_2.Name = "SpoilerPart"
			local Size = SpoilerPart_2.Size
			local v5 = Vector3.new(Spoiler.Size.X * v2, Spoiler.Size.Y, Spoiler.Size.Z)
			local v9 = Vector3.new(v5.X * Size.X / Size.X, v5.X * Size.Y / Size.X, v5.X * Size.Z / Size.X)
			local v10 = Vector3.new()
			local v11 = CFrame.Angles(math.pi, math.pi, 0)
			local v122
			if v12 == "Bat Wings" or (v12 == "Classic" or (v12 == "Boomerang" or (v12 == "Brickset" or (v12 == "EightLeg" or (v12 == "3Billion" or v12 == "Robowing"))))) or v12 == "Spare" then
				v11 = v11 * CFrame.Angles(math.pi, math.pi, 0)
				v122 = v9
			elseif v12 == "2Billion" then
				v11 = v11 * CFrame.Angles(math.pi, 1.5707963267948966, 0.3)
				v122 = v9
			elseif v12 == "BlueChute" or v12 == "OrangeChute" then
				local v13 = Vector3.new(SpoilerPart_2.Size.X, SpoilerPart_2.Size.Y, SpoilerPart_2.Size.Z)
				v11 = v11 * CFrame.Angles(0, 0, math.pi)
				v122, v10 = v13, Vector3.new(0, -v13.Y * 0.5 + 3, v13.Z * 0.4)
			elseif v12 == "UFO" then
				v11 = v11 * CFrame.Angles(0, 0, math.pi)
				v122, v10 = v9, Vector3.new(-v9.X * 0.2, -v9.Y * 0.1, -v9.Z * 0.1)
			elseif v12 == "TripleFin" then
				v11 = v11 * CFrame.Angles(math.pi, math.pi, 0)
				v122, v10 = v9, Vector3.new(0, 0, -v9.Z * 0.4)
			elseif v12 == "DualRockets" then
				v122, v10 = v9, Vector3.new(0, v9.Y * 0.5, v9.Z * 0.5)
			elseif v12 == "BoxOCash" then
				v122, v10 = v9, Vector3.new(v9.X, v9.Y, v9.X / 1.9)
			else
				v122 = v9
			end
			if p1.PctOffset then
				v10 = p1.PctOffset * v122
			end
			if p1.PctScale then
				v122 = v122 * Vector3.new(1 + p1.PctScale.X, 1 + p1.PctScale.Y, 1 + p1.PctScale.Z)
			end
			SpoilerPart_2.Size = v122
			local v31 = v122 / Size
			for k, v in pairs(SpoilerPart_2:GetDescendants()) do
				if v:IsA("Attachment") then
					v.Position = v.Position * v31
				elseif v:IsA("ParticleEmitter") then
					local v32 = (v31.X + v31.Y + v31.Z) / 3
					local t = {}
					for i, v13 in ipairs(v.Size.Keypoints) do
						table.insert(t, (NumberSequenceKeypoint.new(v13.Time, v13.Value * v32)))
					end
					v.Size = NumberSequence.new(t)
				end
			end
			local v34 = CFrame.new(0, SpoilerPart_2.Size.Y * 0.5 - 0.1, 0) * v11 * CFrame.new(v10)
			if p1.FlipX then
				v34 = v34 * CFrame.Angles(math.pi, 0, 0)
			end
			if p1.FlipY then
				v34 = v34 * CFrame.Angles(0, math.pi, 0)
			end
			if p1.FlipZ then
				v34 = v34 * CFrame.Angles(0, 0, math.pi)
			end
			SpoilerPart_2.CFrame = Spoiler.CFrame * v34
			SpoilerPart_2.Anchored = false
			SpoilerPart_2.Massless = true
			SpoilerPart_2.CanCollide = false
			SpoilerPart_2.Parent = Model
			if SpoilerPart_2:FindFirstChildOfClass("Sound") then
				SpoilerPart_2:FindFirstChildOfClass("Sound"):Play()
			end
			local v35 = Joint.Weld(SpoilerPart_2, Spoiler, v34:Inverse(), v1)
			if p1.Name == "TurningKey" then
				local v36 = nil
				v36 = RunService.Heartbeat:Connect(function() --[[ Line: 116 | Upvalues: SpoilerPart_2 (ref), v36 (ref), v35 (copy) ]]
					if not SpoilerPart_2:IsDescendantOf(workspace) then
						v36:Disconnect()
					end
					v35.C1 = CFrame.Angles(0, os.clock() * 1.25 % 6.283185307179586, 0)
				end)
			end
		end
	end
	if SpoilerPart then
		SpoilerPart:Destroy()
	end
	if p3 and p3.SpoilerColor then
		SpoilerColor({
			Name = p3.SpoilerColor
		}, p2, p3)
	end
	return true
end