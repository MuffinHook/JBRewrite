-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local VehicleLinkUtils = require(ReplicatedStorage.VehicleLink.VehicleLinkUtils)
local LoadingBar = require(ReplicatedStorage.Game.LoadingBar)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(self, p2)
	local instance = BaseObject.new(self)
	setmetatable(instance, t)
	instance.manifest = p2
	local function checkOwner()
		instance:_updateSeeking()
	end
	instance:_updateSeeking()
	instance.maid:GiveTask(instance.manifest.networkOwnerIdObj.Changed:Connect(checkOwner))
	return instance
end
function t._updateSeeking(self)
	if self:GetOwner() == Players.LocalPlayer then
		self.maid.seeking = Interval.every(0.25):Connect(function()
			if not (VehicleLinkUtils.getDisabled(self.obj) or VehicleLinkUtils.getIsLinked(self.obj)) then
				local instance = self:_getNearestObj(8)
				if instance ~= self.nearestObj then
					self.nearestObj = instance
					if instance then
						local instance2 = Maid.new()
						self.maid.nearestMaid = instance2
						self:_hookNearest(instance2)
						return
					end
					self.maid.nearestMaid = nil
				end
			end
		end)
	else
		self.maid.seeking = nil
		self.maid.nearestMaid = nil
	end
end
function t._hookNearest(self, p2)
	local nearestObj = self.nearestObj
	local instance = VehicleLinkUtils.getPrimaryPart(nearestObj)
	local instance2 = self:_makePartVisualBall()
	instance2.Parent = workspace
	p2:GiveTask(instance2)
	local var3 = self:_makePartVisualBlock()
	var3.Parent = workspace
	p2:GiveTask(var3)
	local instance4 = LoadingBar.new()
	p2:GiveTask(instance4)
	instance4:SetPosition(UDim2.new(0.5, 0, 0.6666666666666666, 0))
	local var5 = 0
	local var6 = os.clock()
	local function update()
		local var12 = if nearestObj:GetAttribute("VehicleHasDriver") == true then 5 else 1
		local var22 = GeomUtils.closestPointInPart(instance, self.obj.Position)
		instance2.CFrame = CFrame.new(var22)
		var3.Size = instance.Size * 1.02
		var3.CFrame = instance.CFrame
		local var32 = os.clock()
		local var42 = var32 - var6
		instance4:SetValue((math.min(1, var42 / var12)))
		if var12 < var42 and var32 - var5 > 1 then
			var5 = var32
			self.manifest.reqLinkRemote:FireServer(nearestObj, instance.CFrame:PointToObjectSpace(var22))
		end
	end
	p2:GiveTask(RunService.Heartbeat:Connect(update))
	update()
	p2:GiveTask(VehicleLinkUtils.getIsLinkedChangedSignal(self.obj):Connect(function()
		if VehicleLinkUtils.getIsLinked(self.obj) then
			p2:DoCleaning()
		end
	end))
	p2:GiveTask(VehicleLinkUtils.getDisabledChangedSignal(self.obj):Connect(function()
		if VehicleLinkUtils.getDisabled(self.obj) then
			p2:DoCleaning()
		end
	end))
end
function t._makePartVisualBall(self)
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(1, 1, 1)
	Part.CanCollide = false
	Part.Color = Color3.new(255/255, 0/255, 0/255)
	Part.Shape = Enum.PartType.Ball
	Part.Transparency = 0.3
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Anchored = true
	return Part
end
function t._makePartVisualBlock(self)
	local Part = Instance.new("Part")
	Part.CanCollide = false
	Part.Color = Color3.new(0/255, 255/255, 0/255)
	Part.Transparency = 0.8
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Anchored = true
	return Part
end
function t._getPrimaryPart(self, p2)
	return p2:FindFirstChild("BoundingBox") or p2.PrimaryPart
end
function t._getNearestObj(self, p2)
	local instance2 = nil
	for i, v in ipairs((CollectionService:GetTagged("HeliPickup"))) do
		if not self.obj:IsDescendantOf(v) then
			local var3 = VehicleLinkUtils.getPrimaryPart(v)
			if var3 then
				local Magnitude = (self.obj.Position - GeomUtils.closestPointInPart(var3, self.obj.Position)).Magnitude
				if Magnitude < p2 then
					p2 = Magnitude
					instance2 = v
				end
			end
		end
	end
	return instance2
end
function t.GetOwner(self)
	return Players:GetPlayerByUserId(self.manifest.networkOwnerIdObj.Value)
end
function t.Unattach(self)
	self.manifest.reqUnlinkRemote:FireServer()
end
return ManifestBinder.new("VehicleLink", {
	reqLinkRemote = "ReqLink",
	reqUnlinkRemote = "ReqUnlink",
	networkOwnerIdObj = "NetworkOwnerId"
}, t)
