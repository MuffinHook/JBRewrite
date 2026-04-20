local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var26_upvw
local Players_upvr = game:GetService("Players")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
return {
    Items = {{
        Name = "Sendoff";
        SoundId = 12616040786;
        Price = 25000;
    }, {
        Name = "Ahooga";
        SoundId = 12616042121;
        Price = 25000;
    }, {
        Name = "Airhorn";
        SoundId = 12616043274;
        Price = 35000;
    }, {
        Name = "Cruiseliner";
        SoundId = 12616044246;
        Price = 10000;
    }, {
        Name = "Bicycle";
        SoundId = 12616045116;
        Price = 2500;
    }, {
        Name = "FireBrigade";
        SoundId = 12616045912;
        Price = 5000;
        Looped = true;
    }, {
        Name = "Quack";
        SoundId = 12616046852;
        Price = 35000;
    }, {
        Name = "City";
        SoundId = 12616048429;
        Price = 2500;
        Looped = true;
    }, {
        Name = "Steamer";
        SoundId = 12616049198;
        Price = 15000;
        Looped = true;
    }, {
        Name = "MeepMeep";
        SoundId = 12616050969;
        Price = 12500;
    }, {
        Name = "ChampionTrumpets";
        SoundId = 12413440203;
        Loopable = true;
        Season = 14;
        TopPct = 2;
        SeasonIconId = 12424991433;
    }, {
        Name = "Winner";
        SoundId = 11183684353;
        Loopable = false;
        Season = 12;
        TopPct = 2;
        SeasonIconId = 11183663452;
    }, {
        Name = "Cucaracha";
        SoundId = 9316479741;
        Loopable = false;
        Season = 9;
        TopPct = 5;
    }, {
        Name = "Original";
        SoundId = 9058828003;
        Loopable = true;
        MaxPlaybackTime = 1;
        Price = 0;
    }, {
        Name = "Realistic";
        SoundId = 8990467635;
        Price = 5000;
        Loopable = true;
    }, {
        Name = "Train";
        SoundId = 8990467123;
        Price = 25000;
        Loopable = false;
    }, {
        Name = "Clown";
        SoundId = 8990466434;
        Price = 20000;
        Loopable = false;
    }, {
        Name = "DropWeapons";
        SoundId = 8990461116;
        Price = 30000;
        Loopable = false;
    }, {
        Name = "RumbleSiren";
        SoundId = 9058366741;
        Price = 10000;
        Loopable = true;
    }, {
        Name = "Countdown";
        SoundId = 8990459885;
        Price = 5000;
        Loopable = false;
        MaxPlaybackTime = 3.5;
    }, {
        Name = "Injan";
        SoundId = 739735604;
        Loopable = true;
        Hidden = true;
        NoTrade = true;
    }};
    GetInstance = function(arg1) -- Line 134, Named "GetInstance"
        local clone = ReplicatedStorage_upvr.Resource:FindFirstChild("GarageHornVisual"):Clone()
        clone:PivotTo(CFrame.new(0, 0, 0))
        return clone
    end;
    Update = function(arg1, arg2) -- Line 141, Named "Update"
        local var25 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var25 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var25) * 0.1 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.PrimaryPart.Size.Magnitude)
    end;
    onItemSelected = function(arg1) -- Line 150, Named "onItemSelected"
        if var26_upvw then
            var26_upvw:Destroy()
            var26_upvw = nil
        end
        if not Players_upvr.LocalPlayer then
        else
            local tbl = {
                Volume = 0.25;
            }
            if arg1.MaxPlaybackTime then
                tbl.MaxPlaybackTime = arg1.MaxPlaybackTime
            end
            var26_upvw = Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, arg1.SoundId, tbl)
        end
    end;
}