-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local AccelTween = require(ReplicatedStorage.Std.AccelTween)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local CurrentCamera = workspace.CurrentCamera
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local DamageIndicatorService = {
	list = {},
	onForceUpdate = Signal.new()
}
function DamageIndicatorService.add(indicatorData)
	local key = indicatorData.key
	if not key then
		key = tostring(math.random() * 10000)
	end
	indicatorData.key = key
	indicatorData.key = "damageIndicator_" .. indicatorData.key
	indicatorData.bornAt = os.clock()
	indicatorData.strength = indicatorData.strength or 1
	assert(if indicatorData.strength > 0 then indicatorData.strength <= 1 else false, "strength must be (0, 1]")
	indicatorData.lifetime = indicatorData.lifetime or 1
	indicatorData.color = indicatorData.color or Color3.new(255/255, 0/255, 0/255)
	local existingIndicator = nil
	for i = 1, #DamageIndicatorService.list do
		local indicator = DamageIndicatorService.list[i]
		if indicator.key == indicatorData.key then
			existingIndicator = indicator
			break
		end
	end
	if not existingIndicator then
		local angleBinding, updateAngle = Roact.createBinding(0)
		indicatorData.angle = angleBinding
		indicatorData.updateAngle = updateAngle
		local transparencyBinding, updateTransparency = Roact.createBinding(0)
		indicatorData.transparency = transparencyBinding
		indicatorData.updateTransparency = updateTransparency
		table.insert(DamageIndicatorService.list, indicatorData)
		local tweenFadeOut = AccelTween.new()
		tweenFadeOut.a = 10
		tweenFadeOut.p = 0
		tweenFadeOut.t = 1
		local fadeOutTime = tweenFadeOut.rtime
		tweenFadeOut.a = 500
		tweenFadeOut.p = 1
		tweenFadeOut.t = 0
		local removeCallback = nil
		local function getAngle()
			local cameraRelativePos = CurrentCamera.CFrame:PointToObjectSpace(indicatorData.worldPosition)
			return math.atan2(-cameraRelativePos.x, -cameraRelativePos.z)
		end
		local cameraRelativePos = CurrentCamera.CFrame:PointToObjectSpace(indicatorData.worldPosition)
		local currentAngle = math.atan2(-cameraRelativePos.x, -cameraRelativePos.z)
		local function update()
			local bornAt = indicatorData.bornAt
			local cameraSpace = CurrentCamera.CFrame:PointToObjectSpace(indicatorData.worldPosition)
			currentAngle = currentAngle + GeomUtils.shortAngleDist(currentAngle, (math.atan2(-cameraSpace.x, -cameraSpace.z))) / 5
			indicatorData.updateAngle(-1.5707963267948966 - currentAngle)
			local progress = tweenFadeOut.p
			indicatorData.updateTransparency((1 - indicatorData.strength) * (1 - progress) + 1 * progress)
			local currentTime = os.clock()
			if currentTime - bornAt > indicatorData.lifetime - fadeOutTime then
				if tweenFadeOut.t ~= 1 then
					tweenFadeOut.a = 10
					tweenFadeOut.v = 0
					tweenFadeOut.t = 1
				end
			elseif tweenFadeOut.t ~= 0 then
				tweenFadeOut.a = 500
				tweenFadeOut.v = 0
				tweenFadeOut.t = 0
			end
			if currentTime - bornAt > indicatorData.lifetime then
				removeCallback()
			end
		end
		update()
		local heartbeatConnection = RunService.Heartbeat:Connect(update)
		DamageIndicatorService.onForceUpdate:Fire()
		local minimapEntry = {
			name = indicatorData.key,
			worldPosition = indicatorData.worldPosition,
			flash = false
		}
		local minimapColorBinding, updateMinimapColor = Roact.createBinding(Color3.new(255/255, 0/255, 0/255))
		minimapEntry.color = minimapColorBinding
		minimapEntry.updateColor = updateMinimapColor
		local minimapRemoveCallback = MinimapService.add(minimapEntry)
		local hasBeenRemoved = false
		removeCallback = function()
			if hasBeenRemoved then
				return false
			else
				hasBeenRemoved = true
				heartbeatConnection:Disconnect()
				heartbeatConnection = nil
				minimapRemoveCallback()
				table.remove(DamageIndicatorService.list, (table.find(DamageIndicatorService.list, indicatorData)))
				DamageIndicatorService.onForceUpdate:Fire()
				return true
			end
		end
		return removeCallback
	end
	existingIndicator.bornAt = indicatorData.bornAt
	existingIndicator.lifetime = indicatorData.lifetime
	existingIndicator.strength = indicatorData.strength
	existingIndicator.worldPosition = indicatorData.worldPosition
end
function DamageIndicatorService.init()
	waitForChild(ReplicatedStorage, "DamageIndicatorRemote"):andThen(function(remoteEvent)
		remoteEvent.OnClientEvent:Connect(function(incomingData)
			DamageIndicatorService.add(incomingData)
		end)
	end)
end
return DamageIndicatorService
