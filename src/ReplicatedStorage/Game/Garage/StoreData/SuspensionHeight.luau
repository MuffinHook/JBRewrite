local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
return {
    Items = {{
        Name = "Slammed";
        Price = 3000;
        Height = -0.5;
    }, {
        Name = "Low";
        Price = 2500;
        Height = -0.25;
    }, {
        Name = "Normal";
        Height = 0;
        Price = 0;
    }, {
        Name = "Raised";
        Price = 2500;
        Height = 0.2;
    }, {
        Name = "High";
        Price = 3000;
        Height = 0.5;
    }, {
        Name = "Monster";
        Price = 5000;
        Height = 1.5;
    }};
    GetInstance = function(arg1) -- Line 34, Named "GetInstance"
        local SOME = ReplicatedStorage_upvr.Resource.Suspension:FindFirstChild(arg1.Name)
        if not SOME then
            error("No Suspension named: "..arg1.Name)
        end
        local clone = SOME:Clone()
        clone.CFrame = CFrame.new(0, 0, 0)
        return clone
    end;
    Update = function(arg1, arg2) -- Line 47, Named "Update"
        local var11 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var11 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var11) * 0.5 - 0.2, 0, 0) * CFrame.new(0, 0, arg2.Size.Magnitude)
    end;
}