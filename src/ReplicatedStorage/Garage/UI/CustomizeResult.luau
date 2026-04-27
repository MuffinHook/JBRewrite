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
local CustomizeResultComponent = Roact.PureComponent:extend("CustomizeResult")
function CustomizeResultComponent.init(self)
	self:setState({
		hover = false
	})
	self.maid = Maid.new()
	self.cameraRef = Roact.createRef()
	self.viewportRef = Roact.createRef()
end
function CustomizeResultComponent.render(self)
	return createElement("ViewportFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),
		Ambient = Color3.new(255/255, 255/255, 255/255),
		LightColor = Color3.new(255/255, 255/255, 255/255),
		CurrentCamera = self.cameraRef,
		[Roact.Ref] = self.viewportRef
	}, {
		Camera = createElement("Camera", {
			FieldOfView = self.props.fieldOfView,
			[Roact.Ref] = self.cameraRef
		})
	})
end
function CustomizeResultComponent._updateCustomize(self)
	if self.model then
		local vehiclePacket = self.props.vehiclePacket
		local garageSelection = vehiclePacket.GarageSelection or {}
		for equipmentCategory, equipmentValue in pairs(self.props.equipped) do
			garageSelection[equipmentCategory] = equipmentValue
		end
		for i, receiptItem in ipairs(self.props.receipt) do
			garageSelection[receiptItem.category] = receiptItem.name
		end
		local customizationMap = StoreData.GetMapFromSelection(garageSelection)
		Customize.ApplyAll(customizationMap, {
			Model = self.model,
			Make = vehiclePacket.Make,
			Type = vehiclePacket.Type
		}, garageSelection)
	end
end
function CustomizeResultComponent._removeModel(self)
	if self.model then
		self.model:Destroy()
		self.model = nil
	end
end
function CustomizeResultComponent._updateModel(self)
	self:_removeModel()
	local vehiclePacket = self.props.vehiclePacket
	if vehiclePacket then
		local Model = vehiclePacket.Model
		if Model then
			local clonedModel = Model:Clone()
			VehicleUtils.CleanVehicleModel(clonedModel)
			PartUtils.setAnchored(clonedModel, true)
			clonedModel.PrimaryPart = clonedModel:FindFirstChild("BoundingBox")
			clonedModel:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
			self.model = clonedModel
			clonedModel.Parent = self.viewportRef:getValue()
		end
	end
end
function CustomizeResultComponent.didMount(self)
	self:_updateModel()
	self.maid:GiveTask(function()
		self:_removeModel()
	end)
	self:_updateCustomize()
	local camera = self.cameraRef:getValue()
	self.maid.moveCamera = RunService.Heartbeat:Connect(function()
		if self.model then
			local elapsedTime = os.clock()
			local modelSize = self.model:GetExtentsSize()
			local rotationTime = elapsedTime / 2
			camera.CFrame = CFrame.Angles(0, rotationTime % math.tau, 0) * CFrame.Angles(-0.18849555921538758 + math.sin(rotationTime / 2) * math.pi * 0.01, 0, 0) * CFrame.new(0, 0, modelSize.Magnitude * 0.66 + (math.cos(rotationTime * 2) * 0.5 + 0.5) * (modelSize.Z / modelSize.X) * 1.5)
		end
	end)
end
function CustomizeResultComponent.didUpdate(self, previousProps, previousState)
	if previousProps.vehiclePacket ~= self.props.vehiclePacket then
		self:_updateModel()
		self:_updateCustomize()
	end
	if previousProps.receipt ~= self.props.receipt or previousProps.equipped ~= self.props.equipped then
		self:_updateCustomize()
	end
end
function CustomizeResultComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, dispatch)
	return {
		receipt = state.garageReceipt,
		equipped = state.garageEquipped,
		vehiclePacket = state.garageVehiclePacket
	}
end)(CustomizeResultComponent)
