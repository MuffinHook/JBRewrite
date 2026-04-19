-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLBW1lcmdlGmluamVjdFBhZGRlZENvbnRhaW5lclByb3BzB3JlcXVpcmUGc2NyaXB0BlBhcmVudApEaWN0aW9uYXJ5DVNjcm9sbGluZ0dyaWQERXpVaRFGaW5kRmlyc3RBbmNlc3RvcgVSb2FjdA1jcmVhdGVFbGVtZW50AAIHAQMAAAAN+wEAAPsCAQD7AwIATQMDHwAAAABSBAAA4gUCAKkGAQAwBgUTAQAAAJ8DAwCfAQAAggEAAAMDAQMCBQEBAAgAARgAAQEAAAAAAQAA//4ACQAAAAAGAAABAgAnowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAakFAAAAnwACAqQBAQAAAABApAIDAAAAIEBNAgIkBAAAAE0CAlYGAAAAnwECAqQCAwAAACBAbwQHALwCAnwIAAAAnwIDAqQDAQAAAABATQQCJAQAAABNBAQhCQAAAJ8DAgJNBAPKCgAAAMAFCwASAAQAEgABABIAAACCBQIADAMDBAAAAEADBAQAACBAAwUDBgMHAwgDCQMKAwsGAAEAAQABGAABAAAAAAAAAAABAAAAAAAAAAABAAAAAAABAAAAAAAAAQACAAAAAAEAAAAAAXJk8wysW9IAjtwrU81kVSsCfOR4QKCZDQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:57
-- Luau version 6, Types version 3
-- Time taken: 0.000811 seconds

local createElement_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact).createElement
local ScrollingGrid_upvr = require(script.Parent.ScrollingGrid)
local Dictionary_upvr = require(script.Parent.Dictionary)
return function(arg1) -- Line 8
    --[[ Upvalues[3]:
        [1]: createElement_upvr (readonly)
        [2]: ScrollingGrid_upvr (readonly)
        [3]: Dictionary_upvr (readonly)
    ]]
    return createElement_upvr(ScrollingGrid_upvr, Dictionary_upvr.merge(arg1, {
        injectPaddedContainerProps = true;
    }))
end