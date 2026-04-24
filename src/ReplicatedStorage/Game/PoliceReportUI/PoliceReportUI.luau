-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Math = require(ReplicatedStorage.Module.Math)
local t = {}
function t.Init()
	local PoliceReportGui = ReplicatedStorage.StarterGui:FindFirstChild("PoliceReportGui")
	PoliceReportGui.Parent = LocalPlayer.PlayerGui
	t.Gui = PoliceReportGui
end
function t.Display(p1)
	if t.IsOpen() then
		t.Hide()
	end
	local Gui = t.Gui
	local v1 = Maid.new()
	t.Maid = v1
	local List = Gui.Container.Top.List
	local sum = 0
	for i, v in ipairs(p1) do
		local v2, v3
		local v4 = assert(v.Title)
		local v5 = assert(v.Amount)
		v2 = type(v5) == "number"
		assert(v2)
		local SubTitle = v.SubTitle
		local v6 = List.Preset:Clone()
		v6.LayoutOrder = i
		v6.Parent = List
		v6.Title.Text = v4
		v6.Amount.Text = Math.FormatMoney(v5)
		if SubTitle ~= nil then
			v6.SubTitle.Text = SubTitle
		end
		v3 = SubTitle ~= nil
		v6.SubTitle.Visible = v3
		v6.Visible = true
		v1:GiveTask(v6)
		sum = sum + v5
	end
	Gui.Container.Bottom.Container.Sum.Text = ("+%s"):format(Math.FormatMoney(sum))
	v1:GiveTask(Gui.Container.Close.MouseButton1Down:Connect(function()
		t.Hide()
	end))
	Gui.Enabled = true
	delay(5, function()
		if v1 == t.Maid then
			t.Hide()
		end
	end)
end
function t.Hide()
	local Gui = t.Gui
	if t.IsOpen() then
		t.Maid:Destroy()
		t.Maid = nil
		Gui.Enabled = false
	end
end
function t.IsOpen()
	return t.Maid ~= nil
end
return t
