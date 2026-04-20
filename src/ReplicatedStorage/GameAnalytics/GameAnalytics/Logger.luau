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