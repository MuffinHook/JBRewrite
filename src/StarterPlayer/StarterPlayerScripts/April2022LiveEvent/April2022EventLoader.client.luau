-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRBE5hbWUYQXByaWwyMDIyTGl2ZUV2ZW50Q2xpZW50GUFwcmlsMjAyMkxpdmVFdmVudFJ1bnRpbWUMV2FpdEZvckNoaWxkBHRhc2sEd2FpdAdyZXF1aXJlBGluaXQFcHJpbnQoTG9hZGVkIEFwcmlsIDIwMjIgbGl2ZSBldmVudCBjbGllbnQgY29kZQVjaGVjawRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UORmluZEZpcnN0Q2hpbGQKQ2hpbGRBZGRlZAdDb25uZWN0AAIEAQAAAAAaKwABAIIAAQBNAQC6AAAAAPABFAABAACAbwMCALwBANMDAAAAnwEDAqQCBgAAFECAbwMHAJ8CAgGkAgkAAACAQFIDAQCfAgICTQICEwoAAACfAgEBpAIMAAAAsEBvAw0AnwICAYIAAQAOAwEDAgMDAwQDBQMGBAAUQIACmpmZmZmZuT8DBwQAAIBAAwgDCQQAALBAAwoABQsBGAABAgAAAAEAAAABAAAAAQAAAAAAAAEAAAACBgAAAAAGAAABAgAVowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAsABBABSAgEAbwUFALwDAAMGAAAAnwMDAJ8CAAFNAgBrBwAAAFIEAQC8AgLHCAAAAJ8CAwGCAAEACQMMBAAAAEADDQMOBgADAgMPAxADEQEAAQABGAAAAAAAAAAECwAAAAAAAQAAAAAAAQEAAAAAAUvpCv/6R2Ua9Ki+dzRsUjY78R2LeS1g/g==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:34
-- Luau version 6, Types version 3
-- Time taken: 0.000847 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function check(arg1) -- Line 5
    if not arg1 then
    elseif arg1.Name == "April2022LiveEventClient" then
        task.wait(0.1)
        require(arg1:WaitForChild("April2022LiveEventRuntime")).init()
        print("Loaded April 2022 live event client code")
    end
end
check(ReplicatedStorage:FindFirstChild("April2022LiveEventClient"))
ReplicatedStorage.ChildAdded:Connect(check)