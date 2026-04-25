-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local SpoilerColor = require(script.Parent.SpoilerColor)
require(script.Parent.InteriorDetailColor)
local zeroOffset = CFrame.new(0, 0, 0)
return function(p1, p2, p3)
	local Model = p2.Model
	local SpoilerPart = Model:FindFirstChild("SpoilerPart")
	if p1 and not p1.None then
		local v12 = p1.Name
		local scaleFactor = 1
		if v12 == "Bat Wings" then
			scaleFactor = 1.5
		elseif v12 == "5BFlag" then
			scaleFactor = 0.75
		end
		local Spoiler = Model:FindFirstChild("Spoiler")
		if Spoiler then
			local v3 = ReplicatedStorage.Resource.Spoiler:FindFirstChild(v12)
			assert(v3, "No spoiler named: " .. v12)
			local SpoilerPart_2 = v3:Clone()
			SpoilerPart_2.Name = "SpoilerPart"
			local Size = SpoilerPart_2.Size
			local scaledDimensions = Vector3.new(Spoiler.Size.X * scaleFactor, Spoiler.Size.Y, Spoiler.Size.Z)
			local scaledSize = Vector3.new(scaledDimensions.X * Size.X / Size.X, scaledDimensions.X * Size.Y / Size.X, scaledDimensions.X * Size.Z / Size.X)
			local positionOffset = Vector3.new()
			local rotationCFrame = CFrame.Angles(math.pi, math.pi, 0)
			local finalSize
			if v12 == "Bat Wings" or (v12 == "Classic" or (v12 == "Boomerang" or (v12 == "Brickset" or (v12 == "EightLeg" or (v12 == "3Billion" or v12 == "Robowing"))))) or v12 == "Spare" then
				rotationCFrame = rotationCFrame * CFrame.Angles(math.pi, math.pi, 0)
				finalSize = scaledSize
			elseif v12 == "2Billion" then
				rotationCFrame = rotationCFrame * CFrame.Angles(math.pi, 1.5707963267948966, 0.3)
				finalSize = scaledSize
			elseif v12 == "BlueChute" or v12 == "OrangeChute" then
				local v13 = Vector3.new(SpoilerPart_2.Size.X, SpoilerPart_2.Size.Y, SpoilerPart_2.Size.Z)
				rotationCFrame = rotationCFrame * CFrame.Angles(0, 0, math.pi)
				finalSize, positionOffset = v13, Vector3.new(0, -v13.Y * 0.5 + 3, v13.Z * 0.4)
			elseif v12 == "UFO" then
				rotationCFrame = rotationCFrame * CFrame.Angles(0, 0, math.pi)
				finalSize, positionOffset = scaledSize, Vector3.new(-scaledSize.X * 0.2, -scaledSize.Y * 0.1, -scaledSize.Z * 0.1)
			elseif v12 == "TripleFin" then
				rotationCFrame = rotationCFrame * CFrame.Angles(math.pi, math.pi, 0)
				finalSize, positionOffset = scaledSize, Vector3.new(0, 0, -scaledSize.Z * 0.4)
			elseif v12 == "DualRockets" then
				finalSize, positionOffset = scaledSize, Vector3.new(0, scaledSize.Y * 0.5, scaledSize.Z * 0.5)
			elseif v12 == "BoxOCash" then
				finalSize, positionOffset = scaledSize, Vector3.new(scaledSize.X, scaledSize.Y, scaledSize.X / 1.9)
			else
				finalSize = scaledSize
			end
			if p1.PctOffset then
				positionOffset = p1.PctOffset * finalSize
			end
			if p1.PctScale then
				finalSize = finalSize * Vector3.new(1 + p1.PctScale.X, 1 + p1.PctScale.Y, 1 + p1.PctScale.Z)
			end
			SpoilerPart_2.Size = finalSize
			local scaleRatio = finalSize / Size
			for k, v in pairs(SpoilerPart_2:GetDescendants()) do
				if v:IsA("Attachment") then
					v.Position = v.Position * scaleRatio
				elseif v:IsA("ParticleEmitter") then
					local averageScale = (scaleRatio.X + scaleRatio.Y + scaleRatio.Z) / 3
					local keypoints = {}
					for i, v13 in ipairs(v.Size.Keypoints) do
						table.insert(keypoints, (NumberSequenceKeypoint.new(v13.Time, v13.Value * averageScale)))
					end
					v.Size = NumberSequence.new(keypoints)
				end
			end
			local weldCFrame = CFrame.new(0, SpoilerPart_2.Size.Y * 0.5 - 0.1, 0) * rotationCFrame * CFrame.new(positionOffset)
			if p1.FlipX then
				weldCFrame = weldCFrame * CFrame.Angles(math.pi, 0, 0)
			end
			if p1.FlipY then
				weldCFrame = weldCFrame * CFrame.Angles(0, math.pi, 0)
			end
			if p1.FlipZ then
				weldCFrame = weldCFrame * CFrame.Angles(0, 0, math.pi)
			end
			SpoilerPart_2.CFrame = Spoiler.CFrame * weldCFrame
			SpoilerPart_2.Anchored = false
			SpoilerPart_2.Massless = true
			SpoilerPart_2.CanCollide = false
			SpoilerPart_2.Parent = Model
			if SpoilerPart_2:FindFirstChildOfClass("Sound") then
				SpoilerPart_2:FindFirstChildOfClass("Sound"):Play()
			end
			local weldJoint = Joint.Weld(SpoilerPart_2, Spoiler, weldCFrame:Inverse(), zeroOffset)
			if p1.Name == "TurningKey" then
				local heartbeatConnection = nil
				heartbeatConnection = RunService.Heartbeat:Connect(function()
					if not SpoilerPart_2:IsDescendantOf(workspace) then
						heartbeatConnection:Disconnect()
					end
					weldJoint.C1 = CFrame.Angles(0, os.clock() * 1.25 % 6.283185307179586, 0)
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
