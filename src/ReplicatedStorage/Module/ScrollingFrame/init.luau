-- Reviewed by Claude
game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local MakeMaid = require(script.ScrollingFrameMaid).MakeMaid
local SpringPhysics = require(script.SpringPhysics)
local Signal = require(script.Signal)
local t = {
	ClassName = "Scroller"
}
t.__index = t
t._Position = 0
t._Min = 0
t._Max = 100
t._ViewSize = 50
function t.new()
	local v2 = setmetatable({}, t)
	v2.Spring = SpringPhysics.Spring.New(0)
	v2.Spring.Speed = 20
	return v2
end
function t.GetTimesOverBounds(p1, p2)
	return p1:GetDisplacementPastBounds(p2) / p1.BackBounceInputRange
end
function t.GetDisplacementPastBounds(p1, p2)
	if p1.ContentMax < p2 then
		return p2 - p1.ContentMax
	elseif p2 < p1.ContentMin then
		return p2
	else
		return 0
	end
end
function t.GetScale(p1, p2)
	return 1 - 0.5 ^ math.abs(p2)
end
function t.__index(p1, p2)
	if p2 == "TotalContentLength" then
		return p1._Max - p1._Min
	elseif p2 == "ViewSize" then
		return p1._ViewSize
	elseif p2 == "Max" then
		return p1._Max
	elseif p2 == "ContentMax" then
		if p1._Max <= p1.ContentMin + p1._ViewSize then
			return p1.ContentMin
		else
			return p1._Max - p1._ViewSize
		end
	elseif p2 == "Min" or p2 == "ContentMin" then
		return p1._Min
	elseif p2 == "Position" then
		return p1.Spring.Position
	elseif p2 == "BackBounceInputRange" or p2 == "BackBounceRenderRange" then
		return p1._ViewSize
	elseif p2 == "ContentScrollPercentSize" then
		if p1.TotalContentLength == 0 then
			return 0
		else
			return p1._ViewSize / p1.TotalContentLength
		end
	elseif p2 == "RenderedContentScrollPercentSize" then
		return p1.ContentScrollPercentSize * (1 - p1:GetScale(p1:GetTimesOverBounds(p1.Position)))
	elseif p2 == "ContentScrollPercent" then
		return (p1.Position - p1._Min) / (p1.TotalContentLength - p1._ViewSize)
	elseif p2 == "RenderedContentScrollPercent" then
		local ContentScrollPercent = p1.ContentScrollPercent
		if ContentScrollPercent < 0 then
			return 0
		elseif ContentScrollPercent > 1 then
			return 1
		else
			return ContentScrollPercent
		end
	elseif p2 == "BoundedRenderPosition" then
		local Position = p1.Position
		local v1 = p1:GetTimesOverBounds(Position)
		local v2 = p1:GetScale(v1)
		if v1 > 0 then
			return -p1.ContentMax - v2 * p1.BackBounceRenderRange
		elseif v1 < 0 then
			return p1.ContentMin + v2 * p1.BackBounceRenderRange
		else
			return -Position
		end
	else
		if p2 == "Velocity" then
			return p1.Spring.Velocity
		end
		if p2 == "Target" then
			return p1.Spring.Target
		end
		if p2 == "AtRest" then
			return if math.abs(p1.Spring.Target - p1.Spring.Position) < 0.00001 then math.abs(p1.Spring.Velocity) < 0.00001 else false
		end
		if t[p2] then
			return t[p2]
		end
		error(("[Scroller] - \'%s\' is not a valid member"):format((tostring(p2))))
	end
end
function t.__newindex(p1, p2, p3)
	if t[p2] or p2 == "Spring" then
		rawset(p1, p2, p3)
	elseif p2 == "Min" or p2 == "ContentMin" then
		p1._Min = p3
	elseif p2 == "Max" then
		p1._Max = p3
		p1.Target = p1.Target
	elseif p2 == "TotalContentLength" then
		p1.Max = p1._Min + p3
	elseif p2 == "ViewSize" then
		p1._ViewSize = p3
	elseif p2 == "Position" then
		p1.Spring.Position = p3
	elseif p2 == "TargetContentScrollPercent" then
		p1.Target = p1._Min + p3 * (p1.TotalContentLength - p1._ViewSize)
	elseif p2 == "ContentScrollPercent" then
		p1.Position = p1._Min + p3 * (p1.TotalContentLength - p1._ViewSize)
	elseif p2 == "Target" then
		if p1.ContentMax < p3 then
			p3 = p1.ContentMax
		elseif p3 < p1.ContentMin then
			p3 = p1.ContentMin
		end
		p1.Spring.Target = p3
	elseif p2 == "Velocity" then
		p1.Spring.Velocity = p3
	else
		error(("[Scroller] - \'%s\' is not a valid member"):format((tostring(p2))))
	end
end
local t2 = {
	ClassName = "Base"
}
t2.__index = t2
function t2.new(p1)
	local v2 = setmetatable({}, t2)
	v2.Maid = MakeMaid()
	v2.Gui = p1 or error("No Gui")
	v2.Container = v2.Gui.Parent or error("No container")
	return v2
end
function t2.Destroy(p1)
	p1.Maid:DoCleaning()
	p1.Maid = nil
	setmetatable(p1, nil)
end
local v1 = setmetatable({}, t2)
v1.ClassName = "Scrollbar"
v1.__index = v1
function v1.new(p1, p2)
	local v3 = setmetatable(t2.new(p1), v1)
	v3.ScrollingFrame = p2 or error("No ScrollingFrame")
	v3.ParentScroller = v3.ScrollingFrame:GetScroller()
	v3:UpdateRender()
	v3.DraggingBegan = Signal.new()
	v3.Maid.InputBeganGui = v3.Gui.InputBegan:connect(function(p1)
		if p1.UserInputType == Enum.UserInputType.MouseButton1 then
			v3:InputBegan(p1)
		end
	end)
	v3.Maid.InputBeganContainer = v3.Container.InputBegan:connect(function(p1)
		if p1.UserInputType == Enum.UserInputType.MouseButton1 then
			v3.LastContainerInputObject = p1
		end
	end)
	v3.Maid.InputEndedContainer = v3.Container.InputEnded:connect(function(p1)
		if p1 == v3.LastContainerInputObject then
			v3.ParentScroller.TargetContentScrollPercent = (p1.Position.Y - v3.Container.AbsolutePosition.Y - v3.Container.AbsoluteSize.Y * v3.ParentScroller.ContentScrollPercentSize / 2) / (v3.Container.AbsoluteSize.Y * (1 - v3.ParentScroller.ContentScrollPercentSize))
			v3.ParentScroller.Velocity = 0
			v3.ScrollingFrame:FreeScroll()
		end
	end)
	return v3
end
function v1.StopDrag(p1)
	p1.ScrollingFrame:StopDrag()
end
function v1.InputBegan(p1, p2)
	local v1 = MakeMaid()
	local Position = p2.Position
	local ContentScrollPercent = p1.ParentScroller.ContentScrollPercent
	local v2 = p1.ScrollingFrame:GetVelocityTracker(0.25)
	v1.InputChanged = UserInputService.InputChanged:connect(function(p12)
		if p12.UserInputType == Enum.UserInputType.MouseMovement then
			p1.ParentScroller.ContentScrollPercent = ContentScrollPercent + (p12.Position - Position).y / (p1.Container.AbsoluteSize.Y * (1 - p1.ParentScroller.ContentScrollPercentSize))
			p1.ParentScroller.TargetContentScrollPercent = p1.ParentScroller.ContentScrollPercent
			p1.ScrollingFrame:UpdateRender()
			v2()
		end
	end)
	v1.InputEnded = UserInputService.InputEnded:connect(function(p12)
		if p12 == p2 then
			p1:StopDrag()
		end
	end)
	p1.Maid.UpdateMaid = v1
	p1.ScrollingFrame.Maid.UpdateMaid = v1
end
function v1.UpdateRender(p1)
	if p1.ParentScroller.TotalContentLength > p1.ParentScroller.ViewSize then
		local RenderedContentScrollPercentSize = p1.ParentScroller.RenderedContentScrollPercentSize
		p1.Gui.Size = UDim2.new(UDim.new(RenderedContentScrollPercentSize, 0), p1.Gui.Size.Y)
		p1.Gui.Position = UDim2.new(UDim.new((1 - RenderedContentScrollPercentSize) * p1.ParentScroller.RenderedContentScrollPercent, 0), p1.Gui.Position.Y)
		p1.Gui.Visible = true
	else
		p1.Gui.Visible = false
	end
end
local v2 = setmetatable({}, t2)
v2.ClassName = "ScrollingFrame"
v2.__index = v2
function v2.new(p1, p2)
	local v3 = setmetatable(t2.new(p1), v2)
	v3.Scrollbars = {}
	v3.Scroller = t.new()
	v3.Horizontal = p2
	v3.Maid:GiveTask(v3:BindInput(v3.Container))
	v3.Maid.ContainerChanged = v3.Container.Changed:connect(function(p1)
		if p1 == "AbsoluteSize" then
			v3:UpdateScroller()
			v3:FreeScroll()
		end
	end)
	v3.Maid.GuiChanged = v3.Gui.Changed:connect(function(p1)
		if p1 == "AbsoluteSize" then
			v3:UpdateScroller()
			v3:FreeScroll()
		end
	end)
	v3:UpdateScroller()
	v3:UpdateRender()
	return v3
end
function v2.GetScroller(p1)
	return p1.Scroller
end
function v2.AddScrollbar(p1, p2)
	local v12 = v1.new(p2, p1)
	table.insert(p1.Scrollbars, v12)
	p1.Maid[p2] = v12
end
function v2.AddScrollbarFromContainer(p1, p2)
	local ScrollBar = Instance.new("ImageButton")
	ScrollBar.Size = UDim2.new(1, 0, 0, 100)
	ScrollBar.Name = "ScrollBar"
	ScrollBar.BackgroundColor3 = Color3.new(204/255, 204/255, 204/255)
	ScrollBar.BorderSizePixel = 0
	ScrollBar.Image = ""
	ScrollBar.Parent = p2
	ScrollBar.AutoButtonColor = false
	ScrollBar.ZIndex = p2.ZIndex
	ScrollBar.Parent = p2
	return p1:AddScrollbar(ScrollBar)
end
function v2.UpdateScroller(p1)
	if p1.Horizontal then
		p1.Scroller.TotalContentLength = p1.Gui.AbsoluteSize.x
		p1.Scroller.ViewSize = p1.Container.AbsoluteSize.x
	else
		p1.Scroller.TotalContentLength = p1.Gui.AbsoluteSize.y
		p1.Scroller.ViewSize = p1.Container.AbsoluteSize.y
	end
end
function v2.UpdateRender(p1)
	if p1.Horizontal then
		p1.Gui.Position = UDim2.new(UDim.new(0, p1.Scroller.BoundedRenderPosition), p1.Gui.Position.Y)
	else
		p1.Gui.Position = UDim2.new(p1.Gui.Position.X, UDim.new(0, p1.Scroller.BoundedRenderPosition))
	end
	for k, v in pairs(p1.Scrollbars) do
		v:UpdateRender()
	end
end
function v2.StopUpdate(p1)
	p1.Maid.UpdateMaid = nil
end
function v2.StopDrag(p1)
	local Position = p1.Scroller.Position
	if p1.Scroller:GetDisplacementPastBounds(p1.Scroller.Position) == 0 then
		if p1.Scroller.Velocity > 0 then
			p1.Scroller.Target = math.max(p1.Scroller.Target, p1.Scroller.Position + p1.Scroller.Velocity * 0.5)
		else
			p1.Scroller.Target = math.min(p1.Scroller.Target, p1.Scroller.Position + p1.Scroller.Velocity * 0.5)
		end
	end
	p1:FreeScroll()
end
function v2.FreeScroll(p1)
	local v1 = MakeMaid()
	p1:UpdateRender()
	v1.RenderStepped = RunService.RenderStepped:connect(function()
		p1:UpdateRender()
		if p1.Scroller.AtRest then
			p1:StopUpdate()
		end
	end)
	p1.Maid.UpdateMaid = v1
end
function v2.GetVelocityTracker(p1, p2)
	local v1 = p2 or 1
	p1.Scroller.Velocity = 0
	local v2 = tick()
	local Position = p1.Scroller.Position
	return function()
		local Position_2 = p1.Scroller.Position
		local v12 = tick() - v2
		v2 = tick()
		local v22 = Position - Position_2
		Position = Position_2
		p1.Scroller.Velocity = p1.Scroller.Velocity - v22 / (0.0001 + v12) * v1
	end
end
function v2.GetProcessInput(p1, p2)
	local Position = p1.Scroller.Position
	local v1 = p1:GetVelocityTracker(0.25)
	local Position_2 = p2.Position
	return function(p12)
		local v12 = if p1.Horizontal then (p12.Position - Position_2).x else (p12.Position - Position_2).y
		local v2 = Position - v12
		p1.Scroller.Position = v2
		p1.Scroller.Target = v2
		p1:UpdateRender()
		v1()
		return v12
	end
end
function v2.ScrollTo(p1, p2, p3)
	p1.Scroller.Target = p2
	if p3 then
		p1.Scroller.Position = p1.Scroller.Target
		p1.Scroller.Velocity = 0
	end
end
function v2.ScrollToTop(p1, p2)
	p1:ScrollTo(p1.Scroller.Min, p2)
end
function v2.ScrollToBottom(p1, p2)
	p1:ScrollTo(p1.Scroller.Max, p2)
end
function v2.BindInput(p1, p2, p3)
	local v1 = MakeMaid()
	local v2 = 0
	v1.GuiInputBegan = p2.InputBegan:connect(function(p12)
		if p12.UserInputType == Enum.UserInputType.MouseMovement then
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject then
				local v1 = tick()
				if v1 - v2 > 0.1 then
					v2 = v1
					if p1.Horizontal then
						p1.Scroller.Target = SelectedObject.AbsolutePosition.X - p1.Gui.AbsolutePosition.X - 100
					end
					p1:FreeScroll()
				end
			end
		end
		p1:InputBegan(p12, p3)
	end)
	v1.GuiInputChanged = p2.InputChanged:connect(function(p12)
		if p2.Active and p12.UserInputType == Enum.UserInputType.MouseWheel then
			p1.Scroller.Target = p1.Scroller.Target + -p12.Position.z * 80
			p1:FreeScroll()
		end
	end)
	v1.AllInputBegan = UserInputService.InputBegan:Connect(function(p12)
		if p12.UserInputType == Enum.UserInputType.Gamepad1 then
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject and SelectedObject:IsDescendantOf(p2) then
				p1:InputBegan(p12, p3)
			end
		end
	end)
	local v3 = tick()
	v1.AllInputChanged = UserInputService.InputChanged:Connect(function(p12)
		if p12.UserInputType == Enum.UserInputType.Gamepad1 then
			if tick() - v3 < 0.01 then
				return false
			end
			v3 = tick()
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject and SelectedObject:IsDescendantOf(p2) then
				if p1.Horizontal then
					p1.Scroller.Target = SelectedObject.AbsolutePosition.X - p1.Gui.AbsolutePosition.X - 200
				end
				p1:FreeScroll()
			end
		end
	end)
	return v1
end
function v2.InputBegan(p1, p2, p3)
	if p2.UserInputType == Enum.UserInputType.MouseButton1 or (p2.UserInputType == Enum.UserInputType.Touch or p2.UserInputType == Enum.UserInputType.Gamepad1 and p2.KeyCode == Enum.KeyCode.ButtonA) then
		local v1 = MakeMaid()
		local v2 = tick()
		local v3 = 0
		local v4 = p1:GetProcessInput(p2)
		if p2.UserInputType == Enum.UserInputType.MouseButton1 then
			v1.InputChanged = UserInputService.InputChanged:connect(function(p1, p2)
				if p1.UserInputType == Enum.UserInputType.MouseMovement then
					v3 = v3 + math.abs((v4(p1)))
				end
			end)
		elseif p2.UserInputType == Enum.UserInputType.Touch then
			local function Update(p1, p2)
				if p1.UserInputType == Enum.UserInputType.Touch then
					v3 = v3 + math.abs((v4(p1)))
				end
			end
			v1.InputChanged = UserInputService.InputChanged:connect(Update)
		end
		function v1.Cleanup()
			p1:UpdateRender()
			if p3 and p3.OnClick and if tick() - v2 <= 0.1 then true else v3 < 1 then
				p3.OnClick(p2)
			end
		end
		v1.InputEnded = UserInputService.InputEnded:connect(function(p12, p22)
			if p12 == p2 then
				p1:StopDrag()
			end
		end)
		v1.WindowFocusReleased = UserInputService.WindowFocusReleased:connect(function()
			p1:StopDrag()
		end)
		p1.Maid.UpdateMaid = v1
	end
end
return v2
