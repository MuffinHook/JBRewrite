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
function t.new(p1, p2)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.manifest = p2
	local function checkOwner()
		v1:_updateSeeking()
	end
	v1:_updateSeeking()
	v1.maid:GiveTask(v1.manifest.networkOwnerIdObj.Changed:Connect(checkOwner))
	return v1
end
function t._updateSeeking(p1)
	if p1:GetOwner() == Players.LocalPlayer then
		p1.maid.seeking = Interval.every(0.25):Connect(function()
			if not (VehicleLinkUtils.getDisabled(p1.obj) or VehicleLinkUtils.getIsLinked(p1.obj)) then
				local v1 = p1:_getNearestObj(8)
				if v1 ~= p1.nearestObj then
					p1.nearestObj = v1
					if v1 then
						local v2 = Maid.new()
						p1.maid.nearestMaid = v2
						p1:_hookNearest(v2)
						return
					end
					p1.maid.nearestMaid = nil
				end
			end
		end)
	else
		p1.maid.seeking = nil
		p1.maid.nearestMaid = nil
	end
end
function t._hookNearest(p1, p2)
	local nearestObj = p1.nearestObj
	local v1 = VehicleLinkUtils.getPrimaryPart(nearestObj)
	local v2 = p1:_makePartVisualBall()
	v2.Parent = workspace
	p2:GiveTask(v2)
	local v3 = p1:_makePartVisualBlock()
	v3.Parent = workspace
	p2:GiveTask(v3)
	local v4 = LoadingBar.new()
	p2:GiveTask(v4)
	v4:SetPosition(UDim2.new(0.5, 0, 0.6666666666666666, 0))
	local v5 = 0
	local v6 = os.clock()
	local function update()
		local v12 = if nearestObj:GetAttribute("VehicleHasDriver") == true then 5 else 1
		local v22 = GeomUtils.closestPointInPart(v1, p1.obj.Position)
		v2.CFrame = CFrame.new(v22)
		v3.Size = v1.Size * 1.02
		v3.CFrame = v1.CFrame
		local v32 = os.clock()
		local v42 = v32 - v6
		v4:SetValue((math.min(1, v42 / v12)))
		if v12 < v42 and v32 - v5 > 1 then
			v5 = v32
			p1.manifest.reqLinkRemote:FireServer(nearestObj, v1.CFrame:PointToObjectSpace(v22))
		end
	end
	p2:GiveTask(RunService.Heartbeat:Connect(update))
	update()
	p2:GiveTask(VehicleLinkUtils.getIsLinkedChangedSignal(p1.obj):Connect(function()
		if VehicleLinkUtils.getIsLinked(p1.obj) then
			p2:DoCleaning()
		end
	end))
	p2:GiveTask(VehicleLinkUtils.getDisabledChangedSignal(p1.obj):Connect(function()
		if VehicleLinkUtils.getDisabled(p1.obj) then
			p2:DoCleaning()
		end
	end))
end
function t._makePartVisualBall(p1)
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
function t._makePartVisualBlock(p1)
	local Part = Instance.new("Part")
	Part.CanCollide = false
	Part.Color = Color3.new(0/255, 255/255, 0/255)
	Part.Transparency = 0.8
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Anchored = true
	return Part
end
function t._getPrimaryPart(p1, p2)
	return p2:FindFirstChild("BoundingBox") or p2.PrimaryPart
end
function t._getNearestObj(p1, p2)
	local v2 = nil
	for i, v in ipairs((CollectionService:GetTagged("HeliPickup"))) do
		if not p1.obj:IsDescendantOf(v) then
			local v3 = VehicleLinkUtils.getPrimaryPart(v)
			if v3 then
				local Magnitude = (p1.obj.Position - GeomUtils.closestPointInPart(v3, p1.obj.Position)).Magnitude
				if Magnitude < p2 then
					p2 = Magnitude
					v2 = v
				end
			end
		end
	end
	return v2
end
function t.GetOwner(p1)
	return Players:GetPlayerByUserId(p1.manifest.networkOwnerIdObj.Value)
end
function t.Unattach(p1)
	p1.manifest.reqUnlinkRemote:FireServer()
end
return ManifestBinder.new("VehicleLink", {
	reqLinkRemote = "ReqLink",
	reqUnlinkRemote = "ReqUnlink",
	networkOwnerIdObj = "NetworkOwnerId"
}, t)
