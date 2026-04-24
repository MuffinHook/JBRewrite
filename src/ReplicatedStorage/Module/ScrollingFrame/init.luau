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
	local table2 = setmetatable({}, t)
	table2.Spring = SpringPhysics.Spring.New(0)
	table2.Spring.Speed = 20
	return table2
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
		local tbl = p1:GetTimesOverBounds(Position)
		local table2 = p1:GetScale(tbl)
		if tbl > 0 then
			return -p1.ContentMax - table2 * p1.BackBounceRenderRange
		elseif tbl < 0 then
			return p1.ContentMin + table2 * p1.BackBounceRenderRange
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
	local table2 = setmetatable({}, t2)
	table2.Maid = MakeMaid()
	table2.Gui = p1 or error("No Gui")
	table2.Container = table2.Gui.Parent or error("No container")
	return table2
end
function t2.Destroy(p1)
	p1.Maid:DoCleaning()
	p1.Maid = nil
	setmetatable(p1, nil)
end
local tbl = setmetatable({}, t2)
tbl.ClassName = "Scrollbar"
tbl.__index = tbl
function tbl.new(p1, p2)
	local instance3 = setmetatable(t2.new(p1), tbl)
	instance3.ScrollingFrame = p2 or error("No ScrollingFrame")
	instance3.ParentScroller = instance3.ScrollingFrame:GetScroller()
	instance3:UpdateRender()
	instance3.DraggingBegan = Signal.new()
	instance3.Maid.InputBeganGui = instance3.Gui.InputBegan:connect(function(p1)
		if p1.UserInputType == Enum.UserInputType.MouseButton1 then
			instance3:InputBegan(p1)
		end
	end)
	instance3.Maid.InputBeganContainer = instance3.Container.InputBegan:connect(function(p1)
		if p1.UserInputType == Enum.UserInputType.MouseButton1 then
			instance3.LastContainerInputObject = p1
		end
	end)
	instance3.Maid.InputEndedContainer = instance3.Container.InputEnded:connect(function(p1)
		if p1 == instance3.LastContainerInputObject then
			instance3.ParentScroller.TargetContentScrollPercent = (p1.Position.Y - instance3.Container.AbsolutePosition.Y - instance3.Container.AbsoluteSize.Y * instance3.ParentScroller.ContentScrollPercentSize / 2) / (instance3.Container.AbsoluteSize.Y * (1 - instance3.ParentScroller.ContentScrollPercentSize))
			instance3.ParentScroller.Velocity = 0
			instance3.ScrollingFrame:FreeScroll()
		end
	end)
	return instance3
end
function tbl.StopDrag(p1)
	p1.ScrollingFrame:StopDrag()
end
function tbl.InputBegan(p1, p2)
	local tbl = MakeMaid()
	local Position = p2.Position
	local ContentScrollPercent = p1.ParentScroller.ContentScrollPercent
	local table2 = p1.ScrollingFrame:GetVelocityTracker(0.25)
	tbl.InputChanged = UserInputService.InputChanged:connect(function(p12)
		if p12.UserInputType == Enum.UserInputType.MouseMovement then
			p1.ParentScroller.ContentScrollPercent = ContentScrollPercent + (p12.Position - Position).y / (p1.Container.AbsoluteSize.Y * (1 - p1.ParentScroller.ContentScrollPercentSize))
			p1.ParentScroller.TargetContentScrollPercent = p1.ParentScroller.ContentScrollPercent
			p1.ScrollingFrame:UpdateRender()
			table2()
		end
	end)
	tbl.InputEnded = UserInputService.InputEnded:connect(function(p12)
		if p12 == p2 then
			p1:StopDrag()
		end
	end)
	p1.Maid.UpdateMaid = tbl
	p1.ScrollingFrame.Maid.UpdateMaid = tbl
end
function tbl.UpdateRender(p1)
	if p1.ParentScroller.TotalContentLength > p1.ParentScroller.ViewSize then
		local RenderedContentScrollPercentSize = p1.ParentScroller.RenderedContentScrollPercentSize
		p1.Gui.Size = UDim2.new(UDim.new(RenderedContentScrollPercentSize, 0), p1.Gui.Size.Y)
		p1.Gui.Position = UDim2.new(UDim.new((1 - RenderedContentScrollPercentSize) * p1.ParentScroller.RenderedContentScrollPercent, 0), p1.Gui.Position.Y)
		p1.Gui.Visible = true
	else
		p1.Gui.Visible = false
	end
end
local table2 = setmetatable({}, t2)
table2.ClassName = "ScrollingFrame"
table2.__index = table2
function table2.new(p1, p2)
	local instance3 = setmetatable(t2.new(p1), table2)
	instance3.Scrollbars = {}
	instance3.Scroller = t.new()
	instance3.Horizontal = p2
	instance3.Maid:GiveTask(instance3:BindInput(instance3.Container))
	instance3.Maid.ContainerChanged = instance3.Container.Changed:connect(function(p1)
		if p1 == "AbsoluteSize" then
			instance3:UpdateScroller()
			instance3:FreeScroll()
		end
	end)
	instance3.Maid.GuiChanged = instance3.Gui.Changed:connect(function(p1)
		if p1 == "AbsoluteSize" then
			instance3:UpdateScroller()
			instance3:FreeScroll()
		end
	end)
	instance3:UpdateScroller()
	instance3:UpdateRender()
	return instance3
end
function table2.GetScroller(p1)
	return p1.Scroller
end
function table2.AddScrollbar(p1, p2)
	local instance12 = tbl.new(p2, p1)
	table.insert(p1.Scrollbars, instance12)
	p1.Maid[p2] = instance12
end
function table2.AddScrollbarFromContainer(p1, p2)
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
function table2.UpdateScroller(p1)
	if p1.Horizontal then
		p1.Scroller.TotalContentLength = p1.Gui.AbsoluteSize.x
		p1.Scroller.ViewSize = p1.Container.AbsoluteSize.x
	else
		p1.Scroller.TotalContentLength = p1.Gui.AbsoluteSize.y
		p1.Scroller.ViewSize = p1.Container.AbsoluteSize.y
	end
end
function table2.UpdateRender(p1)
	if p1.Horizontal then
		p1.Gui.Position = UDim2.new(UDim.new(0, p1.Scroller.BoundedRenderPosition), p1.Gui.Position.Y)
	else
		p1.Gui.Position = UDim2.new(p1.Gui.Position.X, UDim.new(0, p1.Scroller.BoundedRenderPosition))
	end
	for k, v in pairs(p1.Scrollbars) do
		v:UpdateRender()
	end
end
function table2.StopUpdate(p1)
	p1.Maid.UpdateMaid = nil
end
function table2.StopDrag(p1)
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
function table2.FreeScroll(p1)
	local tbl = MakeMaid()
	p1:UpdateRender()
	tbl.RenderStepped = RunService.RenderStepped:connect(function()
		p1:UpdateRender()
		if p1.Scroller.AtRest then
			p1:StopUpdate()
		end
	end)
	p1.Maid.UpdateMaid = tbl
end
function table2.GetVelocityTracker(p1, p2)
	local tbl = p2 or 1
	p1.Scroller.Velocity = 0
	local table2 = tick()
	local Position = p1.Scroller.Position
	return function()
		local Position_2 = p1.Scroller.Position
		local instance12 = tick() - table2
		table2 = tick()
		local var22 = Position - Position_2
		Position = Position_2
		p1.Scroller.Velocity = p1.Scroller.Velocity - var22 / (0.0001 + instance12) * tbl
	end
end
function table2.GetProcessInput(p1, p2)
	local Position = p1.Scroller.Position
	local tbl = p1:GetVelocityTracker(0.25)
	local Position_2 = p2.Position
	return function(p12)
		local instance12 = if p1.Horizontal then (p12.Position - Position_2).x else (p12.Position - Position_2).y
		local table2 = Position - instance12
		p1.Scroller.Position = table2
		p1.Scroller.Target = table2
		p1:UpdateRender()
		tbl()
		return instance12
	end
end
function table2.ScrollTo(p1, p2, p3)
	p1.Scroller.Target = p2
	if p3 then
		p1.Scroller.Position = p1.Scroller.Target
		p1.Scroller.Velocity = 0
	end
end
function table2.ScrollToTop(p1, p2)
	p1:ScrollTo(p1.Scroller.Min, p2)
end
function table2.ScrollToBottom(p1, p2)
	p1:ScrollTo(p1.Scroller.Max, p2)
end
function table2.BindInput(p1, p2, p3)
	local tbl = MakeMaid()
	local table2 = 0
	tbl.GuiInputBegan = p2.InputBegan:connect(function(p12)
		if p12.UserInputType == Enum.UserInputType.MouseMovement then
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject then
				local tbl = tick()
				if tbl - table2 > 0.1 then
					table2 = tbl
					if p1.Horizontal then
						p1.Scroller.Target = SelectedObject.AbsolutePosition.X - p1.Gui.AbsolutePosition.X - 100
					end
					p1:FreeScroll()
				end
			end
		end
		p1:InputBegan(p12, p3)
	end)
	tbl.GuiInputChanged = p2.InputChanged:connect(function(p12)
		if p2.Active and p12.UserInputType == Enum.UserInputType.MouseWheel then
			p1.Scroller.Target = p1.Scroller.Target + -p12.Position.z * 80
			p1:FreeScroll()
		end
	end)
	tbl.AllInputBegan = UserInputService.InputBegan:Connect(function(p12)
		if p12.UserInputType == Enum.UserInputType.Gamepad1 then
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject and SelectedObject:IsDescendantOf(p2) then
				p1:InputBegan(p12, p3)
			end
		end
	end)
	local instance3 = tick()
	tbl.AllInputChanged = UserInputService.InputChanged:Connect(function(p12)
		if p12.UserInputType == Enum.UserInputType.Gamepad1 then
			if tick() - instance3 < 0.01 then
				return false
			end
			instance3 = tick()
			local SelectedObject = GuiService.SelectedObject
			if SelectedObject and SelectedObject:IsDescendantOf(p2) then
				if p1.Horizontal then
					p1.Scroller.Target = SelectedObject.AbsolutePosition.X - p1.Gui.AbsolutePosition.X - 200
				end
				p1:FreeScroll()
			end
		end
	end)
	return tbl
end
function table2.InputBegan(p1, p2, p3)
	if p2.UserInputType == Enum.UserInputType.MouseButton1 or (p2.UserInputType == Enum.UserInputType.Touch or p2.UserInputType == Enum.UserInputType.Gamepad1 and p2.KeyCode == Enum.KeyCode.ButtonA) then
		local tbl = MakeMaid()
		local table2 = tick()
		local instance3 = 0
		local var4 = p1:GetProcessInput(p2)
		if p2.UserInputType == Enum.UserInputType.MouseButton1 then
			tbl.InputChanged = UserInputService.InputChanged:connect(function(p1, p2)
				if p1.UserInputType == Enum.UserInputType.MouseMovement then
					instance3 = instance3 + math.abs((var4(p1)))
				end
			end)
		elseif p2.UserInputType == Enum.UserInputType.Touch then
			local function Update(p1, p2)
				if p1.UserInputType == Enum.UserInputType.Touch then
					instance3 = instance3 + math.abs((var4(p1)))
				end
			end
			tbl.InputChanged = UserInputService.InputChanged:connect(Update)
		end
		function tbl.Cleanup()
			p1:UpdateRender()
			if p3 and p3.OnClick and if tick() - table2 <= 0.1 then true else instance3 < 1 then
				p3.OnClick(p2)
			end
		end
		tbl.InputEnded = UserInputService.InputEnded:connect(function(p12, p22)
			if p12 == p2 then
				p1:StopDrag()
			end
		end)
		tbl.WindowFocusReleased = UserInputService.WindowFocusReleased:connect(function()
			p1:StopDrag()
		end)
		p1.Maid.UpdateMaid = tbl
	end
end
return table2
