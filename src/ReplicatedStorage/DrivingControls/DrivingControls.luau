local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local keyCodeMap = {
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.Q] = 5,
	[Enum.KeyCode.E] = 6,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 3,
	[Enum.KeyCode.Left] = 2,
	[Enum.KeyCode.Right] = 4
}
local function GetMoveVector()
	return Vector3.new()
end
local ControlModule = Players.LocalPlayer:FindFirstChild("PlayerScripts"):FindFirstChild("PlayerModule"):FindFirstChild("ControlModule")
if ControlModule then
	local controlModule = require(ControlModule)
	GetMoveVector = function()
		return controlModule:GetMoveVector()
	end
end
local DrivingControls = {}
DrivingControls.__index = DrivingControls
function DrivingControls.new()
	local self = {}
	setmetatable(self, DrivingControls)
	self._wasdqe = { 0, 0, 0, 0, 0, 0 }
	self._maid = Maid.new()
	self._maid:GiveTask(UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
		if not gameProcessed and inputObject.UserInputType == Enum.UserInputType.Keyboard then
			local KeyCode = inputObject.KeyCode
			if keyCodeMap[KeyCode] then
				self._wasdqe[keyCodeMap[KeyCode]] = 1
			end
		end
	end))
	self._maid:GiveTask(UserInputService.InputEnded:Connect(function(inputObject, gameProcessed)
		if not gameProcessed and inputObject.UserInputType == Enum.UserInputType.Keyboard then
			local KeyCode = inputObject.KeyCode
			if keyCodeMap[KeyCode] then
				self._wasdqe[keyCodeMap[KeyCode]] = 0
			end
		end
	end))
	self._maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 1000,
		saturateTo = 0,
		image = "rbxassetid://7858765663",
		keyCodes = { Enum.KeyCode.W, Enum.KeyCode.Up },
		onPressed = function()
			self._wasdqe[1] = 1
		end,
		onReleased = function()
			self._wasdqe[1] = 0
		end
	}))
	self._maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 700,
		saturateTo = 0,
		image = "rbxassetid://7858764373",
		keyCodes = { Enum.KeyCode.S, Enum.KeyCode.Down },
		onPressed = function()
			self._wasdqe[3] = 1
		end,
		onReleased = function()
			self._wasdqe[3] = 0
		end
	}))
	self._maid:GiveTask(UserInputService.InputChanged:Connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
			local KeyCode = inputObject.KeyCode
			if KeyCode == Enum.KeyCode.Thumbstick1 then
				local Position = inputObject.Position
				local X = Position.X
				local Y = Position.Y
				self._wasdqe[2] = X < -0.24 and (-X) ^ 2 or 0
				self._wasdqe[4] = X > 0.24 and X ^ 2 or 0
			elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
				local keyCodeName = tostring(KeyCode.Name)
				local throttleWaitKey = "throttleWaitForEnd" .. keyCodeName
				local throttleHeartbeatKey = "throttleHeartbeat" .. keyCodeName
				if not self._maid[throttleWaitKey] then
					self._maid[throttleWaitKey] = inputObject:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if inputObject.UserInputState == Enum.UserInputState.End then
							self._maid[throttleWaitKey] = nil
							self._maid[throttleHeartbeatKey] = nil
							self._wasdqe[keyCodeMap[KeyCode]] = 0
						end
					end)
					local function update()
						local Z = inputObject.Position.Z
						self._wasdqe[keyCodeMap[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
					end
					local Z = inputObject.Position.Z
					self._wasdqe[keyCodeMap[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
					self._maid[throttleHeartbeatKey] = RunService.Heartbeat:Connect(update)
				end
			end
		end
	end))
	return self
end
function DrivingControls.GetForwardBackward(self)
	return self._wasdqe[1] - self._wasdqe[3]
end
function DrivingControls.GetLeftRight(self)
	local leftRightDelta = self._wasdqe[2] - self._wasdqe[4]
	if InputUtils.isTouch() then
		local X = GetMoveVector().X
		leftRightDelta = -math.clamp(X, -1, 1)
	end
	return leftRightDelta
end
function DrivingControls.GetUpDown(self)
	return self._wasdqe[6] - self._wasdqe[5]
end
function DrivingControls.Destroy(self)
	self._maid:Destroy()
	setmetatable(self, nil)
end
return DrivingControls
