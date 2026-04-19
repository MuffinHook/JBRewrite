-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSC0JvdW5kaW5nQm94DkZpbmRGaXJzdENoaWxkC1ByaW1hcnlQYXJ0DmdldFByaW1hcnlQYXJ0DU1heExpbmtMZW5ndGgMU2V0QXR0cmlidXRlEHNldE1heExpbmtMZW5ndGgMR2V0QXR0cmlidXRlEGdldE1heExpbmtMZW5ndGgISXNMaW5rZWQLc2V0SXNMaW5rZWQLZ2V0SXNMaW5rZWQZR2V0QXR0cmlidXRlQ2hhbmdlZFNpZ25hbBhnZXRJc0xpbmtlZENoYW5nZWRTaWduYWwMTGlua0Rpc2FibGVkC3NldERpc2FibGVkC2dldERpc2FibGVkGGdldERpc2FibGVkQ2hhbmdlZFNpZ25hbAAKBAEAAAAACG8DAAC8AQADAQAAAJ8BAwIrAQIATQEAmwIAAACCAQIAAwMBAwIDAwACBAEYAAAAAAAAAAADAAAAAAYCAAAAAAZvBAAAUgUBALwCAC4BAAAAnwIEAYIAAQACAwUDBgAFBwEYAAAAAAABBgAAAAAEAQAAAAAFbwMAALwBABIBAAAAnwEDAIIBAAACAwUDCAAICQEYAAAAAAAJAAAAAAYCAAAAAAZvBAAAUgUBALwCAC4BAAAAnwIEAYIAAQACAwoDBgALCwEYAAAAAAABDAAAAAAEAQAAAAAFbwMAALwBABIBAAAAnwEDAIIBAAACAwoDCAAODAEYAAAAAAAPAAAAAAQBAAAAAAVvAwAAvAEAFgEAAACfAQMAggEAAAIDCgMNABEOARgAAAAAABIAAAAABgIAAAAABm8EAABSBQEAvAIALgEAAACfAgQBggABAAIDDwMGABQQARgAAAAAAAEVAAAAAAQBAAAAAAVvAwAAvAEAEgEAAACfAQMAggEAAAIDDwMIABcRARgAAAAAABgAAAAABAEAAAAABW8DAAC8AQAWAQAAAJ8BAwCCAQAAAgMPAw0AGhIBGAAAAAAAGwAAAAACAAABAgAfowAAAP8ABQAAAAAAwAEAADABAGgBAAAAwAECADABAAoDAAAAwAEEADABAAYFAAAAwAEGADABAJkHAAAAwAEIADABAK0JAAAAwAEKADABAHcLAAAAwAEMADABAKkNAAAAwAEOADABAN0PAAAAwAEQADABAOERAAAAggACABIGAAMEBgEDBwYCAwkGAwMLBgQDDAYFAw4GBgMQBgcDEQYIAxIJAAECAwQFBgcIAQABGAAAAAEAAAMAAAMAAAMAAAMAAAMAAAMAAAMAAAMAAAMBAAAAAAn9yJJK1QJWs1twqVbGrmyCjdCFPs8M+Es=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:56
-- Luau version 6, Types version 3
-- Time taken: 0.002055 seconds

return {
    getPrimaryPart = function(arg1) -- Line 2, Named "getPrimaryPart"
        local BoundingBox = arg1:FindFirstChild("BoundingBox")
        if not BoundingBox then
            BoundingBox = arg1.PrimaryPart
        end
        return BoundingBox
    end;
    setMaxLinkLength = function(arg1, arg2) -- Line 5, Named "setMaxLinkLength"
        arg1:SetAttribute("MaxLinkLength", arg2)
    end;
    getMaxLinkLength = function(arg1) -- Line 8, Named "getMaxLinkLength"
        return arg1:GetAttribute("MaxLinkLength")
    end;
    setIsLinked = function(arg1, arg2) -- Line 11, Named "setIsLinked"
        arg1:SetAttribute("IsLinked", arg2)
    end;
    getIsLinked = function(arg1) -- Line 14, Named "getIsLinked"
        return arg1:GetAttribute("IsLinked")
    end;
    getIsLinkedChangedSignal = function(arg1) -- Line 17, Named "getIsLinkedChangedSignal"
        return arg1:GetAttributeChangedSignal("IsLinked")
    end;
    setDisabled = function(arg1, arg2) -- Line 20, Named "setDisabled"
        arg1:SetAttribute("LinkDisabled", arg2)
    end;
    getDisabled = function(arg1) -- Line 23, Named "getDisabled"
        return arg1:GetAttribute("LinkDisabled")
    end;
    getDisabledChangedSignal = function(arg1) -- Line 26, Named "getDisabledChangedSignal"
        return arg1:GetAttributeChangedSignal("LinkDisabled")
    end;
}