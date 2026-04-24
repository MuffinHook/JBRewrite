-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {}
t.__index = t
function t.new()
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._listWindow = {}
	t2._maid:GiveTask(function()
		for i, v in ipairs(t2._listWindow) do
			v:Destroy()
		end
		t2._listWindow = nil
	end)
	return t2
end
function t.Add(p1, p2)
	assert(p2.__ClassName == "Window")
	for i, v in ipairs(p1._listWindow) do
		if p2 == v then
			error("Window already exists in group.")
		end
	end
	table.insert(p1._listWindow, p2)
	function p2._beforeOpenFun()
		for i, v in ipairs(p1._listWindow) do
			if v ~= p2 and v:IsOpen() then
				v:Close()
			end
		end
	end
end
function t.Destroy(p1)
	assert(p1._maid)
	local _maid_2 = p1._maid
	p1._maid = nil
	_maid_2:Destroy()
end
return t
