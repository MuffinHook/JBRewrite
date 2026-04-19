-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdCFJlc291cmNlBkVuZ2luZQROYW1lDkZpbmRGaXJzdENoaWxkBWVycm9yEU5vIEVuZ2luZSBuYW1lZDogBUNsb25lBkNGcmFtZQNuZXcLR2V0SW5zdGFuY2UCb3MFY2xvY2sGQW5nbGVzBG1hdGgDc2luBFNpemUJTWFnbml0dWRlBlVwZGF0ZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFU3BlZWQFUHJpY2UHTGV2ZWwgMQdMZXZlbCAyB0xldmVsIDMHTGV2ZWwgNAdMZXZlbCA1BUl0ZW1zAAMGAQEAAAAf+wEAAE0BAWIAAAAATQEBZgEAAABNAwC6AgAAALwBAQMDAAAAnwEDAisBBwCkAgUAAABAQG8EBgBNBQC6AgAAAHMDBAWfAgIBvAIBOgcAAACfAgICUgECAKQCCgAAJICAjAMAAIwEAACMBQAAnwIEAjACAYUIAAAAggECAAsDAQMCAwMDBAMFBAAAQEADBgMHAwgDCQQAJICAAB0KARgAAAAAAAAAAAAAAQEAAAAAAAACAAAABAAAAAAAAAABHgAAAAANAgAAAAAlpAICAAAEAICfAgECPgMCAyEEAwSkBwcAABhQgIwIAABSCQQAjAoAAJ8HBAKkCAcAABhQgLsYAwNSDAMApAsMAAAsoICfCwICWwoLCXgJCgiMCgAAjAsAAJ8IBAIJBgcIpAcOAAA0UICMCAAAjAkAAE0KAS8PAAAATQoKqhAAAACfBwQCCQUGBzAFAIUFAAAAggABABEDCwMMBAAEAIACAAAAAAAAAEACGC1EVPshGUADCAMNBAAYUIACMzMzMzMz0z8CmpmZmZmZuT8DDgMPBAAsoIADCQQANFCAAxADEQAqEgEYAAAAAQEBAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAP4AAysAAAAACAAAAQIASKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQAABQAAAOICBwBvAwgAMAMCugQAAACMAwAAMAMCLAUAAACMAwAAMAMCJAYAAADiAwcAbwQJADAEA7oEAAAAbwQKADAEAywFAAAAjARAHzAEAyQGAAAA4gQHAG8FCwAwBQS6BAAAAG8FDAAwBQQsBQAAAIwFUEYwBQQkBgAAAOIFBwBvBg0AMAYFugQAAABvBg4AMAYFLAUAAACMBgB9MAYFJAYAAADiBgcAbwcPADAHBroEAAAAjAcDADAHBiwFAAAAbwcQADAHBiQGAAAAxQECBgEAAADAAhEAEgAAAMADEgDiBBYAMAEEOBMAAAAwAgRRFAAAADADBCYVAAAAggQCABcDEwQAAABAAxQDFQMDAxYDFwUDBAUGAxgDGQIAAAAAAADoPwMaAgAAAAAAAPg/AxsCAAAAAAAAAkADHAIAAAAAAGroQAYABgEDHQMKAxIFAxMUFQIAAQEAARgAAAAAAAAAAQABAQAAAQAAAQAAAgEAAAEAAAEAAAIBAAABAAABAAACAQAAAQAAAQAAAgEAAAEAAAEAAAAAAwANCAEAAQABAAABAAAAAAItVTLJ1SgWcBwCuwz3W89mXU0lvR+RWMg=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:22
-- Luau version 6, Types version 3
-- Time taken: 0.002958 seconds

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
        --[[ Upvalues[1]:
            [1]: ReplicatedStorage_upvr (readonly)
        ]]
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