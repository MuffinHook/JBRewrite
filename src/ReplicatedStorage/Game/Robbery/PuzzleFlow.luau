-- Reviewed by Claude
local GuiService = game:GetService("GuiService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local UserInputService = game:GetService("UserInputService")
local ChatUtils = require(ReplicatedStorage.Chat.ChatUtils)
local v1 = Random.new()
local t = {
	Index = 1,
	BaseColors = {
		Color3.new(255/255, 0/255, 0/255),
		Color3.fromRGB(0, 120, 255),
		Color3.fromRGB(189, 0, 255),
		Color3.fromRGB(255, 154, 0),
		Color3.fromRGB(1, 255, 31),
		Color3.fromRGB(227, 255, 0)
	},
	Reset = function(p1)
		p1.Index = 1
	end,
	NextColor = function(p1)
		if p1.Index >= #p1.BaseColors then
			return Color3.fromHSV(v1:NextNumber(), 1, 1)
		else
			local Index = p1.Index
			p1.Index = p1.Index + 1
			return p1.BaseColors[Index]
		end
	end
}
local function MakeTable(p1, p2)
	local t = {}
	for i = 1, p2 do
		t[i] = {}
		for j = 1, p1 do
			t[i][j] = 0
		end
	end
	return t
end
local t2 = { 0, 1, 0, -1 }
local t3 = { -1, 0, 1, 0 }
local function IsInside(p1, p2, p3)
	return if p2 >= 1 and (p2 <= #p1[1] and p3 >= 1) then p3 <= #p1 else false
end
local function IsFilled(p1)
	local v1 = #p1[1]
	for i = 1, #p1 do
		for j = 1, v1 do
			if p1[i][j] < 0 then
				return false
			end
		end
	end
	return true
end
local function IsNextTo(p1, p2, p3, p4)
	return if p1 == p3 + 1 and p2 == p4 or (p1 == p3 - 1 and p2 == p4 or p1 == p3 and p2 == p4 + 1) then true elseif p1 == p3 then p2 == p4 - 1 else false
end
local FlowGui = ReplicatedStorage.Resource.FlowGui
local t4 = {
	IsOpen = false,
	Maid = nil,
	OnFilled = nil,
	SetGrid = function(p1, p2, p3)
		p1.FlowId = p2
		p1.Grid = p3
		local v1 = #p3
		local v2 = #p3[1]
		p1.GridClean = MakeTable(v2, v1)
		for i = 1, v1 do
			for j = 1, v2 do
				p1.GridClean[i][j] = p1.Grid[i][j]
			end
		end
		t:Reset()
		p1.Colors = {}
	end,
	ResetAlpha = function(p1, p2)
		assert(p2)
		local v2 = #p1.Grid[1]
		for i = 1, #p1.Grid do
			for j = 1, v2 do
				if p1.Grid[i][j] == p2 then
					p1.Grid[i][j] = p1.GridClean[i][j]
				end
			end
		end
	end,
	Reset = function(p1)
		if p1.Grid == nil then
			return false
		end
		local v2 = #p1.Grid[1]
		for i = 1, #p1.Grid do
			for j = 1, v2 do
				p1.Grid[i][j] = p1.GridClean[i][j]
			end
		end
	end,
	Colors = {},
	Draw = function(p1)
		local v1 = #p1.Grid
		local v2 = #p1.Grid[1]
		for i = 1, v1 do
			for j = 1, v2 do
				local v3 = ("%d.%d"):format(j, i)
				local v4 = FlowGui.Board.Inner:FindFirstChild(v3)
				if v4 == nil then
					local TextLabel = Instance.new("TextLabel")
					TextLabel.Name = v3
					TextLabel.BorderSizePixel = 0
					TextLabel.BackgroundTransparency = 0
					TextLabel.TextSize = 20
					TextLabel.TextColor3 = Color3.new(0.1, 0.1, 0.1)
					TextLabel.Size = UDim2.new(1 / v2 * 0.5, 0, 1 / v1 * 0.5, 0)
					TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel.Position = UDim2.new((j - 1 + 0.5) / v2, 0, (i - 1 + 0.5) / v1, 0)
					TextLabel.Parent = FlowGui.Board.Inner
					v4 = TextLabel
				end
				local v5 = p1.Grid[i][j]
				if v5 >= 0 then
					local v6 = p1.Colors[v5]
					if v6 == nil then
						local v7 = t:NextColor()
						p1.Colors[v5] = v7
						v6 = v7
					end
					v4.BackgroundColor3 = v6
				else
					v4.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				end
				local v8 = p1.Grid[i][j]
				if v8 >= 0 then
					v4.Text = v8
				else
					v4.Text = ""
				end
			end
		end
	end,
	GetCoordFromMouse = function(p1, p2)
		local Inner = FlowGui.Board.Inner
		local AbsolutePosition = Inner.AbsolutePosition
		local AbsoluteSize = Inner.AbsoluteSize
		local v3 = #p1.Grid
		local v4 = #p1.Grid[1]
		local v6 = math.clamp(math.floor(v4 * (p2.X - AbsolutePosition.X) / AbsoluteSize.X) + 1, 1, v4)
		local v8 = math.clamp(math.floor(v3 * (p2.Y - AbsolutePosition.Y) / AbsoluteSize.Y) + 1, 1, v3)
		return v6, v8, p1.Grid[v8][v6]
	end
}
function t4.Show(p1)
	if p1.IsOpen then
		warn("Board was already.. attempting to remedy..")
		t4:Reset()
		t4:Hide()
	end
	assert(p1.IsOpen == false)
	p1.IsOpen = true
	FlowGui.Parent = LocalPlayer.PlayerGui
	p1.Maid = Maid.new()
	if UserInputService.GamepadEnabled then
		ChatUtils.setEnabled(false)
	end
	p1.Maid:GiveTask(function()
		if UserInputService.GamepadEnabled then
			ChatUtils.setEnabled(true)
		end
	end)
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = nil
	local v6 = false
	local function TouchStart(p12)
		local v12, v22, v32 = p1:GetCoordFromMouse(p12)
		local Grid = p1.Grid
		if if v12 >= 1 and (v12 <= #Grid[1] and v22 >= 1) then v22 <= #Grid else false == false then
			return false
		end
		if v32 < 0 then
			return false
		end
		v3 = v12
		v4 = v22
		v5 = v32
		v1 = v12
		v2 = v22
		p1:ResetAlpha(v32)
		p1:Draw()
		v6 = true
	end
	local function TouchStop(p12)
		if v6 == false then
			return false
		end
		v6 = false
		if v3 == v1 and v4 == v2 then
			p1:ResetAlpha(v5)
		else
			local v12 = false
			for i = 1, 4 do
				local v22
				local v32 = v3 + t2[i]
				local v42 = v4 + t3[i]
				local Grid = p1.Grid
				v22 = if v32 >= 1 and (v32 <= #Grid[1] and v42 >= 1) then v42 <= #Grid else false
				if v22 and (p1.GridClean[v42][v32] == v5 and (v32 ~= v1 or v42 ~= v2)) then
					v12 = true
				end
			end
			if v12 == false then
				p1:ResetAlpha(v5)
			else
				if p1.OnConnection == nil then
					error("No OnConnection function set!")
				end
				p1.OnConnection()
			end
		end
		p1:Draw()
	end
	local function TouchMove(p12)
		if v6 then
			local v1, v2, v32 = p1:GetCoordFromMouse(p12)
			local v42 = v3
			local v52 = v4
			if if v1 == v42 + 1 and v2 == v52 or (v1 == v42 - 1 and v2 == v52 or v1 == v42 and v2 == v52 + 1) then true elseif v1 == v42 then v2 == v52 - 1 else false == false then
				return false
			elseif (v1 ~= v3 or v2 ~= v4) and v32 < 0 then
				p1.Grid[v2][v1] = v5
				v3 = v1
				v4 = v2
				p1:Draw()
			end
		end
	end
	local function connectBoardInput()
		p1.Maid:GiveTask(FlowGui.Board.InputBegan:Connect(function(p1)
			if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then
				TouchStart(p1.Position)
			end
		end))
		p1.Maid:GiveTask(FlowGui.Board.InputEnded:Connect(function(p1)
			if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then
				TouchStop(p1.Position)
			end
		end))
		p1.Maid:GiveTask(FlowGui.Board.InputChanged:Connect(function(p1)
			if p1.UserInputType == Enum.UserInputType.MouseMovement or p1.UserInputType == Enum.UserInputType.Touch then
				TouchMove(p1.Position)
			end
		end))
	end
	task.defer(function()
		if p1.IsOpen and p1.Maid then
			connectBoardInput()
		end
	end)
	p1.Maid:GiveTask(FlowGui.Board.Reset.MouseButton1Down:Connect(function()
		p1:Reset()
		p1:Draw()
	end))
	p1.Maid:GiveTask(FlowGui.Board.Cancel.MouseButton1Down:Connect(function()
		p1:Hide()
	end))
	t4:Draw()
	if not GuiService.AutoSelectGuiEnabled and UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
		local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
		p1.Maid:GiveTask(Humanoid.Changed:connect(function()
			Humanoid.Jump = false
		end))
		local v7 = 1
		local v8 = 1
		local v9 = nil
		local function UpdateGamepadSelection()
			local v1 = #p1.Grid
			local v2 = #p1.Grid[1]
			if v7 < 1 then
				v7 = 1
			end
			if v2 < v7 then
				v7 = v2
			end
			if v8 < 1 then
				v8 = 1
			end
			if v1 < v8 then
				v8 = v1
			end
			if v9 then
				v9.Size = UDim2.new(1 / v2 * 0.5, 0, 1 / v1 * 0.5, 0)
			end
			local v4 = FlowGui.Board.Inner:FindFirstChild((("%d.%d"):format(v7, v8)))
			assert(v4)
			v4.Size = UDim2.new(1 / v2 * 0.75, 0, 1 / v1 * 0.75, 0)
			v9 = v4
			TouchMove(v4.AbsolutePosition + v4.AbsoluteSize * 0.5)
		end
		p1.Maid:GiveTask(UserInputService.InputBegan:Connect(function(p1)
			if p1.UserInputType == Enum.UserInputType.Gamepad1 then
				if p1.KeyCode == Enum.KeyCode.DPadUp then
					v8 = v8 - 1
					UpdateGamepadSelection()
				elseif p1.KeyCode == Enum.KeyCode.DPadDown then
					v8 = v8 + 1
					UpdateGamepadSelection()
				elseif p1.KeyCode == Enum.KeyCode.DPadLeft then
					v7 = v7 - 1
					UpdateGamepadSelection()
				elseif p1.KeyCode == Enum.KeyCode.DPadRight then
					v7 = v7 + 1
					UpdateGamepadSelection()
				elseif p1.KeyCode == Enum.KeyCode.ButtonA then
					local v2 = FlowGui.Board.Inner:FindFirstChild((("%d.%d"):format(v7, v8)))
					TouchStart(v2.AbsolutePosition + v2.AbsoluteSize * 0.5)
				end
			end
		end))
		p1.Maid:GiveTask(UserInputService.InputEnded:Connect(function(p1)
			if p1.UserInputType == Enum.UserInputType.Gamepad1 and p1.KeyCode == Enum.KeyCode.ButtonA then
				local v2 = FlowGui.Board.Inner:FindFirstChild((("%d.%d"):format(v7, v8)))
				TouchStop(v2.AbsolutePosition + v2.AbsoluteSize * 0.5)
			end
		end))
		UpdateGamepadSelection()
	end
end
function t4.Hide(p1)
	assert(p1.IsOpen == true)
	FlowGui.Parent = script
	FlowGui.Board.Inner:ClearAllChildren()
	assert(p1.Maid)
	p1.Maid:Destroy()
	p1.Maid = nil
	p1.IsOpen = false
end
local v2 = nil
local v3 = nil
return {
	Init = function(p1)
		local em = p1.em
		v2 = p1.Event
		v3 = em
		function t4.OnConnection()
			v2:FireServer("v" .. "" .. ("eerm8f"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("nbaq1y"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("asjrl"):sub(2, 2):reverse() .. "" .. "" .. ("sw30enqm"):sub(5, 5):reverse():reverse():reverse() .. "4bd", t4.FlowId, t4.Grid)
		end
		function em.boy25zu9(p1, p2)
			t4:SetGrid(p1, p2)
			t4:Show()
		end
		function em.a5lmmwfi(p1)
			if t4.IsOpen and (p1 == nil or t4.FlowId == p1) then
				t4:Reset()
				t4:Hide()
			end
		end
	end
}
