-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local NetObjPoolItemConsts = require(ReplicatedStorage.NetObjPool.NetObjPoolItemConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2)
	local instance = BaseObject.new(p1)
	setmetatable(instance, t)
	instance.manifest = p2
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
	instance.maid:GiveTask(p2.activeObj.Changed:Connect(update))
	return instance
end
function t.GetPoolObj(p1)
	return p1.manifest.poolObjPtr.Value
end
function t.GetActive(p1)
	return p1.manifest.activeObj.Value
end
function t.SetActive(p1, p2)
	p1.manifest.activeObj.Value = p2
end
function t._run(p1)
	p1.runMaid:DoCleaning()
	p1._mapTransparency = {}
	local function hideObj(part)
		if part:IsA("BasePart") then
			p1._mapTransparency[part] = part.Transparency
			part.Transparency = 1
		end
	end
	local obj = p1.obj
	if obj:IsA("BasePart") then
		p1._mapTransparency[obj] = obj.Transparency
		obj.Transparency = 1
	end
	p1.runMaid:GiveTask(RxInstanceUtils.observeDescendants(obj, hideObj))
	if obj:IsA("BasePart") then
		obj.Anchored = true
		p1.runMaid:GiveTask(function()
			obj.Anchored = false
		end)
		obj.CFrame = CFrame.new(0, -200, 0)
	elseif obj:IsA("Model") then
		p1.runMaid:GiveTask(RxInstanceUtils.observeProperty(obj, "PrimaryPart", function(p1, p2)
			if p1 then
				p1.Anchored = true
				p2:GiveTask(function()
					p1.Anchored = false
				end)
				p1.CFrame = CFrame.new(0, -200, 0)
			end
		end))
	end
	p1.runMaid:GiveTask(function()
		for v1, v2 in p1._mapTransparency do
			v1.Transparency = v2
		end
		p1._mapTransparency = nil
	end)
end
return ManifestBinder.new("NetObjPoolItem", {
	poolObjPtr = NetObjPoolItemConsts.POOL_OBJ_PTR_NAME,
	activeObj = NetObjPoolItemConsts.ACTIVE_OBJ_NAME
}, t)
