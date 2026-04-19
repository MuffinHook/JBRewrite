-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSB01ha2VDYXIFU3BlZWQLT3BlbmVkVmF1bHQFTW9kZWwNVmF1bHREb29yTWFpbg5GaW5kRmlyc3RDaGlsZAVlcnJvchtNaXNzaW5nIFZhdWx0RG9vck1haW4gbW9kZWwHRGVzdHJveQdNb3ZlQ2FyCkRlc3Ryb3lDYXIEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUHRGVmYXVsdAZzY3JpcHQGUGFyZW50AAQDAQEAAAAG+wEAAE0BAScAAAAAUgIAAJ8BAgCCAQAAAQMBAAQBARgAAAAAAAAFAAAAAAkEAQAAACRNBAEsAAAAAIwFBQB9BBcABQAAAE0EAZ8BAAAAKwQTAKkEAQAwBAGfAQAAAE0EADsCAAAATQUEOwIAAABvBwMAvAUFAwQAAACfBQMCKwUEAKQGBgAAAFBAbwcHAJ8GAgG8BgVQCAAAAJ8GAgH7BAAATQQEPAkAAABSBQAAUgYBAFIHAgBSCAMAnwQFAIIEAAAKAwIDAwMEAwUDBgMHBAAAUEADCAMJAwoABwoBGAAAAAAAAQAAAQAAAQABAAAAAAABAQAAAAIAAAMAAAAAAAAAAAgAAAAAAwEBAAAABvsBAABNAQFxAAAAAFICAACfAQIAggEAAAEDCwAVCwEYAAAAAAAAFgAAAAAGAAABAgAeowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBApAMIAAAAcEBNAwMkCQAAAE0CAzoGAAAAnwECAsACCgASAAEAwAMLABIAAQDABAwAEgABAOIFEAAwAgUnDQAAADADBTwOAAAAMAQFcQ8AAACCBQIAEQMMBAAAAEADDQMOAw8EAABAQAMQAxEEAABwQAMSBgAGAQYCAwEDCgMLBQMNDg8DAAECAQABGAAAAAAAAAACAAAAAAAAAAABAAMADgADAQABAAEAAAEAAAAAA+gI39Pkz7ehP/UOMj4VuLmYEMin2sy10g==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:47
-- Luau version 6, Types version 3
-- Time taken: 0.001358 seconds

local Default_upvr = require(script.Parent.Default)
return {
    MakeCar = function(arg1) -- Line 4, Named "MakeCar"
        --[[ Upvalues[1]:
            [1]: Default_upvr (readonly)
        ]]
        return Default_upvr.MakeCar(arg1)
    end;
    MoveCar = function(arg1, arg2, arg3, arg4) -- Line 7, Named "MoveCar"
        --[[ Upvalues[1]:
            [1]: Default_upvr (readonly)
        ]]
        if arg2.Speed <= 5 and not arg2.OpenedVault then
            arg2.OpenedVault = true
            local VaultDoorMain = arg1.Model.Model:FindFirstChild("VaultDoorMain")
            if not VaultDoorMain then
                error("Missing VaultDoorMain model")
            end
            VaultDoorMain:Destroy()
        end
        return Default_upvr.MoveCar(arg1, arg2, arg3, arg4)
    end;
    DestroyCar = function(arg1) -- Line 21, Named "DestroyCar"
        --[[ Upvalues[1]:
            [1]: Default_upvr (readonly)
        ]]
        return Default_upvr.DestroyCar(arg1)
    end;
}