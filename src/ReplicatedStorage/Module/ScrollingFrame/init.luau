game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local MakeMaid = require(script.ScrollingFrameMaid).MakeMaid
local SpringPhysics = require(script.SpringPhysics)
local Signal = require(script.Signal)
local Scroller = {
	ClassName = "Scroller"
}
Scroller.__index = Scroller
Scroller._Position = 0
Scroller._Min = 0
Scroller._Max = 100
Scroller._ViewSize = 50
function Scroller.new()
	local scrollerInstance = setmetatable({}, Scroller)
	scrollerInstance.Spring = SpringPhysics.Spring.New(0)
	scrollerInstance.Spring.Speed = 20
	return scrollerInstance
end
function Scroller.GetTimesOverBounds(self, offset)
	return self:GetDisplacementPastBounds(offset) / self.BackBounceInputRange
end
function Scroller.GetDisplacementPastBounds(self, targetPosition)
	if self.ContentMax < targetPosition then
		return targetPosition - self.ContentMax
	elseif targetPosition < self.ContentMin then
		return targetPosition
	else
		return 0
	end
end
function Scroller.GetScale(self, bounceAmount)
	return 1 - 0.5 ^ math.abs(bounceAmount)
end
function Scroller.__index(self, key)
	if key == "TotalContentLength" then
		return self._Max - self._Min
	elseif key == "ViewSize" then
		return self._ViewSize
	elseif key == "Max" then
		return self._Max
	elseif key == "ContentMax" then
		if self._Max <= self.ContentMin + self._ViewSize then
			return self.ContentMin
		else
			return self._Max - self._ViewSize
		end
	elseif key == "Min" or key == "ContentMin" then
		return self._Min
	elseif key == "Position" then
		return self.Spring.Position
	elseif key == "BackBounceInputRange" or key == "BackBounceRenderRange" then
		return self._ViewSize
	elseif key == "ContentScrollPercentSize" then
		if self.TotalContentLength == 0 then
			return 0
		else
			return self._ViewSize / self.TotalContentLength
		end
	elseif key == "RenderedContentScrollPercentSize" then
		return self.ContentScrollPercentSize * (1 - self:GetScale(self:GetTimesOverBounds(self.Position)))
	elseif key == "ContentScrollPercent" then
		return (self.Position - self._Min) / (self.TotalContentLength - self._ViewSize)
	elseif key == "RenderedContentScrollPercent" then
		local ContentScrollPercent = self.ContentScrollPercent
		if ContentScrollPercent < 0 then
			return 0
		elseif ContentScrollPercent > 1 then
			return 1
		else
			return ContentScrollPercent
		end
	elseif key == "BoundedRenderPosition" then
		local Position = self.Position
		local timesOverBounds = self:GetTimesOverBounds(Position)
		local scaleAmount = self:GetScale(timesOverBounds)
		if timesOverBounds > 0 then
			return -self.ContentMax - scaleAmount * self.BackBounceRenderRange
		elseif timesOverBounds < 0 then
			return self.ContentMin + scaleAmount * self.BackBounceRenderRange
		else
			return -Position
		end
	else
		if key == "Velocity" then
			return self.Spring.Velocity
		end
		if key == "Target" then
			return self.Spring.Target
		end
		if key == "AtRest" then
			return if math.abs(self.Spring.Target - self.Spring.Position) < 0.00001 then math.abs(self.Spring.Velocity) < 0.00001 else false
		end
		if Scroller[key] then
			return Scroller[key]
		end
		error(("[Scroller] - \'%s\' is not a valid member"):format((tostring(key))))
	end
end
function Scroller.__newindex(self, key, newValue)
	if Scroller[key] or key == "Spring" then
		rawset(self, key, newValue)
	elseif key == "Min" or key == "ContentMin" then
		self._Min = newValue
	elseif key == "Max" then
		self._Max = newValue
		self.Target = self.Target
	elseif key == "TotalContentLength" then
		self.Max = self._Min + newValue
	elseif key == "ViewSize" then
		self._ViewSize = newValue
	elseif key == "Position" then
		self.Spring.Position = newValue
	elseif key == "TargetContentScrollPercent" then
		self.Target = self._Min + newValue * (self.TotalContentLength - self._ViewSize)
	elseif key == "ContentScrollPercent" then
		self.Position = self._Min + newValue * (self.TotalContentLength - self._ViewSize)
	elseif key == "Target" then
		if self.ContentMax < newValue then
			newValue = self.ContentMax
		elseif newValue < self.ContentMin then
			newValue = self.ContentMin
		end
		self.Spring.Target = newValue
	elseif key == "Velocity" then
		self.Spring.Velocity = newValue
	else
		error(("[Scroller] - \'%s\' is not a valid member"):format((tostring(key))))
	end
end
local ScrollingFrameBase = {
	ClassName = "Base"
}
ScrollingFrameBase.__index = ScrollingFrameBase
function ScrollingFrameBase.new(guiElement)
	local baseInstance = setmetatable({}, ScrollingFrameBase)
	baseInstance.Maid = MakeMaid()
	baseInstance.Gui = guiElement or error("No Gui")
	baseInstance.Container = baseInstance.Gui.Parent or error("No container")
	return baseInstance
end
function ScrollingFrameBase.Destroy(self)
	self.Maid:DoCleaning()
	self.Maid = nil
	setmetatable(self, nil)
end
local scrollbarClass = setmetatable({}, ScrollingFrameBase)
scrollbarClass.ClassName = "Scrollbar"
scrollbarClass.__index = scrollbarClass
function scrollbarClass.new(guiElement, scrollingFrame)
	local scrollbarInstance = setmetatable(ScrollingFrameBase.new(guiElement), scrollbarClass)
	scrollbarInstance.ScrollingFrame = scrollingFrame or error("No ScrollingFrame")
	scrollbarInstance.ParentScroller = scrollbarInstance.ScrollingFrame:GetScroller()
	scrollbarInstance:UpdateRender()
	scrollbarInstance.DraggingBegan = Signal.new()
	scrollbarInstance.Maid.InputBeganGui = scrollbarInstance.Gui.InputBegan:connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			scrollbarInstance:InputBegan(inputObject)
		end
	end)
	scrollbarInstance.Maid.InputBeganContainer = scrollbarInstance.Container.InputBegan:connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			scrollbarInstance.LastContainerInputObject = inputObject
		end
	end)
	scrollbarInstance.Maid.InputEndedContainer = scrollbarInstance.Container.InputEnded:connect(function(inputObject)
		if inputObject == scrollbarInstance.LastContainerInputObject then
			scrollbarInstance.ParentScroller.TargetContentScrollPercent = (inputObject.Position.Y - scrollbarInstance.Container.AbsolutePosition.Y - scrollbarInstance.Container.AbsoluteSize.Y * scrollbarInstance.ParentScroller.ContentScrollPercentSize / 2) / (scrollbarInstance.Container.AbsoluteSize.Y * (1 - scrollbarInstance.ParentScroller.ContentScrollPercentSize))
			scrollbarInstance.ParentScroller.Velocity = 0
			scrollbarInstance.ScrollingFrame:FreeScroll()
		end
	end)
	return scrollbarInstance
end
function scrollbarClass.StopDrag(self)
	self.ScrollingFrame:StopDrag()
end
function scrollbarClass.InputBegan(self, inputObject)
	local inputMaid = MakeMaid()
	local Position = inputObject.Position
	local ContentScrollPercent = self.ParentScroller.ContentScrollPercent
	local velocityTracker = self.ScrollingFrame:GetVelocityTracker(0.25)
	inputMaid.InputChanged = UserInputService.InputChanged:connect(function(changedInput)
		if changedInput.UserInputType == Enum.UserInputType.MouseMovement then
			self.ParentScroller.ContentScrollPercent = ContentScrollPercent + (changedInput.Position - Position).y / (self.Container.AbsoluteSize.Y * (1 - self.ParentScroller.ContentScrollPercentSize))
			self.ParentScroller.TargetContentScrollPercent = self.ParentScroller.ContentScrollPercent
			self.ScrollingFrame:UpdateRender()
			velocityTracker()
		end
	end)
	inputMaid.InputEnded = UserInputService.InputEnded:connect(function(changedInput)
		if changedInput == inputObject then
			self:StopDrag()
		end
	end)
	self.Maid.UpdateMaid = inputMaid
	self.ScrollingFrame.Maid.UpdateMaid = inputMaid
end
function scrollbarClass.UpdateRender(self)
	if self.ParentScroller.TotalContentLength > self.ParentScroller.ViewSize then
		local RenderedContentScrollPercentSize = self.ParentScroller.RenderedContentScrollPercentSize
		self.Gui.Size = UDim2.new(UDim.new(RenderedContentScrollPercentSize, 0), self.Gui.Size.Y)
		self.Gui.Position = UDim2.new(UDim.new((1 - RenderedContentScrollPercentSize) * self.ParentScroller.RenderedContentScrollPercent, 0), self.Gui.Position.Y)
		self.Gui.Visible = true
	else
		self.Gui.Visible = false
	end
end
local ScrollingFrameClass = setmetatable({}, ScrollingFrameBase)
ScrollingFrameClass.ClassName = "ScrollingFrame"
ScrollingFrameClass.__index = ScrollingFrameClass
function ScrollingFrameClass.new(guiElement, isHorizontal)
	local scrollingFrameInstance = setmetatable(ScrollingFrameBase.new(guiElement), ScrollingFrameClass)
	scrollingFrameInstance.Scrollbars = {}
	scrollingFrameInstance.Scroller = Scroller.new()
	scrollingFrameInstance.Horizontal = isHorizontal
	scrollingFrameInstance.Maid:GiveTask(scrollingFrameInstance:BindInput(scrollingFrameInstance.Container))
	scrollingFrameInstance.Maid.ContainerChanged = scrollingFrameInstance.Container.Changed:connect(function(propertyName)
		if propertyName == "AbsoluteSize" then
			scrollingFrameInstance:UpdateScroller()
			scrollingFrameInstance:FreeScroll()
		end
	end)
	scrollingFrameInstance.Maid.GuiChanged = scrollingFrameInstance.Gui.Changed:connect(function(propertyName)
		if propertyName == "AbsoluteSize" then
			scrollingFrameInstance:UpdateScroller()
			scrollingFrameInstance:FreeScroll()
		end
	end)
	scrollingFrameInstance:UpdateScroller()
	scrollingFrameInstance:UpdateRender()
	return scrollingFrameInstance
end
function ScrollingFrameClass.GetScroller(self)
	return self.Scroller
end
function ScrollingFrameClass.AddScrollbar(self, scrollBarGui)
	local scrollbarInstance = scrollbarClass.new(scrollBarGui, self)
	table.insert(self.Scrollbars, scrollbarInstance)
	self.Maid[scrollBarGui] = scrollbarInstance
end
function ScrollingFrameClass.AddScrollbarFromContainer(self, container)
	local ScrollBar = Instance.new("ImageButton")
	ScrollBar.Size = UDim2.new(1, 0, 0, 100)
	ScrollBar.Name = "ScrollBar"
	ScrollBar.BackgroundColor3 = Color3.new(204/255, 204/255, 204/255)
	ScrollBar.BorderSizePixel = 0
	ScrollBar.Image = ""
	ScrollBar.Parent = container
	ScrollBar.AutoButtonColor = false
	ScrollBar.ZIndex = container.ZIndex
	ScrollBar.Parent = container
	return self:AddScrollbar(ScrollBar)
end
function ScrollingFrameClass.UpdateScroller(self)
	if self.Horizontal then
		self.Scroller.TotalContentLength = self.Gui.AbsoluteSize.x
		self.Scroller.ViewSize = self.Container.AbsoluteSize.x
	else
		self.Scroller.TotalContentLength = self.Gui.AbsoluteSize.y
		self.Scroller.ViewSize = self.Container.AbsoluteSize.y
	end
end
function ScrollingFrameClass.UpdateRender(self)
	if self.Horizontal then
		self.Gui.Position = UDim2.new(UDim.new(0, self.Scroller.BoundedRenderPosition), self.Gui.Position.Y)
	else
		self.Gui.Position = UDim2.new(self.Gui.Position.X, UDim.new(0, self.Scroller.BoundedRenderPosition))
	end
	for k, scrollbar in pairs(self.Scrollbars) do
		scrollbar:UpdateRender()
	end
end
function ScrollingFrameClass.StopUpdate(self)
	self.Maid.UpdateMaid = nil
end
function ScrollingFrameClass.StopDrag(self)
	local Position = self.Scroller.Position
	if self.Scroller:GetDisplacementPastBounds(self.Scroller.Position) == 0 then
		if self.Scroller.Velocity > 0 then
			self.Scroller.Target = math.max(self.Scroller.Target, self.Scroller.Position + self.Scroller.Velocity * 0.5)
		else
			self.Scroller.Target = math.min(self.Scroller.Target, self.Scroller.Position + self.Scroller.Velocity * 0.5)
		end
	end
	self:FreeScroll()
end
function ScrollingFrameClass.FreeScroll(self)
	local renderMaid = MakeMaid()
	self:UpdateRender()
	renderMaid.RenderStepped = RunService.RenderStepped:connect(function()
		self:UpdateRender()
		if self.Scroller.AtRest then
			self:StopUpdate()
		end
	end)
	self.Maid.UpdateMaid = renderMaid
end
function ScrollingFrameClass.GetVelocityTracker(self, damping)
	local dampingAmount = damping or 1
	self.Scroller.Velocity = 0
	local lastTickTime = tick()
	local lastPosition = self.Scroller.Position
	return function()
		local currentPosition = self.Scroller.Position
		local deltaTime = tick() - lastTickTime
		lastTickTime = tick()
		local positionDelta = lastPosition - currentPosition
		lastPosition = currentPosition
		self.Scroller.Velocity = self.Scroller.Velocity - positionDelta / (0.0001 + deltaTime) * dampingAmount
	end
end
function ScrollingFrameClass.GetProcessInput(self, inputObject)
	local Position = self.Scroller.Position
	local velocityTracker = self:GetVelocityTracker(0.25)
	local startingInputPosition = inputObject.Position
	return function(currentInput)
		local displacement = if self.Horizontal then (currentInput.Position - startingInputPosition).x else (currentInput.Position - startingInputPosition).y
		local newPosition = Position - displacement
		self.Scroller.Position = newPosition
		self.Scroller.Target = newPosition
		self:UpdateRender()
		velocityTracker()
		return displacement
	end
end
function ScrollingFrameClass.ScrollTo(self, targetPosition, skipAnimation)
	self.Scroller.Target = targetPosition
	if skipAnimation then
		self.Scroller.Position = self.Scroller.Target
		self.Scroller.Velocity = 0
	end
end
function ScrollingFrameClass.ScrollToTop(self, skipAnimation)
	self:ScrollTo(self.Scroller.Min, skipAnimation)
end
function ScrollingFrameClass.ScrollToBottom(self, skipAnimation)
	self:ScrollTo(self.Scroller.Max, skipAnimation)
end
function ScrollingFrameClass.BindInput(self, container, callbackData)
	local inputMaid = MakeMaid()
	local lastInputTime = 0
	inputMaid.GuiInputBegan = container.InputBegan:connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject then
				local currentTime = tick()
				if currentTime - lastInputTime > 0.1 then
					lastInputTime = currentTime
					if self.Horizontal then
						self.Scroller.Target = SelectedObject.AbsolutePosition.X - self.Gui.AbsolutePosition.X - 100
					end
					self:FreeScroll()
				end
			end
		end
		self:InputBegan(inputObject, callbackData)
	end)
	inputMaid.GuiInputChanged = container.InputChanged:connect(function(inputObject)
		if container.Active and inputObject.UserInputType == Enum.UserInputType.MouseWheel then
			self.Scroller.Target = self.Scroller.Target + -inputObject.Position.z * 80
			self:FreeScroll()
		end
	end)
	inputMaid.AllInputBegan = UserInputService.InputBegan:Connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject and SelectedObject:IsDescendantOf(container) then
				self:InputBegan(inputObject, callbackData)
			end
		end
	end)
	local lastGamepadInputTime = tick()
	inputMaid.AllInputChanged = UserInputService.InputChanged:Connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then
			if tick() - lastGamepadInputTime < 0.01 then
				return false
			end
			lastGamepadInputTime = tick()
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject and SelectedObject:IsDescendantOf(container) then
				if self.Horizontal then
					self.Scroller.Target = SelectedObject.AbsolutePosition.X - self.Gui.AbsolutePosition.X - 200
				end
				self:FreeScroll()
			end
		end
	end)
	return inputMaid
end
function ScrollingFrameClass.InputBegan(self, inputObject, callbackData)
	if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or (inputObject.UserInputType == Enum.UserInputType.Touch or inputObject.UserInputType == Enum.UserInputType.Gamepad1 and inputObject.KeyCode == Enum.KeyCode.ButtonA) then
		local dragMaid = MakeMaid()
		local dragStartTime = tick()
		local dragDistance = 0
		local processInputFn = self:GetProcessInput(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			dragMaid.InputChanged = UserInputService.InputChanged:connect(function(changedInput, changedInputType)
				if changedInput.UserInputType == Enum.UserInputType.MouseMovement then
					dragDistance = dragDistance + math.abs((processInputFn(changedInput)))
				end
			end)
		elseif inputObject.UserInputType == Enum.UserInputType.Touch then
			local function Update(changedInput, changedInputType)
				if changedInput.UserInputType == Enum.UserInputType.Touch then
					dragDistance = dragDistance + math.abs((processInputFn(changedInput)))
				end
			end
			dragMaid.InputChanged = UserInputService.InputChanged:connect(Update)
		end
		function dragMaid.Cleanup()
			self:UpdateRender()
			if callbackData and callbackData.OnClick and if tick() - dragStartTime <= 0.1 then true else dragDistance < 1 then
				callbackData.OnClick(inputObject)
			end
		end
		dragMaid.InputEnded = UserInputService.InputEnded:connect(function(endedInput, endedInputType)
			if endedInput == inputObject then
				self:StopDrag()
			end
		end)
		dragMaid.WindowFocusReleased = UserInputService.WindowFocusReleased:connect(function()
			self:StopDrag()
		end)
		self.Maid.UpdateMaid = dragMaid
	end
end
return ScrollingFrameClass
