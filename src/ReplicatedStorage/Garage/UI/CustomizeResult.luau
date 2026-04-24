-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Customize = require(ReplicatedStorage.Game.Garage.Customize)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local v1 = Roact.PureComponent:extend("CustomizeResult")
function v1.init(p1)
	p1:setState({
		hover = false
	})
	p1.maid = Maid.new()
	p1.cameraRef = Roact.createRef()
	p1.viewportRef = Roact.createRef()
end
function v1.render(p1)
	return createElement("ViewportFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),
		Ambient = Color3.new(255/255, 255/255, 255/255),
		LightColor = Color3.new(255/255, 255/255, 255/255),
		CurrentCamera = p1.cameraRef,
		[Roact.Ref] = p1.viewportRef
	}, {
		Camera = createElement("Camera", {
			FieldOfView = p1.props.fieldOfView,
			[Roact.Ref] = p1.cameraRef
		})
	})
end
function v1._updateCustomize(p1)
	if p1.model then
		local vehiclePacket = p1.props.vehiclePacket
		local v1 = vehiclePacket.GarageSelection or {}
		for k, v in pairs(p1.props.equipped) do
			v1[k] = v
		end
		for i, v in ipairs(p1.props.receipt) do
			v1[v.category] = v.name
		end
		local v2 = StoreData.GetMapFromSelection(v1)
		Customize.ApplyAll(v2, {
			Model = p1.model,
			Make = vehiclePacket.Make,
			Type = vehiclePacket.Type
		}, v1)
	end
end
function v1._removeModel(p1)
	if p1.model then
		p1.model:Destroy()
		p1.model = nil
	end
end
function v1._updateModel(p1)
	p1:_removeModel()
	local vehiclePacket = p1.props.vehiclePacket
	if vehiclePacket then
		local Model = vehiclePacket.Model
		if Model then
			local v1 = Model:Clone()
			VehicleUtils.CleanVehicleModel(v1)
			PartUtils.setAnchored(v1, true)
			v1.PrimaryPart = v1:FindFirstChild("BoundingBox")
			v1:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
			p1.model = v1
			v1.Parent = p1.viewportRef:getValue()
		end
	end
end
function v1.didMount(p1)
	p1:_updateModel()
	p1.maid:GiveTask(function()
		p1:_removeModel()
	end)
	p1:_updateCustomize()
	local v1 = p1.cameraRef:getValue()
	p1.maid.moveCamera = RunService.Heartbeat:Connect(function()
		if p1.model then
			local v12 = os.clock()
			local v2 = p1.model:GetExtentsSize()
			local v3 = v12 / 2
			v1.CFrame = CFrame.Angles(0, v3 % 6.283185307179586, 0) * CFrame.Angles(-0.18849555921538758 + math.sin(v3 / 2) * math.pi * 0.01, 0, 0) * CFrame.new(0, 0, v2.Magnitude * 0.66 + (math.cos(v3 * 2) * 0.5 + 0.5) * (v2.Z / v2.X) * 1.5)
		end
	end)
end
function v1.didUpdate(p1, p2, p3)
	if p2.vehiclePacket ~= p1.props.vehiclePacket then
		p1:_updateModel()
		p1:_updateCustomize()
	end
	if p2.receipt ~= p1.props.receipt or p2.equipped ~= p1.props.equipped then
		p1:_updateCustomize()
	end
end
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2)
	return {
		receipt = p1.garageReceipt,
		equipped = p1.garageEquipped,
		vehiclePacket = p1.garageVehiclePacket
	}
end)(v1)
