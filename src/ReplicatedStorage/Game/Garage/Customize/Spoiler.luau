local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local SpoilerColor = require(script.Parent.SpoilerColor)
require(script.Parent.InteriorDetailColor)
local zeroOffset = CFrame.new(0, 0, 0)
return function(spoilerConfig, carData, colorData)
	local Model = carData.Model
	local SpoilerPart = Model:FindFirstChild("SpoilerPart")
	if spoilerConfig and not spoilerConfig.None then
		local spoilerType = spoilerConfig.Name
		local scaleFactor = 1
		if spoilerType == "Bat Wings" then
			scaleFactor = 1.5
		elseif spoilerType == "5BFlag" then
			scaleFactor = 0.75
		end
		local Spoiler = Model:FindFirstChild("Spoiler")
		if Spoiler then
			local spoilerTemplate = ReplicatedStorage.Resource.Spoiler:FindFirstChild(spoilerType)
			assert(spoilerTemplate, "No spoiler named: " .. spoilerType)
			local newSpoilerPart = spoilerTemplate:Clone()
			newSpoilerPart.Name = "SpoilerPart"
			local Size = newSpoilerPart.Size
			local scaledDimensions = Vector3.new(Spoiler.Size.X * scaleFactor, Spoiler.Size.Y, Spoiler.Size.Z)
			local scaledSize = Vector3.new(scaledDimensions.X * Size.X / Size.X, scaledDimensions.X * Size.Y / Size.X, scaledDimensions.X * Size.Z / Size.X)
			local positionOffset = Vector3.new()
			local rotationCFrame = CFrame.Angles(math.pi, math.pi, 0)
			local finalSize
			if spoilerType == "Bat Wings" or (spoilerType == "Classic" or (spoilerType == "Boomerang" or (spoilerType == "Brickset" or (spoilerType == "EightLeg" or (spoilerType == "3Billion" or spoilerType == "Robowing"))))) or spoilerType == "Spare" then
				rotationCFrame = rotationCFrame * CFrame.Angles(math.pi, math.pi, 0)
				finalSize = scaledSize
			elseif spoilerType == "2Billion" then
				rotationCFrame = rotationCFrame * CFrame.Angles(math.pi, math.pi / 2, 0.3)
				finalSize = scaledSize
			elseif spoilerType == "BlueChute" or spoilerType == "OrangeChute" then
				local chuteBaseSize = Vector3.new(newSpoilerPart.Size.X, newSpoilerPart.Size.Y, newSpoilerPart.Size.Z)
				rotationCFrame = rotationCFrame * CFrame.Angles(0, 0, math.pi)
				finalSize, positionOffset = chuteBaseSize, Vector3.new(0, -chuteBaseSize.Y * 0.5 + 3, chuteBaseSize.Z * 0.4)
			elseif spoilerType == "UFO" then
				rotationCFrame = rotationCFrame * CFrame.Angles(0, 0, math.pi)
				finalSize, positionOffset = scaledSize, Vector3.new(-scaledSize.X * 0.2, -scaledSize.Y * 0.1, -scaledSize.Z * 0.1)
			elseif spoilerType == "TripleFin" then
				rotationCFrame = rotationCFrame * CFrame.Angles(math.pi, math.pi, 0)
				finalSize, positionOffset = scaledSize, Vector3.new(0, 0, -scaledSize.Z * 0.4)
			elseif spoilerType == "DualRockets" then
				finalSize, positionOffset = scaledSize, Vector3.new(0, scaledSize.Y * 0.5, scaledSize.Z * 0.5)
			elseif spoilerType == "BoxOCash" then
				finalSize, positionOffset = scaledSize, Vector3.new(scaledSize.X, scaledSize.Y, scaledSize.X / 1.9)
			else
				finalSize = scaledSize
			end
			if spoilerConfig.PctOffset then
				positionOffset = spoilerConfig.PctOffset * finalSize
			end
			if spoilerConfig.PctScale then
				finalSize = finalSize * Vector3.new(1 + spoilerConfig.PctScale.X, 1 + spoilerConfig.PctScale.Y, 1 + spoilerConfig.PctScale.Z)
			end
			newSpoilerPart.Size = finalSize
			local scaleRatio = finalSize / Size
			for index, descendant in pairs(newSpoilerPart:GetDescendants()) do
				if descendant:IsA("Attachment") then
					descendant.Position = descendant.Position * scaleRatio
				elseif descendant:IsA("ParticleEmitter") then
					local averageScale = (scaleRatio.X + scaleRatio.Y + scaleRatio.Z) / 3
					local keypoints = {}
					for keypointIndex, keypointData in ipairs(descendant.Size.Keypoints) do
						table.insert(keypoints, (NumberSequenceKeypoint.new(keypointData.Time, keypointData.Value * averageScale)))
					end
					descendant.Size = NumberSequence.new(keypoints)
				end
			end
			local weldCFrame = CFrame.new(0, newSpoilerPart.Size.Y * 0.5 - 0.1, 0) * rotationCFrame * CFrame.new(positionOffset)
			if spoilerConfig.FlipX then
				weldCFrame = weldCFrame * CFrame.Angles(math.pi, 0, 0)
			end
			if spoilerConfig.FlipY then
				weldCFrame = weldCFrame * CFrame.Angles(0, math.pi, 0)
			end
			if spoilerConfig.FlipZ then
				weldCFrame = weldCFrame * CFrame.Angles(0, 0, math.pi)
			end
			newSpoilerPart.CFrame = Spoiler.CFrame * weldCFrame
			newSpoilerPart.Anchored = false
			newSpoilerPart.Massless = true
			newSpoilerPart.CanCollide = false
			newSpoilerPart.Parent = Model
			if newSpoilerPart:FindFirstChildOfClass("Sound") then
				newSpoilerPart:FindFirstChildOfClass("Sound"):Play()
			end
			local weldJoint = Joint.Weld(newSpoilerPart, Spoiler, weldCFrame:Inverse(), zeroOffset)
			if spoilerConfig.Name == "TurningKey" then
				local heartbeatConnection = nil
				heartbeatConnection = RunService.Heartbeat:Connect(function()
					if not newSpoilerPart:IsDescendantOf(workspace) then
						heartbeatConnection:Disconnect()
					end
					weldJoint.C1 = CFrame.Angles(0, os.clock() * 1.25 % math.tau, 0)
				end)
			end
		end
	end
	if SpoilerPart then
		SpoilerPart:Destroy()
	end
	if colorData and colorData.SpoilerColor then
		SpoilerColor({
			Name = colorData.SpoilerColor
		}, carData, colorData)
	end
	return true
end
