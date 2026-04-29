local GuiService = game:GetService("GuiService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local UserInputService = game:GetService("UserInputService")
local ChatUtils = require(ReplicatedStorage.Chat.ChatUtils)
local randomGenerator = Random.new()
local colorManager = {
	Index = 1,
	BaseColors = {
		Color3.new(255/255, 0/255, 0/255),
		Color3.fromRGB(0, 120, 255),
		Color3.fromRGB(189, 0, 255),
		Color3.fromRGB(255, 154, 0),
		Color3.fromRGB(1, 255, 31),
		Color3.fromRGB(227, 255, 0)
	},
	Reset = function(self)
		self.Index = 1
	end,
	NextColor = function(self)
		if self.Index >= #self.BaseColors then
			return Color3.fromHSV(randomGenerator:NextNumber(), 1, 1)
		else
			local Index = self.Index
			self.Index = self.Index + 1
			return self.BaseColors[Index]
		end
	end
}
local function MakeTable(width, height)
	local grid = {}
	for i = 1, height do
		grid[i] = {}
		for j = 1, width do
			grid[i][j] = 0
		end
	end
	return grid
end
local directionX = { 0, 1, 0, -1 }
local directionY = { -1, 0, 1, 0 }
local function IsInside(grid, column, row)
	return if column >= 1 and (column <= #grid[1] and row >= 1) then row <= #grid else false
end
local function IsFilled(grid)
	local columnCount = #grid[1]
	for i = 1, #grid do
		for j = 1, columnCount do
			if grid[i][j] < 0 then
				return false
			end
		end
	end
	return true
end
local function IsNextTo(x1, y1, x2, y2)
	return if x1 == x2 + 1 and y1 == y2 or (x1 == x2 - 1 and y1 == y2 or x1 == x2 and y1 == y2 + 1) then true elseif x1 == x2 then y1 == y2 - 1 else false
end
local FlowGui = ReplicatedStorage.Resource.FlowGui
local flowState = {
	IsOpen = false,
	Maid = nil,
	OnFilled = nil,
	FlowId = nil,
	Grid = nil,
	SetGrid = function(self, flowId, grid)
		self.FlowId = flowId
		self.Grid = grid
		local rowCount = #grid
		local columnCount = #grid[1]
		self.GridClean = MakeTable(columnCount, rowCount)
		for i = 1, rowCount do
			for j = 1, columnCount do
				self.GridClean[i][j] = self.Grid[i][j]
			end
		end
		colorManager:Reset()
		self.Colors = {}
	end,
	ResetAlpha = function(self, cellValue)
		assert(cellValue)
		local columnCount = #self.Grid[1]
		for i = 1, #self.Grid do
			for j = 1, columnCount do
				if self.Grid[i][j] == cellValue then
					self.Grid[i][j] = self.GridClean[i][j]
				end
			end
		end
	end,
	Reset = function(self)
		if self.Grid == nil then
			return false
		end
		local columnCount = #self.Grid[1]
		for i = 1, #self.Grid do
			for j = 1, columnCount do
				self.Grid[i][j] = self.GridClean[i][j]
			end
		end
	end,
	Colors = {},
	Draw = function(self)
		local rowCount = #self.Grid
		local columnCount = #self.Grid[1]
		for i = 1, rowCount do
			for j = 1, columnCount do
				local cellName = ("%d.%d"):format(j, i)
				local cellLabel = FlowGui.Board.Inner:FindFirstChild(cellName)
				if cellLabel == nil then
					local TextLabel = Instance.new("TextLabel")
					TextLabel.Name = cellName
					TextLabel.BorderSizePixel = 0
					TextLabel.BackgroundTransparency = 0
					TextLabel.TextSize = 20
					TextLabel.TextColor3 = Color3.new(0.1, 0.1, 0.1)
					TextLabel.Size = UDim2.new(1 / columnCount * 0.5, 0, 1 / rowCount * 0.5, 0)
					TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel.Position = UDim2.new((j - 1 + 0.5) / columnCount, 0, (i - 1 + 0.5) / rowCount, 0)
					TextLabel.Parent = FlowGui.Board.Inner
					cellLabel = TextLabel
				end
				local cellValue = self.Grid[i][j]
				if cellValue >= 0 then
					local cellColor = self.Colors[cellValue]
					if cellColor == nil then
						local nextColor = colorManager:NextColor()
						self.Colors[cellValue] = nextColor
						cellColor = nextColor
					end
					cellLabel.BackgroundColor3 = cellColor
				else
					cellLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				end
				local displayValue = self.Grid[i][j]
				if displayValue >= 0 then
					cellLabel.Text = displayValue
				else
					cellLabel.Text = ""
				end
			end
		end
	end,
	GetCoordFromMouse = function(self, mouseInput)
		local Inner = FlowGui.Board.Inner
		local AbsolutePosition = Inner.AbsolutePosition
		local AbsoluteSize = Inner.AbsoluteSize
		local rowCount = #self.Grid
		local columnCount = #self.Grid[1]
		local column = math.clamp(math.floor(columnCount * (mouseInput.X - AbsolutePosition.X) / AbsoluteSize.X) + 1, 1, columnCount)
		local row = math.clamp(math.floor(rowCount * (mouseInput.Y - AbsolutePosition.Y) / AbsoluteSize.Y) + 1, 1, rowCount)
		return column, row, self.Grid[row][column]
	end
}
function flowState.Show(self)
	if self.IsOpen then
		warn("Board was already.. attempting to remedy..")
		flowState:Reset()
		flowState:Hide()
	end
	assert(self.IsOpen == false)
	self.IsOpen = true
	FlowGui.Parent = LocalPlayer.PlayerGui
	self.Maid = Maid.new()
	if UserInputService.GamepadEnabled then
		ChatUtils.setEnabled(false)
	end
	self.Maid:GiveTask(function()
		if UserInputService.GamepadEnabled then
			ChatUtils.setEnabled(true)
		end
	end)
	local startX = nil
	local startY = nil
	local currentX = nil
	local currentY = nil
	local currentValue = nil
	local isTracing = false
	local function TouchStart(inputData)
		local column, row, cellValue = self:GetCoordFromMouse(inputData)
		local Grid = self.Grid
		if if column >= 1 and (column <= #Grid[1] and row >= 1) then row <= #Grid else false == false then
			return false
		end
		if cellValue < 0 then
			return false
		end
		currentX = column
		currentY = row
		currentValue = cellValue
		startX = column
		startY = row
		self:ResetAlpha(cellValue)
		self:Draw()
		isTracing = true
	end
	local function TouchStop(inputData)
		if isTracing == false then
			return false
		end
		isTracing = false
		if currentX == startX and currentY == startY then
			self:ResetAlpha(currentValue)
		else
			local isValidConnection = false
			for i = 1, 4 do
				local isAdjacent
				local nextX = currentX + directionX[i]
				local nextY = currentY + directionY[i]
				local Grid = self.Grid
				isAdjacent = if nextX >= 1 and (nextX <= #Grid[1] and nextY >= 1) then nextY <= #Grid else false
				if isAdjacent and (self.GridClean[nextY][nextX] == currentValue and (nextX ~= startX or nextY ~= startY)) then
					isValidConnection = true
				end
			end
			if isValidConnection == false then
				self:ResetAlpha(currentValue)
			else
				if self.OnConnection == nil then
					error("No OnConnection function set!")
				end
				self.OnConnection()
			end
		end
		self:Draw()
	end
	local function TouchMove(inputData)
		if isTracing then
			local column, row, cellValue = self:GetCoordFromMouse(inputData)
			local prevX = currentX
			local prevY = currentY
			if if column == prevX + 1 and row == prevY or (column == prevX - 1 and row == prevY or column == prevX and row == prevY + 1) then true elseif column == prevX then row == prevY - 1 else false == false then
				return false
			elseif (column ~= currentX or row ~= currentY) and cellValue < 0 then
				self.Grid[row][column] = currentValue
				currentX = column
				currentY = row
				self:Draw()
			end
		end
	end
	local function connectBoardInput()
		self.Maid:GiveTask(FlowGui.Board.InputBegan:Connect(function(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Touch then
				TouchStart(inputEvent.Position)
			end
		end))
		self.Maid:GiveTask(FlowGui.Board.InputEnded:Connect(function(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Touch then
				TouchStop(inputEvent.Position)
			end
		end))
		self.Maid:GiveTask(FlowGui.Board.InputChanged:Connect(function(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.MouseMovement or inputEvent.UserInputType == Enum.UserInputType.Touch then
				TouchMove(inputEvent.Position)
			end
		end))
	end
	task.defer(function()
		if self.IsOpen and self.Maid then
			connectBoardInput()
		end
	end)
	self.Maid:GiveTask(FlowGui.Board.Reset.MouseButton1Down:Connect(function()
		self:Reset()
		self:Draw()
	end))
	self.Maid:GiveTask(FlowGui.Board.Cancel.MouseButton1Down:Connect(function()
		self:Hide()
	end))
	flowState:Draw()
	if not GuiService.AutoSelectGuiEnabled and UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
		local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
		self.Maid:GiveTask(Humanoid.Changed:connect(function()
			Humanoid.Jump = false
		end))
		local selectedColumn = 1
		local selectedRow = 1
		local previousCell = nil
		local function UpdateGamepadSelection()
			local rowCount = #self.Grid
			local columnCount = #self.Grid[1]
			if selectedColumn < 1 then
				selectedColumn = 1
			end
			if columnCount < selectedColumn then
				selectedColumn = columnCount
			end
			if selectedRow < 1 then
				selectedRow = 1
			end
			if rowCount < selectedRow then
				selectedRow = rowCount
			end
			if previousCell then
				previousCell.Size = UDim2.new(1 / columnCount * 0.5, 0, 1 / rowCount * 0.5, 0)
			end
			local currentCell = FlowGui.Board.Inner:FindFirstChild((("%d.%d"):format(selectedColumn, selectedRow)))
			assert(currentCell)
			currentCell.Size = UDim2.new(1 / columnCount * 0.75, 0, 1 / rowCount * 0.75, 0)
			previousCell = currentCell
			TouchMove(currentCell.AbsolutePosition + currentCell.AbsoluteSize * 0.5)
		end
		self.Maid:GiveTask(UserInputService.InputBegan:Connect(function(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.Gamepad1 then
				if inputEvent.KeyCode == Enum.KeyCode.DPadUp then
					selectedRow = selectedRow - 1
					UpdateGamepadSelection()
				elseif inputEvent.KeyCode == Enum.KeyCode.DPadDown then
					selectedRow = selectedRow + 1
					UpdateGamepadSelection()
				elseif inputEvent.KeyCode == Enum.KeyCode.DPadLeft then
					selectedColumn = selectedColumn - 1
					UpdateGamepadSelection()
				elseif inputEvent.KeyCode == Enum.KeyCode.DPadRight then
					selectedColumn = selectedColumn + 1
					UpdateGamepadSelection()
				elseif inputEvent.KeyCode == Enum.KeyCode.ButtonA then
					local selectedCell = FlowGui.Board.Inner:FindFirstChild((("%d.%d"):format(selectedColumn, selectedRow)))
					TouchStart(selectedCell.AbsolutePosition + selectedCell.AbsoluteSize * 0.5)
				end
			end
		end))
		self.Maid:GiveTask(UserInputService.InputEnded:Connect(function(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.Gamepad1 and inputEvent.KeyCode == Enum.KeyCode.ButtonA then
				local selectedCell = FlowGui.Board.Inner:FindFirstChild((("%d.%d"):format(selectedColumn, selectedRow)))
				TouchStop(selectedCell.AbsolutePosition + selectedCell.AbsoluteSize * 0.5)
			end
		end))
		UpdateGamepadSelection()
	end
end
function flowState.Hide(self)
	assert(self.IsOpen == true)
	FlowGui.Parent = script
	FlowGui.Board.Inner:ClearAllChildren()
	assert(self.Maid)
	self.Maid:Destroy()
	self.Maid = nil
	self.IsOpen = false
end
local eventConnection = nil
local eventManager = nil
return {
	Init = function(config)
		local em = config.em
		eventConnection = config.Event
		eventManager = em
		function flowState.OnConnection()
			eventConnection:FireServer("vrase4bd", flowState.FlowId, flowState.Grid)
		end
		function em.boy25zu9(flowId, grid)
			flowState:SetGrid(flowId, grid)
			flowState:Show()
		end
		function em.a5lmmwfi(idToHide)
			if flowState.IsOpen and (idToHide == nil or flowState.FlowId == idToHide) then
				flowState:Reset()
				flowState:Hide()
			end
		end
	end
}
