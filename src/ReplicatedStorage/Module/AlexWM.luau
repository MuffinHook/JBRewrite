-- Reviewed by Claude
local function MakeWindowGroup()
	return {
		Windows = {}
	}
end
local function WindowGroupAdd(p1, p2)
	table.insert(p1.Windows, p2)
	p2.Group = p1
end
local function MakeWindowGroupA(...)
	local t = {
		Windows = {}
	}
	for v1, v2 in next, { ... } do
		table.insert(t.Windows, v2)
		v2.Group = t
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
local function WindowClose(p1)
	p1.IsOpen = false
	p1.CloseFun()
end
local function WindowOpen(p1)
	local Group = p1.Group
	if Group then
		for v1, v2 in next, Group.Windows do
			if v2 ~= p1 and v2.IsOpen then
				v2.IsOpen = false
				v2.CloseFun()
			end
		end
	end
	p1.IsOpen = true
	p1.OpenFun()
end
return {
	MakeWindowGroup = MakeWindowGroup,
	WindowGroupAdd = WindowGroupAdd,
	MakeWindowGroupA = MakeWindowGroupA,
	MakeWindow = MakeWindow,
	WindowOpen = WindowOpen,
	WindowClose = WindowClose,
	WindowToggle = function(p1)
		p1.IsOpen = not p1.IsOpen
		if p1.IsOpen then
			WindowOpen(p1)
		else
			p1.IsOpen = false
			p1.CloseFun()
		end
	end
}
