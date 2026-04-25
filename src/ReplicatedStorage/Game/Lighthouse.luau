-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local CurrentCamera = workspace.CurrentCamera
return {
	Init = function()
		Binder.new("LighthouseLight", function(lighthousePart)
			local maid = Maid.new()
			assert(lighthousePart.PrimaryPart.Name == "Center", "LighthouseLight must have Center as PrimaryPart")
			maid:GiveTask(RunService.Heartbeat:Connect(function(deltaTime)
				local pivot = lighthousePart:GetPivot()
				local Magnitude = (CurrentCamera.CFrame.Position - pivot.Position).Magnitude
				if not (Magnitude * Magnitude > 1048576) then
					debug.profilebegin("Lighthouse")
					lighthousePart:PivotTo(pivot * CFrame.Angles(0, 0.5 * deltaTime, 0))
					debug.profileend()
				end
			end))
			return maid
		end):Start()
	end
}
