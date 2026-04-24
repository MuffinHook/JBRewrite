-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {}
t.__index = t
function t.new()
	local t2 = {}
	setmetatable(t2, t)
	t2.Maid = Maid.new()
	t2.Gui = ReplicatedStorage.Resource.LoadingBar.LoadingBarGui:Clone()
	t2.Gui.Parent = LocalPlayer.PlayerGui
	t2.Gui.Enabled = true
	t2.Maid:GiveTask(t2.Gui)
	t2:SetValue(0)
	return t2
end
function t.SetValue(p1, p2)
	p1.Gui.Background.Value.Size = UDim2.new(p2, 0, 1, 0)
end
function t.SetPosition(p1, p2)
	p1.Gui.Background.Position = p2
end
function t.Destroy(p1)
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t
