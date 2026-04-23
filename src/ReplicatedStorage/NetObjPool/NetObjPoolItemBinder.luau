local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local NetObjPoolItemConsts = require(ReplicatedStorage.NetObjPool.NetObjPoolItemConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2) --[[ Line: 15 | Upvalues: BaseObject (copy), t (copy), Maid (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.manifest = p2
	v1.runMaid = Maid.new()
	v1.maid:GiveTask(v1.runMaid)
	local function update() --[[ Line: 24 | Upvalues: v1 (copy) ]]
		if v1:GetActive() then
			v1:_run()
		else
			v1.runMaid:DoCleaning()
		end
	end
	if v1:GetActive() then
		v1:_run()
	else
		v1.runMaid:DoCleaning()
	end
	v1.maid:GiveTask(p2.activeObj.Changed:Connect(update))
	return v1
end
function t.GetPoolObj(p1) --[[ Line: 37 ]]
	return p1.manifest.poolObjPtr.Value
end
function t.GetActive(p1) --[[ Line: 40 ]]
	return p1.manifest.activeObj.Value
end
function t.SetActive(p1, p2) --[[ Line: 43 ]]
	p1.manifest.activeObj.Value = p2
end
function t._run(p1) --[[ Line: 46 | Upvalues: RxInstanceUtils (copy) ]]
	p1.runMaid:DoCleaning()
	p1._mapTransparency = {}
	local function hideObj(p12) --[[ Line: 49 | Upvalues: p1 (copy) ]]
		if p12:IsA("BasePart") then
			p1._mapTransparency[p12] = p12.Transparency
			p12.Transparency = 1
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
		p1.runMaid:GiveTask(function() --[[ Line: 62 | Upvalues: obj (copy) ]]
			obj.Anchored = false
		end)
		obj.CFrame = CFrame.new(0, -200, 0)
	elseif obj:IsA("Model") then
		p1.runMaid:GiveTask(RxInstanceUtils.observeProperty(obj, "PrimaryPart", function(p1, p2) --[[ Line: 67 ]]
			if p1 then
				p1.Anchored = true
				p2:GiveTask(function() --[[ Line: 70 | Upvalues: p1 (copy) ]]
					p1.Anchored = false
				end)
				p1.CFrame = CFrame.new(0, -200, 0)
			end
		end))
	end
	p1.runMaid:GiveTask(function() --[[ Line: 78 | Upvalues: p1 (copy) ]]
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