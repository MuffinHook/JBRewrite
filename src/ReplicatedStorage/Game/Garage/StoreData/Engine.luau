local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
return {
    Items = {{
        Name = "Level 1";
        Speed = 0;
        Price = 0;
    }, {
        Name = "Level 2";
        Speed = 0.75;
        Price = 8000;
    }, {
        Name = "Level 3";
        Speed = 1.5;
        Price = 18000;
    }, {
        Name = "Level 4";
        Speed = 2.25;
        Price = 32000;
    }, {
        Name = "Level 5";
        Speed = 3;
        Price = 50000;
    }};
    GetInstance = function(arg1) -- Line 29, Named "GetInstance"
        local SOME = ReplicatedStorage_upvr.Resource.Engine:FindFirstChild(arg1.Name)
        if not SOME then
            error("No Engine named: "..arg1.Name)
        end
        local clone = SOME:Clone()
        clone.CFrame = CFrame.new(0, 0, 0)
        return clone
    end;
    Update = function(arg1, arg2) -- Line 42, Named "Update"
        local var10 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var10 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var10) * 0.1 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.Size.Magnitude)
    end;
}