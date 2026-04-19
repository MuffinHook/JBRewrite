-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQD01ha2VGdXp6eUZpbmRlcg9HZXRDb21tYW5kTmFtZXMJVHJhbnNmb3JtKU5vIGNvbW1hbmQgd2l0aCB0aGF0IG5hbWUgY291bGQgYmUgZm91bmQuCFZhbGlkYXRlDEF1dG9jb21wbGV0ZQVQYXJzZQdjb21tYW5kDFJlZ2lzdGVyVHlwZQhjb21tYW5kcxBNYWtlTGlzdGFibGVUeXBlB3JlcXVpcmUGc2NyaXB0BlBhcmVudAZTaGFyZWQEVXRpbAAGBAECAAAADPsBAABNAQE9AAAAAPsCAQC8AgLaAQAAAJ8CAgCfAQACUgIBAFIDAACfAgIAggIAAAIDAQMCAAUDARgAAAAAAAAAAAIAAAAGAAAAAAQBAAAAAAgcAgAAjAMAALcDAgACAAAAqQEAAakBAQBvAgAAggEDAAEDBAALBQEYAAAAAAAAAAAMAAAAAAEBAAAAAAGCAAIAAAAPBgEYABAAAAAAAgEAAAAAAhMBAACCAQIAAAATBwEYAAAUAAAAAAcBAQAAAB7iAQQA2QIAABICAAASAAAAMAIBIQAAAADAAgUAMAIBdgEAAADAAgYAMAIBqwIAAADAAgcAMAIBmwMAAABvBAgAUgUBALwCAN0JAAAAnwIEAW8ECgD7BQAATQUFJAsAAABSBgEAnwUCALwCAN0JAAAAnwIAAYIAAQAMAwMDBQMGAwcFBAABAgMGAQYCBgMDCAMJAwoDCwQAAQIDAwABGAABAAAAAAYAAAQAAAQAAAUAAAAAAQAAAAAAAAAAAQQAAAAAAgAAAQIAEaMAAACkAAEAAAAAQKQBAwAAACBATQEBJAQAAABNAQEkBAAAAE0BARIFAAAATQEBngYAAACfAAICwAEHABIAAACCAQIACAMMBAAAAEADDQQAACBAAw4DDwMQBgQBBAEAARgAAAAAAAAAAAAAAAAAAAIAAAEAAAAABVKSCrbXIz64o2aCwAMkSG4iih3CYFZgtw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:43
-- Luau version 6, Types version 3
-- Time taken: 0.001537 seconds

local Util_upvr = require(script.Parent.Parent.Shared.Util)
return function(arg1) -- Line 3
    --[[ Upvalues[1]:
        [1]: Util_upvr (readonly)
    ]]
    local tbl = {
        Transform = function(arg1_2) -- Line 5, Named "Transform"
            --[[ Upvalues[2]:
                [1]: Util_upvr (copied, readonly)
                [2]: arg1 (readonly)
            ]]
            return Util_upvr.MakeFuzzyFinder(arg1:GetCommandNames())(arg1_2)
        end;
        Validate = function(arg1_3) -- Line 11, Named "Validate"
            local var4
            if 0 >= #arg1_3 then
                var4 = false
            else
                var4 = true
            end
            return var4, "No command with that name could be found."
        end;
        Autocomplete = function(arg1_4) -- Line 15, Named "Autocomplete"
            return arg1_4
        end;
        Parse = function(arg1_5) -- Line 19, Named "Parse"
            return arg1_5[1]
        end;
    }
    arg1:RegisterType("command", tbl)
    arg1:RegisterType("commands", Util_upvr.MakeListableType(tbl))
end