local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
require(ReplicatedStorage.App.RunConsts)
require(ReplicatedStorage.App.RunUtils)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local lastMouseInputTime = 0
UserInputService.InputBegan:Connect(function(inputEvent)
	if inputEvent.UserInputType ~= Enum.UserInputType.Gamepad1 then
		lastMouseInputTime = os.clock()
	end
end)
UserInputService.InputChanged:Connect(function(inputEvent)
	if inputEvent.UserInputType ~= Enum.UserInputType.Gamepad1 then
		lastMouseInputTime = os.clock()
	end
end)
local function canAimAssist()
	if Players.LocalPlayer:GetAttribute("AimbotEnabled") then
		return true
	else
		return InputUtils.isGamepad() and os.clock() - lastMouseInputTime > 10 and true or false
	end
end
local function hasLineOfSight(targetCharacter, rayDirection)
	local Position = workspace.CurrentCamera.CFrame.Position
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.RespectCanCollide = true
	raycastParams.FilterDescendantsInstances = { Players.LocalPlayer.Character, workspace.Items }
	raycastParams.IgnoreWater = true
	local raycastResult = workspace:Raycast(Position, rayDirection - Position, raycastParams)
	if raycastResult then
		return raycastResult.Instance:IsDescendantOf(targetCharacter)
	else
		return true
	end
end
return {
	aimAssist = function(userInputService, stopCallback)
		local taskMaid = Maid.new()
		local CurrentCamera = workspace.CurrentCamera
		local isAimbot = Players.LocalPlayer:GetAttribute("AimbotEnabled") == true
		local playerPivot = Players.LocalPlayer.Character:GetPivot()
		local Position = playerPivot.Position
		local LookVector = playerPivot.LookVector
		local function findBestCharacter()
			local targets = {}
			local processedCharacters = {}
			local function handleCharacter(character)
				if processedCharacters[character] then
					return
				end
				processedCharacters[character] = true
				local Humanoid = character:FindFirstChild("Humanoid")
				if Humanoid then
					if Humanoid.Health == 0 or character == Players.LocalPlayer.Character then
						return
					end
					local player = Players:GetPlayerFromCharacter(character)
					if player and PlayerUtils.getTeam(player) == PlayerUtils.getTeam(Players.LocalPlayer) then
						return
					end
					local PrimaryPart = character.PrimaryPart
					if PrimaryPart then
						local Head = character:FindFirstChild("Head")
						local headOffset = if Head then (Head.Position - PrimaryPart.Position) * Vector3.new(0, 1, 0) / 2 else Vector3.new(0, 0, 0)
						local targetPosition = PrimaryPart.CFrame * headOffset
						if hasLineOfSight(character, targetPosition) then
							table.insert(targets, {
								humanoid = Humanoid,
								part = PrimaryPart,
								offset = headOffset,
								distance = (targetPosition - Position).Magnitude,
								dot = (targetPosition - Position).Unit:Dot(LookVector)
							})
						end
					end
				end
			end
			for tagName, humanoidInstance in CollectionService:GetTagged("Humanoid") do
				handleCharacter(humanoidInstance.Parent)
			end
			table.sort(targets, function(targetA, targetB)
				return targetA.dot > targetB.dot
			end)
			for i = 1, #targets do
				local targetData = targets[i]
				if targetData.dot > 0.9396926207859084 and targetData.distance <= 100 then
					return targetData
				end
			end
			return nil
		end
		local bestTarget = findBestCharacter()
		if bestTarget then
			local part = bestTarget.part
			taskMaid:GiveTask(RunService.RenderStepped:Connect(function(deltaTime)
				local targetLookCFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, part.CFrame * bestTarget.offset)
				local mouseLocation = userInputService:GetMouseLocation()
				local viewportRay = CurrentCamera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y, 0)
				local crossProduct = viewportRay.Direction:Cross(CurrentCamera.CFrame.LookVector)
				local alignment = viewportRay.Direction:Dot(CurrentCamera.CFrame.LookVector)
				if alignment < 0.999 then
					targetLookCFrame = targetLookCFrame * CFrame.fromAxisAngle(crossProduct, (math.acos(alignment)))
				end
				local targetPosition = part.CFrame * bestTarget.offset
				if hasLineOfSight(part.Parent, targetPosition) then
					if (Players.LocalPlayer.Character:GetPivot().Position - targetPosition).Magnitude > 100 then
						stopCallback()
						return
					end
					local lerpAlpha = 1 - math.exp(-9 * deltaTime)
					if isAimbot then
						lerpAlpha = 1
					end
					CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(targetLookCFrame, lerpAlpha)
					if if Players.LocalPlayer:GetAttribute("AimbotEnabled") then true else InputUtils.isGamepad() and os.clock() - lastMouseInputTime > 10 and true or false then
						if bestTarget.humanoid.Health == 0 or not part:IsDescendantOf(workspace) then
							stopCallback()
						end
					else
						stopCallback()
					end
				else
					stopCallback()
				end
			end))
			return taskMaid
		else
			return nil
		end
	end,
	canAimAssist = canAimAssist
}
