-- Reviewed by Claude
game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Game.GameUtil)
require(ReplicatedStorage.Resource.Settings)
local CurrentCamera = workspace.CurrentCamera
local t = {}
t.__index = t
function t.Init(p1)
	local v1 = p1.GetScreenGui("AmmoGui")
	t.Gui = v1
	t.Frame = v1:WaitForChild("Frame")
	t.Frame2 = v1:WaitForChild("Frame2")
end
function t.SetColor(p1)  end
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t.Gui.Enabled = true
	t.Frame.ItemName.Text = ("// %s"):format(p1)
	t.Frame2.ItemName.Text = ("// %s"):format(p1)
	return t2
end
function t.Update(p1, p2, p3)
	if p3 ~= nil then
		p1.MaxAmmo = p3
	end
	local Frame = t.Frame
	local Frame2 = t.Frame2
	Frame.Ammo.Text = ("%d/"):format(p2)
	Frame.MagSize.Text = p3 or ""
	Frame2.Ammo.Text = ("%d/"):format(p2)
	Frame2.MagSize.Text = p3 or ""
	if p2 <= 0 then
		Frame.Ammo.TextColor3 = Color3.new(255/255, 0/255, 0/255)
		Frame.MagSize.TextColor3 = Color3.new(255/255, 0/255, 0/255)
		Frame2.Ammo.TextColor3 = Color3.new(255/255, 0/255, 0/255)
		Frame2.MagSize.TextColor3 = Color3.new(255/255, 0/255, 0/255)
	else
		Frame.Ammo.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		Frame.MagSize.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		Frame2.Ammo.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		Frame2.MagSize.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	end
end
function t.UpdatePosition(p1, p2, p3)
	local Frame = t.Frame
	local v1, v2 = CurrentCamera:WorldToScreenPoint(p2.Position)
	if v1 then
		local v4 = UDim2.new(0, v1.X + 30, 0, v1.Y + 75)
		if Frame.Visible == false then
			Frame.Position = v4
		else
			Frame.Position = Frame.Position:Lerp(v4, 0.25 * (60 * p3))
		end
	end
	Frame.Visible = v2 and not ((CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude < 4)
	t.Frame2.Visible = not Frame.Visible
end
function t.Destroy(p1)
	t.Gui.Enabled = false
	t.Frame.Visible = false
	t.Frame2.Visible = false
end
return t
