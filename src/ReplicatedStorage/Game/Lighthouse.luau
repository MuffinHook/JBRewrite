-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMgCEdldFBpdm90BkNGcmFtZQhQb3NpdGlvbglNYWduaXR1ZGUFZGVidWcMcHJvZmlsZWJlZ2luCkxpZ2h0aG91c2UGQW5nbGVzB1Bpdm90VG8KcHJvZmlsZWVuZANuZXcLUHJpbWFyeVBhcnQETmFtZQZDZW50ZXIvTGlnaHRob3VzZUxpZ2h0IG11c3QgaGF2ZSBDZW50ZXIgYXMgUHJpbWFyeVBhcnQGYXNzZXJ0CUhlYXJ0YmVhdAdDb25uZWN0CEdpdmVUYXNrD0xpZ2h0aG91c2VMaWdodAVTdGFydARJbml0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpSdW5TZXJ2aWNlB3JlcXVpcmUDU3RkBkJpbmRlcgRNYWlkCXdvcmtzcGFjZQ1DdXJyZW50Q2FtZXJhAAQKAQIAAAAn+wEAALwBAVIAAAAAnwECAvsDAQBNAwOFAQAAAE0DAzsCAAAATQQBOwIAAAAmAgMETQICqgMAAAAJAwICbwQEAGAEAgADAAAAggABAKQDBwAAGFCAbwQIAJ8DAgH7AwAApAYKAAAkEICMBwAAbwkLAAkICQCMCQAAnwYEAgkFAQa8AwPCDAAAAJ8DAwGkAw4AADRQgJ8DAQGCAAEADwMBAwIDAwMEAgAAAAAAADBBAwUDBgQAGFCAAwcDCAQAJBCAAgAAAAAAAOA/AwkDCgQANFCAABQAARgAAAAAAQAAAAAAAAAAAAEAAAABAgAAAAEAAAAAAAAAAAAAAAEAAAEVAAAAAAcBAwAAAB/7AQAATQEB7wAAAACfAQECTQQAmwEAAABNBAS6AgAAAPAEAgADAAAAqQMAAakDAQCBAQMEBAAAAG8EBACkAgYAAABQQJ8CAwH7BAEATQQE/QcAAADZBgAAEgAAABICAgC8BATHCAAAAJ8EAwC8AgH9CQAAAJ8CAAGCAQIACgMLAwwDDQMOAw8DEAQAAFBAAxEDEgMTAQAMAAEYAAAAAAMAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAACw0AAAAAAwAEAAAADfsAAABNAADvAAAAAG8BAQDAAgIAEgIBABICAgASAgMAnwADArwBABwDAAAAnwECAYIAAQAEAwsDFAYBAxUBAQoWARgAAAAAAAAAAAAVAAABDAAAAAAHAAABAgApowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAqQCBgAAAFBATQMAoQcAAABNAwN/CAAAAJ8CAgKkAwYAAABQQE0EAKEHAAAATQQEdgkAAACfAwICpAQLAAAAoEBNBARIDAAAAP8FAQAAAAAAwAYNABIAAgASAAMAEgABABIABAAwBgVzDgAAAIIFAgAPAxcEAAAAQAMYAxkDGgMbBAAAUEADHAMdAx4DHwQAAKBAAyAGAgMWAQIBAAEYAAAAAAAAAAEAAAAAAAEAAAAAAAABAAAAAAAAAwAAAAIAAQAAAAAAABkBAAAAAAN6RwCsTsmIYcgDsfOEZ1inCl8X2EiDaq0=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:21
-- Luau version 6, Types version 3
-- Time taken: 0.002644 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
local CurrentCamera_upvr = workspace.CurrentCamera
function module.Init() -- Line 10
    --[[ Upvalues[4]:
        [1]: Binder_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: RunService_upvr (readonly)
        [4]: CurrentCamera_upvr (readonly)
    ]]
    Binder_upvr.new("LighthouseLight", function(arg1) -- Line 12
        --[[ Upvalues[3]:
            [1]: Maid_upvr (copied, readonly)
            [2]: RunService_upvr (copied, readonly)
            [3]: CurrentCamera_upvr (copied, readonly)
        ]]
        local any_new_result1 = Maid_upvr.new()
        local var9
        if arg1.PrimaryPart.Name ~= "Center" then
            var9 = false
        else
            var9 = true
        end
        assert(var9, "LighthouseLight must have Center as PrimaryPart")
        any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 20
            --[[ Upvalues[2]:
                [1]: arg1 (readonly)
                [2]: CurrentCamera_upvr (copied, readonly)
            ]]
            local any_GetPivot_result1 = arg1:GetPivot()
            local Magnitude = (CurrentCamera_upvr.CFrame.Position - any_GetPivot_result1.Position).Magnitude
            if 1048576 < Magnitude * Magnitude then
            else
                debug.profilebegin("Lighthouse")
                arg1:PivotTo(any_GetPivot_result1 * CFrame.Angles(0, 0.5 * arg1_2, 0))
                debug.profileend()
            end
        end))
        return any_new_result1
    end):Start()
end
return module