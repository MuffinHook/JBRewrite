local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Customize_upvr = require(ReplicatedStorage_upvr.Game.Garage.Customize)
local PartUtils_upvr = require(ReplicatedStorage_upvr.Std.PartUtils)
return function(arg1, arg2) -- Line 7, Named "getDefaultVehicleModel"
    if arg1 == nil then
    else
    end
    assert(true, "missing vehicle make")
    if arg2 == nil then
    else
    end
    assert(true, "missing vehicle type")
    if arg1 == "MCL36FREE" then
        local var44 = "MCL36"
    end
    local SOME_6 = ReplicatedStorage_upvr.Resource.Vehicles:FindFirstChild(var44)
    if not SOME_6 then
        SOME_6 = ReplicatedStorage_upvr
        SOME_6 = SOME_6.Resource
        SOME_6 = SOME_6.Plane:FindFirstChild(var44)
        if not SOME_6 then
            SOME_6 = ReplicatedStorage_upvr
            SOME_6 = SOME_6.Resource
            SOME_6 = SOME_6.Boat:FindFirstChild(var44)
        end
    end
    if not SOME_6 then
        error("Could not find vehicle model: "..var44)
        return
    end
    local clone = SOME_6:Clone()
    for _, v in clone:GetDescendants() do
        if v:IsA("Model") and v.Name:sub(1, 5) == "Wheel" and v.Name ~= "Wheels" then
            local var50
            if v.Name ~= "WheelModels" then
                var50 = "Wheel"
                local SOME = v:FindFirstChild(var50)
                if not SOME then
                    var50 = "WheelRoot"
                    SOME = v:FindFirstChild(var50)
                end
                if not SOME then
                    var50 = "could not find wheelRoot in"
                    print(var50, v:GetFullName())
                end
                if SOME == nil then
                    var50 = false
                else
                    var50 = true
                end
                assert(var50, "could not find wheelRoot")
                v.PrimaryPart = SOME
            end
        end
    end
    local WheelModels_2 = clone:FindFirstChild("WheelModels")
    if WheelModels_2 then
        for _, v_2 in WheelModels_2:GetChildren() do
            local var56
            if v_2:IsA("Model") then
                var56 = "Wheel"
                local SOME_4 = v_2:FindFirstChild(var56)
                if not SOME_4 then
                    var56 = "could not find tirePart in"
                    print(var56, v_2:GetFullName())
                end
                if SOME_4 == nil then
                    var56 = false
                else
                    var56 = true
                end
                assert(var56, "could not find tirePart")
                v_2.PrimaryPart = SOME_4
            end
        end
    end
    clone.PrimaryPart = clone.BoundingBox
    clone:SetPrimaryPartCFrame(CFrame.new())
    if clone:FindFirstChild("Spoiler") then
        clone.Spoiler.Transparency = 1
    end
    if clone:FindFirstChild("PoliceLights") then
        clone.PoliceLights.Transparency = 1
    end
    if arg2 ~= "Chassis3" then
        local tbl = {
            Make = var44;
        }
        tbl.Type = arg2
        tbl.Model = clone
        Customize_upvr.Apply({
            Name = "Classic";
        }, "Spoiler", tbl)
        Customize_upvr.Apply({
            Name = "Arachnid";
        }, "Rim", tbl)
        if var44 == "NASCAR1" then
            Customize_upvr.Apply({
                Name = "NASCAR1";
            }, "Texture", tbl)
        elseif var44 == "NASCAR2" then
            Customize_upvr.Apply({
                Name = "NASCAR2";
            }, "Texture", tbl)
        elseif var44 == "MCL36" then
            Customize_upvr.Apply({
                Name = "MCL36";
            }, "Texture", tbl)
        elseif var44 == "NASCAR75th" then
            Customize_upvr.Apply({
                Name = "NASCAR75th";
            }, "Texture", tbl)
        else
            Customize_upvr.Apply(nil, "Texture", tbl)
        end
        Customize_upvr.Apply({
            Name = "Black";
        }, "WindowColor", tbl)
        Customize_upvr.Apply({
            Name = "Black";
        }, "WheelColor", tbl)
        PartUtils_upvr.setAnchored(clone, true)
    end
    return clone
end