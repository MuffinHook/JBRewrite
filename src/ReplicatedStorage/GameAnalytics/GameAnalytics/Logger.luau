-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZDV9kZWJ1Z0VuYWJsZWQLc2V0RGVidWdMb2cPX2luZm9Mb2dFbmFibGVkCnNldEluZm9Mb2cXX2luZm9Mb2dBZHZhbmNlZEVuYWJsZWQNc2V0VmVyYm9zZUxvZxRJbmZvL0dhbWVBbmFseXRpY3M6IAVwcmludAFpF1dhcm5pbmcvR2FtZUFuYWx5dGljczogBHdhcm4BdxVFcnJvci9HYW1lQW5hbHl0aWNzOiAFZXJyb3IEdGFzawVzcGF3bgFlFURlYnVnL0dhbWVBbmFseXRpY3M6IAFkF1ZlcmJvc2UvR2FtZUFuYWx5dGljczogAmlpBGdhbWUKUnVuU2VydmljZQpHZXRTZXJ2aWNlCElzU3R1ZGlvAAoCAgAAAAADMAEAQAAAAACCAAEAAQMBAAoCARgAAAELAAAAAAICAAAAAAMwAQACAAAAAIIAAQABAwMADgQBGAAAAQ8AAAAAAgIAAAAAAzABAPQAAAAAggABAAEDBQASBgEYAAABEwAAAAAFAgAAAAAMTQIAAgAAAAArAgEAggABAG8DAQBSBAEAcwIDBKQDAwAAACBAUgQCAJ8DAgGCAAEABAMDAwcDCAQAACBAABYJARgAAAABAwAAAQAAAAgXAAAAAAUCAAAAAAhvAwAAUgQBAHMCAwSkAwIAAAAQQFIEAgCfAwIBggABAAMDCgMLBAAAEEAAJgwBGAAAAAEAAAAIJwAAAAAEAAEAAAAJbwEAAPsCAABzAAECpAECAAAAEEBSAgAAjAMAAJ8BAwGCAAEAAwMNAw4EAAAQQAAzAAEYAAAAAQAAAAAINAAAAAAEAgAAAAAGpAICAAAEAIDZAwAAEgABAJ8CAgGCAAEAAwMPAxAEAAQAgAEFMhEBGAAAAAAACzMAAAAABQIAAAAADE0CAEAAAAAAKwIBAIIAAQBvAwEAUgQBAHMCAwSkAwMAAAAgQFIEAgCfAwIBggABAAQDAQMSAwgEAAAgQABAEwEYAAAAAQMAAAEAAAAIQQAAAAAFAgAAAAAMTQIA9AAAAAArAgEAggABAG8DAQBSBAEAcwIDBKQDAwAAACBAUgQCAJ8DAgGCAAEABAMFAxQDCAQAACBAAFAVARgAAAABAwAAAQAAAAhRAAAAAAQAAAECACyjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC4gEHAKkCAAAwAgECBAAAAKkCAAAwAgH0BQAAALwCAAoIAAAAnwICAjACAUAGAAAAwAIJADACAeQKAAAAwAILADACAe4MAAAAwAINADACAVoOAAAAwAIPADACAYgQAAAAwAIRADACAZYSAAAAwAITADACAYQUAAAAwAIVADACAYUWAAAAwAIXADACAVgYAAAAggECABkDFgQAAABAAxcDGAMDAwUDAQUDBAUGAxkGAAMCBgEDBAYCAwYGAwMJBgQDDAYGAxEGBwMTBggDFQgAAQIDBAYHCAEAARgAAAAAAAAAAwEAAAEAAAEAAAAAAwAABAAABAAABAAAEAAADAAADgAAEAAAEAEAAAAACSfHNJ9NIz3gdDlX6h32x+5X3yPrFQNeng==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:30:05
-- Luau version 6, Types version 3
-- Time taken: 0.002062 seconds

return {
    _infoLogEnabled = false;
    _infoLogAdvancedEnabled = false;
    _debugEnabled = game:GetService("RunService"):IsStudio();
    setDebugLog = function(arg1, arg2) -- Line 10, Named "setDebugLog"
        arg1._debugEnabled = arg2
    end;
    setInfoLog = function(arg1, arg2) -- Line 14, Named "setInfoLog"
        arg1._infoLogEnabled = arg2
    end;
    setVerboseLog = function(arg1, arg2) -- Line 18, Named "setVerboseLog"
        arg1._infoLogAdvancedEnabled = arg2
    end;
    i = function(arg1, arg2) -- Line 22, Named "i"
        if not arg1._infoLogEnabled then
        else
            print("Info/GameAnalytics: "..arg2)
        end
    end;
    w = function(arg1, arg2) -- Line 38, Named "w"
        warn("Warning/GameAnalytics: "..arg2)
    end;
    e = function(arg1, arg2) -- Line 50, Named "e"
        task.spawn(function() -- Line 51
            --[[ Upvalues[1]:
                [1]: arg2 (readonly)
            ]]
            error("Error/GameAnalytics: "..arg2, 0)
        end)
    end;
    d = function(arg1, arg2) -- Line 64, Named "d"
        if not arg1._debugEnabled then
        else
            print("Debug/GameAnalytics: "..arg2)
        end
    end;
    ii = function(arg1, arg2) -- Line 80, Named "ii"
        if not arg1._infoLogAdvancedEnabled then
        else
            print("Verbose/GameAnalytics: "..arg2)
        end
    end;
}