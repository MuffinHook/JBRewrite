local Localization_upvr = require(game:GetService("ReplicatedStorage").Module.Localization)
return function(arg1) -- Line 6
    local L18n = workspace:FindFirstChild("L18n")
    if L18n then
        for _, v in ipairs(L18n:GetChildren()) do
            local SurfaceGui_2 = v:FindFirstChild("SurfaceGui")
            if SurfaceGui_2 ~= nil then
                local TextLabel_2 = SurfaceGui_2:FindFirstChild("TextLabel")
                if TextLabel_2 ~= nil then
                    TextLabel_2.Text = Localization_upvr:FormatByKey(string.format("world.%s", v.Name));
                end
            end
        end
    end
end