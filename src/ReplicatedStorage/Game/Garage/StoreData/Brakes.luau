local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
return {
    Items = {{
        Name = "Level 1";
        Price = 0;
        Amount = 0;
    }, {
        Name = "Level 2";
        Price = 2000;
        Amount = 2.5;
    }, {
        Name = "Level 3";
        Price = 4500;
        Amount = 5;
    }};
    GetInstance = function(arg1) -- Line 19, Named "GetInstance"
        local SOME = ReplicatedStorage_upvr.Resource.Brakes:FindFirstChild(arg1.Name)
        if not SOME then
            error("No Brakes named: "..arg1.Name)
        end
        local clone = SOME:Clone()
        clone.PrimaryPart = clone.Center
        clone:SetPrimaryPartCFrame(CFrame.new() * CFrame.Angles((math.pi/2), 0, 0))
        return clone
    end;
    Update = function(arg1, arg2) -- Line 30, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var8 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var8) * 0.5 - 0.2, 0, 0) * CFrame.new(0, 0, 10)
    end;
}