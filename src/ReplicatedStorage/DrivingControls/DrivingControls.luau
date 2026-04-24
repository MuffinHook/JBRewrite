-- Reviewed by Claude
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local t = {
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
	local v1 = require(ControlModule)
	GetMoveVector = function()
		return v1:GetMoveVector()
	end
end
local t2 = {}
t2.__index = t2
function t2.new()
	local t3 = {}
	setmetatable(t3, t2)
	t3._wasdqe = { 0, 0, 0, 0, 0, 0 }
	t3._maid = Maid.new()
	t3._maid:GiveTask(UserInputService.InputBegan:Connect(function(p1, p2)
		if not p2 and p1.UserInputType == Enum.UserInputType.Keyboard then
			local KeyCode = p1.KeyCode
			if t[KeyCode] then
				t3._wasdqe[t[KeyCode]] = 1
			end
		end
	end))
	t3._maid:GiveTask(UserInputService.InputEnded:Connect(function(p1, p2)
		if not p2 and p1.UserInputType == Enum.UserInputType.Keyboard then
			local KeyCode = p1.KeyCode
			if t[KeyCode] then
				t3._wasdqe[t[KeyCode]] = 0
			end
		end
	end))
	t3._maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 1000,
		saturateTo = 0,
		image = "rbxassetid://7858765663",
		keyCodes = { Enum.KeyCode.W, Enum.KeyCode.Up },
		onPressed = function()
			t3._wasdqe[1] = 1
		end,
		onReleased = function()
			t3._wasdqe[1] = 0
		end
	}))
	t3._maid:GiveTask(ActionButtonService.add({
		primary = true,
		priority = 700,
		saturateTo = 0,
		image = "rbxassetid://7858764373",
		keyCodes = { Enum.KeyCode.S, Enum.KeyCode.Down },
		onPressed = function()
			t3._wasdqe[3] = 1
		end,
		onReleased = function()
			t3._wasdqe[3] = 0
		end
	}))
	t3._maid:GiveTask(UserInputService.InputChanged:Connect(function(p1)
		if p1.UserInputType == Enum.UserInputType.Gamepad1 then
			local KeyCode = p1.KeyCode
			if KeyCode == Enum.KeyCode.Thumbstick1 then
				local Position = p1.Position
				local X = Position.X
				local Y = Position.Y
				t3._wasdqe[2] = X < -0.24 and (-X) ^ 2 or 0
				t3._wasdqe[4] = X > 0.24 and X ^ 2 or 0
			elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
				local v4 = tostring(KeyCode.Name)
				local v5 = "throttleWaitForEnd" .. v4
				local v6 = "throttleHeartbeat" .. v4
				if not t3._maid[v5] then
					t3._maid[v5] = p1:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if p1.UserInputState == Enum.UserInputState.End then
							t3._maid[v5] = nil
							t3._maid[v6] = nil
							t3._wasdqe[t[KeyCode]] = 0
						end
					end)
					local function update()
						local Z = p1.Position.Z
						t3._wasdqe[t[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
					end
					local Z = p1.Position.Z
					t3._wasdqe[t[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
					t3._maid[v6] = RunService.Heartbeat:Connect(update)
				end
			end
		end
	end))
	return t3
end
function t2.GetForwardBackward(p1)
	return p1._wasdqe[1] - p1._wasdqe[3]
end
function t2.GetLeftRight(p1)
	local v1 = p1._wasdqe[2] - p1._wasdqe[4]
	if InputUtils.isTouch() then
		local X = GetMoveVector().X
		v1 = -math.clamp(X, -1, 1)
	end
	return v1
end
function t2.GetUpDown(p1)
	return p1._wasdqe[6] - p1._wasdqe[5]
end
function t2.Destroy(p1)
	p1._maid:Destroy()
	setmetatable(p1, nil)
end
return t2
