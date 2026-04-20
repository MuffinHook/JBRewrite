local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("CustomizeResult")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 13
    arg1:setState({
        hover = false;
    })
    arg1.maid = Maid_upvr.new()
    arg1.cameraRef = Roact_upvr.createRef()
    arg1.viewportRef = Roact_upvr.createRef()
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 21
    return createElement_upvr("ViewportFrame", {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        Ambient = Color3.new(1, 1, 1);
        LightColor = Color3.new(1, 1, 1);
        CurrentCamera = arg1.cameraRef;
        [Roact_upvr.Ref] = arg1.viewportRef;
    }, {
        Camera = createElement_upvr("Camera", {
            FieldOfView = arg1.props.fieldOfView;
            [Roact_upvr.Ref] = arg1.cameraRef;
        });
    })
end
local StoreData_upvr = require(ReplicatedStorage.Game.Garage.StoreData)
local Customize_upvr = require(ReplicatedStorage.Game.Garage.Customize)
function any_extend_result1._updateCustomize(arg1) -- Line 38
    local var20
    if not arg1.model then
    else
        local vehiclePacket = arg1.props.vehiclePacket
        var20 = vehiclePacket.GarageSelection
        if not var20 then
            var20 = {}
        end
        for i, v in pairs(arg1.props.equipped) do
            var20[i] = v
        end
        for _, v_2 in ipairs(arg1.props.receipt) do
            var20[v_2.category] = v_2.name
        end
        Customize_upvr.ApplyAll(StoreData_upvr.GetMapFromSelection(var20), {
            Model = arg1.model;
            Make = vehiclePacket.Make;
            Type = vehiclePacket.Type;
        }, var20)
    end
end
function any_extend_result1._removeModel(arg1) -- Line 57
    if arg1.model then
        arg1.model:Destroy()
        arg1.model = nil
    end
end
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local PartUtils_upvr = require(ReplicatedStorage.Std.PartUtils)
function any_extend_result1._updateModel(arg1) -- Line 63
    arg1:_removeModel()
    local vehiclePacket_2 = arg1.props.vehiclePacket
    if not vehiclePacket_2 then
    else
        local Model = vehiclePacket_2.Model
        if not Model then return end
        local clone = Model:Clone()
        VehicleUtils_upvr.CleanVehicleModel(clone)
        PartUtils_upvr.setAnchored(clone, true)
        clone.PrimaryPart = clone:FindFirstChild("BoundingBox")
        clone:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
        arg1.model = clone
        clone.Parent = arg1.viewportRef:getValue()
    end
end
local RunService_upvr = game:GetService("RunService")
function any_extend_result1.didMount(arg1) -- Line 84
    arg1:_updateModel()
    arg1.maid:GiveTask(function() -- Line 86
        arg1:_removeModel()
    end)
    arg1:_updateCustomize()
    local any_getValue_result1_upvr = arg1.cameraRef:getValue()
    arg1.maid.moveCamera = RunService_upvr.Heartbeat:Connect(function() -- Line 91
        if not arg1.model then
        else
            local any_GetExtentsSize_result1 = arg1.model:GetExtentsSize()
            local var39 = os.clock() / 2
            any_getValue_result1_upvr.CFrame = CFrame.Angles(0, var39 % (-math.pi*2), 0) * CFrame.Angles(-0.18849555921538758 + math.sin(var39 / 2) * math.pi * 0.01, 0, 0) * CFrame.new(0, 0, any_GetExtentsSize_result1.Magnitude * 0.66 + (math.cos(var39 * 2) * 0.5 + 0.5) * (any_GetExtentsSize_result1.Z / any_GetExtentsSize_result1.X) * 1.5)
        end
    end)
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 105
    if arg2.vehiclePacket ~= arg1.props.vehiclePacket then
        arg1:_updateModel()
        arg1:_updateCustomize()
    end
    if arg2.receipt ~= arg1.props.receipt or arg2.equipped ~= arg1.props.equipped then
        arg1:_updateCustomize()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 114
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 117
    return {
        receipt = arg1.garageReceipt;
        equipped = arg1.garageEquipped;
        vehiclePacket = arg1.garageVehiclePacket;
    }
end)(any_extend_result1)