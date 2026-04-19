-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMGBU1vZGVsB1NvdW5kSWQITG9vcGFibGUNVmVoaWNsZUhvcm5JZAxTZXRBdHRyaWJ1dGUTVmVoaWNsZUhvcm5Mb29wYWJsZQACCQIAAAAPAAADDwMDDg8EBQwPAgASEk0CATsAAAAADgAOAE0DAHwBAAAATQQAuQIAAABvBwMAUggDALwFAi4EAAAAnwUEAW8HBQBSCAQAvAUCLgQAAACfBQQBggABAAYDAQMCAwMDBAMFAwYAAgABGAAAAQEAAQACAAAAAAEAAAAAAgMAAAAAAQAAAQIAA6MAAADAAAAAggACAAEGAAEAAQABGAABAAEAAAAAAZ7Dte0sUKL2rAffeXy91u8M2se5vXNRaBLD3zYlrdqgaoWZmvDssEQ=

return function(v0, v1) --[[ Line: 2 ]]
    local l_Model_0 = v1.Model;
    if v0 then
        local l_SoundId_0 = v0.SoundId;
        local l_Loopable_0 = v0.Loopable;
        l_Model_0:SetAttribute("VehicleHornId", l_SoundId_0);
        l_Model_0:SetAttribute("VehicleHornLoopable", l_Loopable_0);
    end;
end;