-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWCG51bUl0ZW1zBWl0ZW1zC2FzcGVjdFJhdGlvFHZlcnRpY2FsUGFkZGluZ1JhdGlvAmlkBG5hbWUJY29tcG9uZW50BW1lcmdlBHNpemUIcG9zaXRpb24FVURpbTIJZnJvbVNjYWxlDmNyZWF0ZUZyYWdtZW50FGhvcml6b250YWxTcXVhcmVHcmlkBnNjcmlwdARFelVpEUZpbmRGaXJzdEFuY2VzdG9yB3JlcXVpcmUKRGljdGlvbmFyeQZQYXJlbnQFUm9hY3QNY3JlYXRlRWxlbWVudAACFQEDAAAASf8BAAAAAAAATQIAwwAAAAArAgMATQMAGAEAAAAcAgMATQMAiQIAAABNBgDGBAAAANgFAwbsBAUDjAcBAFIFAgCMBgEAqAUxAHgJBwM+CgIFJggJCk0KABgBAAAAhwkKBysJAgD/CQAAAAAAAE0KCfQGAAAAKwoFAE0KCVoHAAAAKwoCABwLAQCVCgsD+wsAAE0MAOgIAAAA+w0BAE0NDR8JAAAATQ8AGAEAAACHDg8H4g8MAKQQDwAAONCA2BEDA4wSAQCfEAMCMBAPDwoAAACkEA8AADjQgG8TEADsFAgDQxITFAkTCARDERITjBIAAJ8QAwIwEA/bCwAAAJ8NAwCfCwACagsBCosFz//7BQIATQUFNhEAAABSBgEAnwUCAIIFAAASAwEDAgMDAgAAAAAAAPA/AwQCAAAAAAAAAEADBQMGAwcDCAMJAwoFAgoLAwsDDAQAONCAAgAAAAAAAOA/Aw0ACQ4BGAAAAQAAAAAAAQABAAAAAQAAAAEAAAEAAAAAAAEAAAAAAAAAAQEAAQAAAAAAAAEAAAAAAAABAAAAAAAAAAAAAP7+B/UNAAAAAAAKAAAAAAUAAAECABqjAAAApAABAAAAAEBvAgIAvAAAfAMAAACfAAMCpAEFAAAAQEBNAgCpBgAAAJ8BAgKkAgUAAABAQE0DACQHAAAATQMDIQgAAACfAgICTQMCygkAAADABAoAEgADABIAAQASAAIAggQCAAsDDwQAAABAAxADEQMSBAAAQEADEwMUAxUDFgYAAQABAAEYAAEAAAAAAAEAAAAAAQAAAAAAAAEABAAAABQBAAAAAAE4jeQz429CNqjckFpE3R2sSJXzRwpJjjI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:57
-- Luau version 6, Types version 3
-- Time taken: 0.003205 seconds

local EzUi = script:FindFirstAncestor("EzUi")
local Roact_upvr = require(EzUi.Parent.Roact)
local createElement_upvr = Roact_upvr.createElement
local Dictionary_upvr = require(EzUi.Dictionary)
return function(arg1) -- Line 9, Named "horizontalSquareGrid"
    --[[ Upvalues[3]:
        [1]: createElement_upvr (readonly)
        [2]: Dictionary_upvr (readonly)
        [3]: Roact_upvr (readonly)
    ]]
    local module = {}
    local numItems_2 = arg1.numItems
    if not numItems_2 then
        numItems_2 = #arg1.items
    end
    local aspectRatio = arg1.aspectRatio
    for i = 1, numItems_2 do
        local var19 = i - 1 - numItems_2 / 2
        local var20 = arg1.items[i]
        if not var20 then
            var20 = {}
        end
        local id = var20.id
        if not id then
            id = var20.name
            if not id then
                id = #module + 1
            end
        end
        module[id] = createElement_upvr(arg1.component, Dictionary_upvr.merge(arg1.items[i], {
            size = UDim2.fromScale(1 / aspectRatio, 1);
            position = UDim2.fromScale(0.5 + var19 / aspectRatio + (var19) * (1 / arg1.verticalPaddingRatio / aspectRatio), 0);
        }))
    end
    return Roact_upvr.createFragment(module)
end