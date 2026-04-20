local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
return {
    Items = {{
        InnerWheelPct = 0.73;
        Name = "Classic";
        Price = 0;
        NoTrade = true;
    }, {
        Hidden = true;
        InnerWheelPct = 0.67;
        Name = "ClosedCircuit";
    }, {
        Hidden = false;
        InnerWheelPct = 0.787;
        Level = 3;
        Name = "Voltline";
        Season = 31;
        SeasonIconId = 90322877329110;
    }, {
        Hidden = true;
        InnerWheelPct = 0.55;
        Name = "RadialRed";
    }, {
        Hidden = true;
        InnerWheelPct = 0.78;
        Name = "Studded";
    }, {
        Hidden = false;
        InnerWheelPct = 0.01;
        Level = 4;
        Name = "R2008";
        Price = 0;
        Season = 29;
        SeasonIconId = 80671837209433;
    }, {
        Hidden = false;
        InnerWheelPct = 0.71;
        Name = "MagmaticGlow";
        Price = 250000;
    }, {
        InnerWheelPct = 0.51;
        Name = "ROK";
        Season = 26;
        SeasonIconId = 115110078822703;
        TopPct = 2;
    }, {
        Hidden = false;
        InnerWheelPct = 0.47;
        Name = "Safari";
    }, {
        Hidden = false;
        InnerWheelPct = 0.673;
        Level = 4;
        Name = "Jungle Ruins";
        Season = 26;
        SeasonIconId = 95839629878093;
    }, {
        Hidden = false;
        InnerWheelPct = 0.7;
        Name = "RTX";
        Price = 175000;
    }, {
        Hidden = false;
        InnerWheelPct = 0.585;
        Name = "Glacier";
        TopPct = 2;
        Season = 24;
        SeasonIconId = 98694176152904;
    }, {
        Hidden = false;
        InnerWheelPct = 0.608;
        Level = 9;
        Name = "SnowTrail";
        Season = 24;
        SeasonIconId = 83650438216900;
    }, {
        Hidden = true;
        InnerWheelPct = 0.01;
        Name = "Cheeseburger";
    }, {
        Hidden = false;
        InnerWheelPct = 0.27;
        Name = "RollerBlade";
        Season = 23;
        SeasonIconId = 95979128033902;
        TopPct = 2;
    }, {
        Hidden = true;
        InnerWheelPct = 0.56;
        Name = "Brickset";
    }, {
        Hidden = false;
        InnerWheelPct = 0.53;
        Name = "DirtyTrail";
        Price = 250000;
    }, {
        Hidden = false;
        InnerWheelPct = 0.71;
        Level = 7;
        Name = "America";
        Season = 22;
        SeasonIconId = 18128197279;
    }, {
        Hidden = false;
        InnerWheelPct = 0.6;
        Level = 9;
        Name = "Donut";
        Season = 21;
        SeasonIconId = 17124598243;
    }, {
        Hidden = false;
        InnerWheelPct = 0.7;
        Level = 9;
        Name = "Spiked";
        Season = 20;
        SeasonIconId = 16176422157;
    }, {
        InnerWheelScale = Vector3.new(0.89999, 0.5, 0.5);
        Level = 7;
        Name = "Snowchain";
        Season = 19;
        SeasonIconId = 15624646748;
    }, {
        InnerWheelPct = 0.85;
        Name = "TreadedSport";
        Price = 25000;
    }, {
        InnerWheelPct = 0.61;
        Name = "TreadedThick";
        Price = 25000;
    }, {
        InnerWheelPct = 0.73;
        Name = "Treaded";
        Price = 25000;
    }, {
        InnerWheelPct = 0.85;
        Name = "ClassicSport";
        Price = 20000;
    }, {
        InnerWheelPct = 0.61;
        Name = "ClassicThick";
        Price = 20000;
    }, {
        Name = "Offroad";
        Price = 20000;
        InnerWheelPct = 0.73;
    }, {
        InnerWheelPct = 0.61;
        Name = "Monster";
        Price = 20000;
    }};
    GetInstance = function(arg1) -- Line 2, Named "GetInstance"
        local clone = ReplicatedStorage_upvr.Resource.TireMesh:FindFirstChild(arg1.Name):Clone()
        clone.CFrame = CFrame.new(0, 0, 0)
        return clone
    end;
    Update = function(arg1, arg2) -- Line 10, Named "Update"
        local var3 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var3 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var3) * 0.5, 0, 0) * CFrame.new(0, 0, arg2.Size.Magnitude * 0.707)
    end;
}