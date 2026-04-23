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
local v1 = 0
UserInputService.InputBegan:Connect(function(p1) --[[ Line: 14 | Upvalues: v1 (ref) ]]
	if p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
		v1 = os.clock()
	end
end)
UserInputService.InputChanged:Connect(function(p1) --[[ Line: 19 | Upvalues: v1 (ref) ]]
	if p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
		v1 = os.clock()
	end
end)
local function canAimAssist() --[[ Line: 25 | Upvalues: Players (copy), InputUtils (copy), v1 (ref) ]]
	if Players.LocalPlayer:GetAttribute("AimbotEnabled") then
		return true
	else
		return InputUtils.isGamepad() and os.clock() - v1 > 10 and true or false
	end
end
local function hasLineOfSight(p1, p2) --[[ Line: 37 | Upvalues: Players (copy) ]]
	local Position = workspace.CurrentCamera.CFrame.Position
	local v1 = RaycastParams.new()
	v1.FilterType = Enum.RaycastFilterType.Exclude
	v1.RespectCanCollide = true
	v1.FilterDescendantsInstances = { Players.LocalPlayer.Character, workspace.Items }
	v1.IgnoreWater = true
	local v2 = workspace:Raycast(Position, p2 - Position, v1)
	if v2 then
		return v2.Instance:IsDescendantOf(p1)
	else
		return true
	end
end
return {
	aimAssist = function(p1, p2) --[[ Name: aimAssist | Line: 61 | Upvalues: Maid (copy), Players (copy), PlayerUtils (copy), hasLineOfSight (copy), CollectionService (copy), RunService (copy), InputUtils (copy), v1 (ref) ]]
		local v12 = Maid.new()
		local CurrentCamera = workspace.CurrentCamera
		local v2 = Players.LocalPlayer:GetAttribute("AimbotEnabled") == true
		local v3 = Players.LocalPlayer.Character:GetPivot()
		local Position = v3.Position
		local LookVector = v3.LookVector
		local function findBestCharacter() --[[ Line: 68 | Upvalues: Players (ref), PlayerUtils (ref), hasLineOfSight (ref), Position (copy), LookVector (copy), CollectionService (ref) ]]
			local t = {}
			local t2 = {}
			local function handleCharacter(p1) --[[ Line: 71 | Upvalues: t2 (copy), Players (ref), PlayerUtils (ref), hasLineOfSight (ref), t (copy), Position (ref), LookVector (ref) ]]
				if t2[p1] then
					return
				end
				t2[p1] = true
				local Humanoid = p1:FindFirstChild("Humanoid")
				if Humanoid then
					if Humanoid.Health == 0 or p1 == Players.LocalPlayer.Character then
						return
					end
					local v1 = Players:GetPlayerFromCharacter(p1)
					if v1 and PlayerUtils.getTeam(v1) == PlayerUtils.getTeam(Players.LocalPlayer) then
						return
					end
					local PrimaryPart = p1.PrimaryPart
					if PrimaryPart then
						local Head = p1:FindFirstChild("Head")
						local v2 = if Head then (Head.Position - PrimaryPart.Position) * Vector3.new(0, 1, 0) / 2 else Vector3.new(0, 0, 0)
						local v3 = PrimaryPart.CFrame * v2
						if hasLineOfSight(p1, v3) then
							table.insert(t, {
								humanoid = Humanoid,
								part = PrimaryPart,
								offset = v2,
								distance = (v3 - Position).Magnitude,
								dot = (v3 - Position).Unit:Dot(LookVector)
							})
						end
					end
				end
			end
			for v1, v2 in CollectionService:GetTagged("Humanoid") do
				handleCharacter(v2.Parent)
			end
			table.sort(t, function(p1, p2) --[[ Line: 117 ]]
				return p1.dot > p2.dot
			end)
			for i = 1, #t do
				local v3 = t[i]
				if v3.dot > 0.9396926207859084 and v3.distance <= 100 then
					return v3
				end
			end
			return nil
		end
		local v4 = findBestCharacter()
		if v4 then
			local part = v4.part
			v12:GiveTask(RunService.RenderStepped:Connect(function(p12) --[[ Line: 133 | Upvalues: CurrentCamera (copy), part (copy), v4 (copy), p1 (copy), hasLineOfSight (ref), p2 (copy), Players (ref), v2 (copy), InputUtils (ref), v1 (ref) ]]
				local v12 = CFrame.lookAt(CurrentCamera.CFrame.Position, part.CFrame * v4.offset)
				local v22 = p1:GetMouseLocation()
				local v3 = CurrentCamera:ViewportPointToRay(v22.X, v22.Y, 0)
				local v42 = v3.Direction:Cross(CurrentCamera.CFrame.LookVector)
				local v5 = v3.Direction:Dot(CurrentCamera.CFrame.LookVector)
				if v5 < 0.999 then
					v12 = v12 * CFrame.fromAxisAngle(v42, (math.acos(v5)))
				end
				local v7 = part.CFrame * v4.offset
				if hasLineOfSight(part.Parent, v7) then
					if (Players.LocalPlayer.Character:GetPivot().Position - v7).Magnitude > 100 then
						p2()
						return
					end
					local v8 = 1 - math.exp(-9 * p12)
					if v2 then
						v8 = 1
					end
					CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(v12, v8)
					if if Players.LocalPlayer:GetAttribute("AimbotEnabled") then true else InputUtils.isGamepad() and os.clock() - v1 > 10 and true or false then
						if v4.humanoid.Health == 0 or not part:IsDescendantOf(workspace) then
							p2()
						end
					else
						p2()
					end
				else
					p2()
				end
			end))
			return v12
		else
			return nil
		end
	end,
	canAimAssist = canAimAssist
}