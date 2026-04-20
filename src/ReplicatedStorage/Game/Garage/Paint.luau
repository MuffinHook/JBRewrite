local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local module_upvr = {
    Chrome = {
        Color = Color3.fromRGB(248, 248, 248);
        Reflectance = 1;
        Material = Enum.Material.SmoothPlastic;
    };
    FallChrome = {
        Color = Color3.fromRGB(207, 96, 36);
        Reflectance = 0.4;
        Material = Enum.Material.SmoothPlastic;
    };
    Gold = {
        Color = Color3.fromRGB(188, 155, 93);
        Reflectance = 0.3;
    };
    RadiantYellow = {
        Color = Color3.fromRGB(112, 168, 38);
        Material = Enum.Material.Neon;
    };
    RadiantOrange = {
        Color = Color3.fromRGB(174, 108, 34);
        Material = Enum.Material.Neon;
    };
    RadiantIce = {
        Color = Color3.fromRGB(20, 104, 175);
        Material = Enum.Material.Neon;
    };
    Vantablack = {
        Color = Color3.fromRGB(0, 0, 0);
        Material = Enum.Material.Neon;
    };
    RadiantGreen = {
        Color = Color3.fromRGB(51, 171, 78);
        Material = Enum.Material.Neon;
    };
    MilitaryGreen = {
        Color = Color3.fromRGB(74, 83, 60);
    };
    Black = {
        Color = Color3.fromRGB(0, 0, 0);
        Reflectance = 0.02;
    };
    NavyBlue = {
        Color = Color3.fromRGB(0, 42, 75);
    };
    HottestPink = {
        Color = Color3.fromRGB(255, 91, 236);
    };
    Maroon = {
        Color = Color3.fromRGB(92, 0, 23);
    };
    RealGreen = {
        Color = Color3.fromRGB(26, 124, 0);
    };
    DarkestPurple = {
        Color = Color3.fromRGB(30, 4, 41);
        Reflectance = 0.02;
    };
    DarkestBlue = {
        Color = Color3.fromRGB(1, 12, 46);
        Reflectance = 0.02;
    };
    DarkestGreen = {
        Color = Color3.fromRGB(0, 40, 14);
        Reflectance = 0.02;
    };
    DarkestMarine = {
        Color = Color3.fromRGB(0, 45, 44);
        Reflectance = 0.02;
    };
    DarkestRed = {
        Color = Color3.fromRGB(41, 0, 2);
        Reflectance = 0.02;
    };
    DarkestBrown = {
        Color = Color3.fromRGB(46, 22, 0);
        Reflectance = 0.02;
    };
    RadiantPurple = {
        Color = Color3.fromRGB(74, 58, 171);
        Material = Enum.Material.Neon;
    };
    SakuraPink = {
        Color = Color3.fromRGB(255, 118, 125);
    };
    RadiantRed = {
        Color = Color3.fromRGB(163, 23, 2);
        Material = Enum.Material.Neon;
    };
    RadiantPink = {
        Color = Color3.fromRGB(181, 86, 158);
        Material = Enum.Material.Neon;
    };
    RadiantSun = {
        Color = Color3.fromRGB(182, 129, 99);
        Material = Enum.Material.Neon;
    };
    RadiantPolarBlue = {
        Color = Color3.fromRGB(0, 0, 165);
        Material = Enum.Material.Neon;
    };
    Mud = {
        Color = Color3.fromRGB(102, 86, 68);
    };
    RadiantWhite = {
        Color = Color3.fromRGB(160, 160, 165);
        Material = Enum.Material.Neon;
    };
    SnowWhite = {
        Color = Color3.fromRGB(255, 255, 255);
    };
}
for _, v in HyperChromeUtils.getListOfHyperChromeNames(), nil do
    local var39 = HyperChromeConsts.COLOR_TO_INFO_MAP[HyperChromeUtils.getColorFromName(v)].LevelToColor[HyperChromeUtils.getLevelFromName(v)]
    local any_ToHSV_result1, any_ToHSV_result2, any_ToHSV_result3 = Color3.new(math.clamp(var39.r, 0, 1), math.clamp(var39.g, 0, 1), math.clamp(var39.b, 0, 1)):ToHSV()
    module_upvr[v] = {
        Color = Color3.fromHSV(any_ToHSV_result1, any_ToHSV_result2, math.clamp(any_ToHSV_result3 * 2 / 3, 0, 1));
        Reflectance = 0.1;
    }
end
module_upvr[HyperChromeConsts.COLOR_SHIFT_NAME] = {
    Color = Color3.fromRGB(1, 1, 1);
    Reflectance = 0.1;
}
return {
    GetColor = function(arg1) -- Line 150, Named "GetColor"
        if module_upvr[arg1] then
            return module_upvr[arg1].Color
        end
        if Settings_upvr.Colors[arg1] then
            return Settings_upvr.Colors[arg1]
        end
        return nil
    end;
    Part = function(arg1, arg2, arg3) -- Line 158, Named "Part"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        assert(true)
        if arg3 == nil then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
}