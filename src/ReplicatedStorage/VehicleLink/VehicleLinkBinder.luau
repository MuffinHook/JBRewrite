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
local VehicleLinkBinder = {}
VehicleLinkBinder.__index = VehicleLinkBinder
setmetatable(VehicleLinkBinder, BaseObject)
function VehicleLinkBinder.new(self, manifest)
	local instance = BaseObject.new(self)
	setmetatable(instance, VehicleLinkBinder)
	instance.manifest = manifest
	local function checkOwner()
		instance:_updateSeeking()
	end
	instance:_updateSeeking()
	instance.maid:GiveTask(instance.manifest.networkOwnerIdObj.Changed:Connect(checkOwner))
	return instance
end
function VehicleLinkBinder._updateSeeking(self)
	if self:GetOwner() == Players.LocalPlayer then
		self.maid.seeking = Interval.every(0.25):Connect(function()
			if not (VehicleLinkUtils.getDisabled(self.obj) or VehicleLinkUtils.getIsLinked(self.obj)) then
				local nearestInstance = self:_getNearestObj(8)
				if nearestInstance ~= self.nearestObj then
					self.nearestObj = nearestInstance
					if nearestInstance then
						local nearestMaid = Maid.new()
						self.maid.nearestMaid = nearestMaid
						self:_hookNearest(nearestMaid)
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
function VehicleLinkBinder._hookNearest(self, maid)
	local nearestObj = self.nearestObj
	local primaryPart = VehicleLinkUtils.getPrimaryPart(nearestObj)
	local visualBall = self:_makePartVisualBall()
	visualBall.Parent = workspace
	maid:GiveTask(visualBall)
	local visualBlock = self:_makePartVisualBlock()
	visualBlock.Parent = workspace
	maid:GiveTask(visualBlock)
	local loadingBar = LoadingBar.new()
	maid:GiveTask(loadingBar)
	loadingBar:SetPosition(UDim2.new(0.5, 0, 0.6666666666666666, 0))
	local lastUpdateTime = 0
	local clockStartTime = os.clock()
	local function update()
		local requiredTime = if nearestObj:GetAttribute("VehicleHasDriver") == true then 5 else 1
		local closestPoint = GeomUtils.closestPointInPart(primaryPart, self.obj.Position)
		visualBall.CFrame = CFrame.new(closestPoint)
		visualBlock.Size = primaryPart.Size * 1.02
		visualBlock.CFrame = primaryPart.CFrame
		local currentTime = os.clock()
		local elapsedTime = currentTime - clockStartTime
		loadingBar:SetValue((math.min(1, elapsedTime / requiredTime)))
		if requiredTime < elapsedTime and currentTime - lastUpdateTime > 1 then
			lastUpdateTime = currentTime
			self.manifest.reqLinkRemote:FireServer(nearestObj, primaryPart.CFrame:PointToObjectSpace(closestPoint))
		end
	end
	maid:GiveTask(RunService.Heartbeat:Connect(update))
	update()
	maid:GiveTask(VehicleLinkUtils.getIsLinkedChangedSignal(self.obj):Connect(function()
		if VehicleLinkUtils.getIsLinked(self.obj) then
			maid:DoCleaning()
		end
	end))
	maid:GiveTask(VehicleLinkUtils.getDisabledChangedSignal(self.obj):Connect(function()
		if VehicleLinkUtils.getDisabled(self.obj) then
			maid:DoCleaning()
		end
	end))
end
function VehicleLinkBinder._makePartVisualBall(self)
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
function VehicleLinkBinder._makePartVisualBlock(self)
	local Part = Instance.new("Part")
	Part.CanCollide = false
	Part.Color = Color3.new(0/255, 255/255, 0/255)
	Part.Transparency = 0.8
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Anchored = true
	return Part
end
function VehicleLinkBinder._getPrimaryPart(self, targetPart)
	return targetPart:FindFirstChild("BoundingBox") or targetPart.PrimaryPart
end
function VehicleLinkBinder._getNearestObj(self, maxDistance)
	local nearestObj = nil
	for i, v in ipairs((CollectionService:GetTagged("HeliPickup"))) do
		if not self.obj:IsDescendantOf(v) then
			local primaryPart = VehicleLinkUtils.getPrimaryPart(v)
			if primaryPart then
				local Magnitude = (self.obj.Position - GeomUtils.closestPointInPart(primaryPart, self.obj.Position)).Magnitude
				if Magnitude < maxDistance then
					maxDistance = Magnitude
					nearestObj = v
				end
			end
		end
	end
	return nearestObj
end
function VehicleLinkBinder.GetOwner(self)
	return Players:GetPlayerByUserId(self.manifest.networkOwnerIdObj.Value)
end
function VehicleLinkBinder.Unattach(self)
	self.manifest.reqUnlinkRemote:FireServer()
end
return ManifestBinder.new("VehicleLink", {
	reqLinkRemote = "ReqLink",
	reqUnlinkRemote = "ReqUnlink",
	networkOwnerIdObj = "NetworkOwnerId"
}, VehicleLinkBinder)
