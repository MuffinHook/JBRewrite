game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Game.GameUtil)
require(ReplicatedStorage.Resource.Settings)
local CurrentCamera = workspace.CurrentCamera
local AmmoGui = {}
AmmoGui.__index = AmmoGui
function AmmoGui.Init(guiManager)
	local gui = guiManager.GetScreenGui("AmmoGui")
	AmmoGui.Gui = gui
	AmmoGui.Frame = gui:WaitForChild("Frame")
	AmmoGui.Frame2 = gui:WaitForChild("Frame2")
end
function AmmoGui.SetColor(obj)  end
function AmmoGui.new(itemName)
	local instance = {}
	setmetatable(instance, AmmoGui)
	AmmoGui.Gui.Enabled = true
	AmmoGui.Frame.ItemName.Text = ("// %s"):format(itemName)
	AmmoGui.Frame2.ItemName.Text = ("// %s"):format(itemName)
	return instance
end
function AmmoGui.Update(obj, currentAmmo, maxAmmo)
	if maxAmmo ~= nil then
		obj.MaxAmmo = maxAmmo
	end
	local Frame = AmmoGui.Frame
	local Frame2 = AmmoGui.Frame2
	Frame.Ammo.Text = ("%d/"):format(currentAmmo)
	Frame.MagSize.Text = maxAmmo or ""
	Frame2.Ammo.Text = ("%d/"):format(currentAmmo)
	Frame2.MagSize.Text = maxAmmo or ""
	if currentAmmo <= 0 then
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
function AmmoGui.UpdatePosition(obj, targetPart, deltaTime)
	local Frame = AmmoGui.Frame
	local screenPoint, isOnScreen = CurrentCamera:WorldToScreenPoint(targetPart.Position)
	if screenPoint then
		local newPosition = UDim2.new(0, screenPoint.X + 30, 0, screenPoint.Y + 75)
		if Frame.Visible == false then
			Frame.Position = newPosition
		else
			Frame.Position = Frame.Position:Lerp(newPosition, 0.25 * (60 * deltaTime))
		end
	end
	Frame.Visible = isOnScreen and not ((CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude < 4)
	AmmoGui.Frame2.Visible = not Frame.Visible
end
function AmmoGui.Destroy(obj)
	AmmoGui.Gui.Enabled = false
	AmmoGui.Frame.Visible = false
	AmmoGui.Frame2.Visible = false
end
return AmmoGui
