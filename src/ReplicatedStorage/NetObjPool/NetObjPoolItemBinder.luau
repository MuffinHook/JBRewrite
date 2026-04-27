local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local NetObjPoolItemConsts = require(ReplicatedStorage.NetObjPool.NetObjPoolItemConsts)
local NetObjPoolItem = {}
NetObjPoolItem.__index = NetObjPoolItem
setmetatable(NetObjPoolItem, BaseObject)
function NetObjPoolItem.new(obj, manifest)
	local instance = BaseObject.new(obj)
	setmetatable(instance, NetObjPoolItem)
	instance.manifest = manifest
	instance.runMaid = Maid.new()
	instance.maid:GiveTask(instance.runMaid)
	local function update()
		if instance:GetActive() then
			instance:_run()
		else
			instance.runMaid:DoCleaning()
		end
	end
	if instance:GetActive() then
		instance:_run()
	else
		instance.runMaid:DoCleaning()
	end
	instance.maid:GiveTask(manifest.activeObj.Changed:Connect(update))
	return instance
end
function NetObjPoolItem.GetPoolObj(self)
	return self.manifest.poolObjPtr.Value
end
function NetObjPoolItem.GetActive(self)
	return self.manifest.activeObj.Value
end
function NetObjPoolItem.SetActive(self, activeValue)
	self.manifest.activeObj.Value = activeValue
end
function NetObjPoolItem._run(self)
	self.runMaid:DoCleaning()
	self._mapTransparency = {}
	local function hideObj(part)
		if part:IsA("BasePart") then
			self._mapTransparency[part] = part.Transparency
			part.Transparency = 1
		end
	end
	local obj = self.obj
	if obj:IsA("BasePart") then
		self._mapTransparency[obj] = obj.Transparency
		obj.Transparency = 1
	end
	self.runMaid:GiveTask(RxInstanceUtils.observeDescendants(obj, hideObj))
	if obj:IsA("BasePart") then
		obj.Anchored = true
		self.runMaid:GiveTask(function()
			obj.Anchored = false
		end)
		obj.CFrame = CFrame.new(0, -200, 0)
	elseif obj:IsA("Model") then
		self.runMaid:GiveTask(RxInstanceUtils.observeProperty(obj, "PrimaryPart", function(primaryPart, maid)
			if primaryPart then
				primaryPart.Anchored = true
				maid:GiveTask(function()
					primaryPart.Anchored = false
				end)
				primaryPart.CFrame = CFrame.new(0, -200, 0)
			end
		end))
	end
	self.runMaid:GiveTask(function()
		for part, transparencyValue in self._mapTransparency do
			part.Transparency = transparencyValue
		end
		self._mapTransparency = nil
	end)
end
return ManifestBinder.new("NetObjPoolItem", {
	poolObjPtr = NetObjPoolItemConsts.POOL_OBJ_PTR_NAME,
	activeObj = NetObjPoolItemConsts.ACTIVE_OBJ_NAME
}, NetObjPoolItem)
