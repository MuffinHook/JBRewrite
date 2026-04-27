local function MakeWindowGroup()
	return {
		Windows = {}
	}
end
local function WindowGroupAdd(windowGroup, windowToAdd)
	table.insert(windowGroup.Windows, windowToAdd)
	windowToAdd.Group = windowGroup
end
local function MakeWindowGroupA(...)
	local windowGroup = {
		Windows = {}
	}
	for index, window in next, { ... } do
		table.insert(windowGroup.Windows, window)
		window.Group = windowGroup
	end
end
local function MakeWindow()
	return {
		IsOpen = false,
		OpenFun = nil,
		CloseFun = nil,
		Group = nil
	}
end
local function WindowClose(windowInstance)
	windowInstance.IsOpen = false
	windowInstance.CloseFun()
end
local function WindowOpen(windowInstance)
	local Group = windowInstance.Group
	if Group then
		for groupIndex, otherWindow in next, Group.Windows do
			if otherWindow ~= windowInstance and otherWindow.IsOpen then
				otherWindow.IsOpen = false
				otherWindow.CloseFun()
			end
		end
	end
	windowInstance.IsOpen = true
	windowInstance.OpenFun()
end
return {
	MakeWindowGroup = MakeWindowGroup,
	WindowGroupAdd = WindowGroupAdd,
	MakeWindowGroupA = MakeWindowGroupA,
	MakeWindow = MakeWindow,
	WindowOpen = WindowOpen,
	WindowClose = WindowClose,
	WindowToggle = function(windowInstance)
		windowInstance.IsOpen = not windowInstance.IsOpen
		if windowInstance.IsOpen then
			WindowOpen(windowInstance)
		else
			windowInstance.IsOpen = false
			windowInstance.CloseFun()
		end
	end
}
