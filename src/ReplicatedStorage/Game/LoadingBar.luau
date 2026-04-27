local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local LoadingBar = {}
LoadingBar.__index = LoadingBar
function LoadingBar.new()
	local self = {}
	setmetatable(self, LoadingBar)
	self.Maid = Maid.new()
	self.Gui = ReplicatedStorage.Resource.LoadingBar.LoadingBarGui:Clone()
	self.Gui.Parent = LocalPlayer.PlayerGui
	self.Gui.Enabled = true
	self.Maid:GiveTask(self.Gui)
	self:SetValue(0)
	return self
end
function LoadingBar.SetValue(self, size)
	self.Gui.Background.Value.Size = UDim2.new(size, 0, 1, 0)
end
function LoadingBar.SetPosition(self, position)
	self.Gui.Background.Position = position
end
function LoadingBar.Destroy(self)
	self.Maid:Destroy()
	self.Maid = nil
end
return LoadingBar
