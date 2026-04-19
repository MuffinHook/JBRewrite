-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMgCEluc3RhbmNlA25ldwRQYXJ0BEVudW0IUGFydFR5cGUEQmFsbAVTaGFwZQRTaXplClRvcFN1cmZhY2UNQm90dG9tU3VyZmFjZQhHZXRDb2xvcgROYW1lBUNvbG9yCEFuY2hvcmVkBkNGcmFtZQtHZXRJbnN0YW5jZQJvcwVjbG9jawZBbmdsZXMEbWF0aANzaW4GVXBkYXRlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQFUGFpbnQER2FtZQZHYXJhZ2UFSXRlbXMAAwQBAQAAACKkAQIAAAQAgG8CAwCfAQICpAIHAAYUQMAwAgF+CAAAAG8CCQAwAgEvCgAAAIwCAACMAwAAMAIBHwsAAAAwAwESDAAAAPsCAABNAgILDQAAAE0DALoOAAAAnwICAjACAaQPAAAAqQIBADACAUUQAAAApAISAAAEEIGfAgECMAIBhREAAACCAQIAEwMBAwIEAAQAgAMDAwQDBQMGBAYUQMADBwcAAIBAAACAQAAAgEAAAAAAAwgDCQMKAwsDDAMNAw4DDwQABBCBAAUQARgAAAAAAQAAAAEAAAEAAAAAAAEAAAAAAAAAAQAAAQAAAAABBgAAAAANAgAAAAAipAICAAAEAICfAgECPgMCAyEEAwSkBwcAABhQgIwIAABSCQQAjAoAAJ8HBAKkCAcAABhQgLsYAwNSDAMApAsMAAAsoICfCwICWwoLCXgJCgiMCgAAjAsAAJ8IBAIJBgcIpAcOAAA0UICMCAAAjAkAAIwKCACfBwQCCQUGBzAFAIUFAAAAggABAA8DEQMSBAAEAIACAAAAAAAAAEACGC1EVPshGUADDwMTBAAYUIACMzMzMzMz0z8CAAAAAAAA0D8DFAMVBAAsoIADAgQANFCAABAWARgAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABEQAAAAAHAAABAgAmowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBApAMIAAAAcEBNAwMkCQAAAE0CA6QGAAAAnwECAqQCBQAAAEBATQQAvQsAAABNBAQoDAAAAE0DBFEKAAAAnwICAsADDQASAAIAwAQOAE0FATgPAAAA4gYSADAFBjgPAAAAMAMGURAAAAAwBAYmEQAAAIIGAgATAxcEAAAAQAMYAxkDGgQAAEBAAw0DGwQAAHBAAxwDHQMeAx8GAAYBAyADEAMWBQMPEBECAAEBAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAIACwYAAQEAAQABAAABAAAAAALbOiSWIiXHHXyqAvyyP147qyIz4un+Tpc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:23
-- Luau version 6, Types version 3
-- Time taken: 0.001350 seconds

local Paint_upvr = require(game:GetService("ReplicatedStorage").Game.Garage.Paint)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 5, Named "GetInstance"
        --[[ Upvalues[1]:
            [1]: Paint_upvr (readonly)
        ]]
        local Part = Instance.new("Part")
        Part.Shape = Enum.PartType.Ball
        Part.Size = Vector3.new(4, 4, 4)
        Part.TopSurface = 0
        Part.BottomSurface = 0
        Part.Color = Paint_upvr.GetColor(arg1.Name)
        Part.Anchored = true
        Part.CFrame = CFrame.new()
        return Part
    end;
    Update = function(arg1, arg2) -- Line 16, Named "Update"
        local var3 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var3 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var3) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
    end;
}