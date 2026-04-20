local new_upvr = Vector3.new
local _ = Vector3.new(0, 0, 0)
local sin_upvr = math.sin
local cos_upvr = math.cos
local random_upvr = math.random
local insert_upvr = table.insert
local function _(arg1) -- Line 15, Named "RandomVector"
    local random_upvr_result1_5 = random_upvr()
    local random_upvr_result1_2 = random_upvr()
    if random_upvr_result1_2 < random_upvr_result1_5 then
        random_upvr_result1_2 = random_upvr_result1_5
        random_upvr_result1_5 = random_upvr_result1_2
    end
    return new_upvr(random_upvr_result1_2 * arg1 * cos_upvr((-math.pi*2) * random_upvr_result1_5 / random_upvr_result1_2), random_upvr_result1_2 * arg1 * sin_upvr((-math.pi*2) * random_upvr_result1_5 / random_upvr_result1_2), 0)
end
local function _() -- Line 34, Named "MakeParticle"
    return {
        Frame = nil;
        p = Vector3.new(0, 0, 0);
        v = Vector3.new(0, 0, 0);
        a = Vector3.new(0, 0, 0);
        t = tick();
        ttl = 4;
        Fake = false;
    }
end
local function Single_upvw(arg1, arg2, arg3, arg4) -- Line 45, Named "Single"
    local Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.new(0, 2, 0, 2)
    Frame_2.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame_2.BorderSizePixel = 0
    Frame_2.ZIndex = 8
    Frame_2.Parent = arg1.Frame
    local module = {
        Frame = nil;
        p = Vector3.new(0, 0, 0);
        v = Vector3.new(0, 0, 0);
        a = Vector3.new(0, 0, 0);
        t = tick();
        ttl = 4;
        Fake = false;
        Frame = Frame_2;
    }
    module.p = arg2
    module.v = arg3
    module.a = arg4
    insert_upvr(arg1.Simulate, module)
    return module
end
local atan2_upvr = math.atan2
local deg_upvr = math.deg
local remove_upvr = table.remove
local tanh_upvr = math.tanh
local function Update_upvw(arg1, arg2) -- Line 78, Named "Update"
    local tick_result1 = tick()
    local Simulate = arg1.Simulate
    for i_3 = #Simulate, 1, -1 do
        local var39 = Simulate[i_3]
        local p = var39.p
        local var41 = var39.v + var39.a * arg2
        local var42 = p + var41 * arg2
        local x = var42.x
        local y = var42.y
        local var45 = x - p.x
        local var46 = y - p.y
        local var47 = (var45 * var45 + var46 * var46) ^ 0.5
        var39.p = var42
        var39.v = var41
        local Frame = var39.Frame
        if not var39.Fake then
            if var47 < 2 then
                Frame.Position = UDim2.new(0, x - 1, 0, y - 1)
                Frame.Size = UDim2.new(0, 2, 0, 2)
            else
                Frame.Position = UDim2.new(0, x + (var45 - var47) * 0.5, 0, y + (var46 - var47) * 0.5)
                Frame.Size = UDim2.new(0, var47, 0, 3)
                Frame.Rotation = deg_upvr(atan2_upvr(var46, var45))
            end
        end
        local var49 = tick_result1 - var39.t
        local ttl = var39.ttl
        if ttl <= var49 then
            remove_upvr(Simulate, i_3)
            var39.Frame:Destroy()
        elseif ttl * 0.5 <= var49 then
            var39.Frame.Transparency = tanh_upvr((var49 - ttl * 0.5) / (ttl * 0.5)) * 1.313
        end
    end
    local Fireworks = arg1.Fireworks
    for i_4 = #Fireworks, 1, -1 do
        local var52 = Fireworks[i_4]
        if var52.ttl <= tick_result1 - var52.t then
            remove_upvr(Fireworks, i_4)
            var52.Frame:Destroy()
            if var52.OnDestroy then
                var52:OnDestroy()
            end
            for _ = 1, 30 do
                local var53 = 200 + random_upvr() * 100
                local var5_result1 = random_upvr()
                local random_upvr_result1_4 = random_upvr()
                if random_upvr_result1_4 < var5_result1 then
                    random_upvr_result1_4 = var5_result1
                    var5_result1 = random_upvr_result1_4
                end
                local Single_upvw_result1_4 = Single_upvw(arg1, var52.p, new_upvr(random_upvr_result1_4 * var53 * cos_upvr((-math.pi*2) * var5_result1 / random_upvr_result1_4), random_upvr_result1_4 * var53 * sin_upvr((-math.pi*2) * var5_result1 / random_upvr_result1_4), 0), Vector3.new(0, 0, 0))
                Single_upvw_result1_4.ttl = 1
                Single_upvw_result1_4.Frame.BackgroundColor3 = Color3.fromHSV(random_upvr(), 0.9, 0.9)
            end
            for i_6 = 1, 10 do
                var5_result1 = random_upvr()
                local var57 = var5_result1
                local var5_result1_2 = random_upvr()
                if var5_result1_2 < var57 then
                    var5_result1_2 = var57
                    var57 = var5_result1_2
                end
                local Single_upvw_result1 = Single_upvw(arg1, var52.p, new_upvr(var5_result1_2 * 100 * cos_upvr((-math.pi*2) * var57 / var5_result1_2), var5_result1_2 * 100 * sin_upvr((-math.pi*2) * var57 / var5_result1_2), 0), Vector3.new(0, 0, 0))
                Single_upvw_result1.ttl = 1.5
                Single_upvw_result1.Frame.BackgroundColor3 = Color3.fromHSV(random_upvr(), 0.9, 0.9)
            end
        end
        i_6 = random_upvr()
        local var5_result1_3 = random_upvr()
        if var5_result1_3 < i_6 then
            var5_result1_3 = i_6
            i_6 = var5_result1_3
        end
        Single_upvw(arg1, var52.p, new_upvr(var5_result1_3 * 60 * cos_upvr((-math.pi*2) * i_6 / var5_result1_3), var5_result1_3 * 60 * sin_upvr((-math.pi*2) * i_6 / var5_result1_3), 0), Vector3.new(0, 400, 0)).ttl = 0.8
    end
end
local function Clear_upvw(arg1) -- Line 144, Named "Clear"
    for _, v in next, arg1.Simulate do
        v.Frame:Destroy()
    end
    arg1.Simulate = {}
end
local RunService_upvr = game:GetService("RunService")
return {
    MakeState = function() -- Line 27, Named "MakeState"
        return {
            Frame = nil;
            Simulate = {};
            Fireworks = {};
        }
    end;
    Single = Single_upvw;
    Firework = function(arg1, arg2, arg3, arg4) -- Line 58, Named "Firework"
        local Single_upvw_result1_2 = Single_upvw(arg1, arg2, arg3, arg4)
        Single_upvw_result1_2.Frame.Visible = false
        insert_upvr(arg1.Fireworks, Single_upvw_result1_2)
        return Single_upvw_result1_2
    end;
    Explosion = function(arg1, arg2) -- Line 64, Named "Explosion"
        for _ = 1, 30 do
            local var18 = 200 + random_upvr() * 100
            local random_upvr_result1 = random_upvr()
            local random_upvr_result1_3 = random_upvr()
            if random_upvr_result1_3 < random_upvr_result1 then
                random_upvr_result1_3 = random_upvr_result1
                random_upvr_result1 = random_upvr_result1_3
            end
            local Single_upvw_result1_3 = Single_upvw(arg1, arg2, new_upvr(random_upvr_result1_3 * var18 * cos_upvr((-math.pi*2) * random_upvr_result1 / random_upvr_result1_3), random_upvr_result1_3 * var18 * sin_upvr((-math.pi*2) * random_upvr_result1 / random_upvr_result1_3), 0), Vector3.new(0, 0, 0))
            Single_upvw_result1_3.ttl = 1
            Single_upvw_result1_3.Frame.BackgroundColor3 = Color3.fromHSV(random_upvr(), 0.9, 0.9)
        end
        for _ = 1, 10 do
            random_upvr_result1 = random_upvr()
            local var22 = random_upvr_result1
            local var5_result1_4 = random_upvr()
            if var5_result1_4 < var22 then
                var5_result1_4 = var22
                var22 = var5_result1_4
            end
            local Single_upvw_result1_5 = Single_upvw(arg1, arg2, new_upvr(var5_result1_4 * 100 * cos_upvr((-math.pi*2) * var22 / var5_result1_4), var5_result1_4 * 100 * sin_upvr((-math.pi*2) * var22 / var5_result1_4), 0), Vector3.new(0, 0, 0))
            Single_upvw_result1_5.ttl = 1.5
            Single_upvw_result1_5.Frame.BackgroundColor3 = Color3.fromHSV(random_upvr(), 0.9, 0.9)
        end
    end;
    EasySimulate = function(arg1, arg2) -- Line 150, Named "EasySimulate"
        local any_Connect_result1_upvr = RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 151, Named "Heartbeat"
            Update_upvw(arg1, arg1_2)
        end)
        delay(arg2, function() -- Line 155, Named "Finish"
            any_Connect_result1_upvr:Disconnect()
            Clear_upvw(arg1)
        end)
    end;
    Update = Update_upvw;
    Clear = Clear_upvw;
}