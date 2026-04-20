local HotbarItemRes_upvr = require(script.Parent.HotbarItemRes)
return {
    init = function() -- Line 4, Named "init"
        require(script.Parent.HotbarItemSystem).init()
    end;
    setColor = function(arg1) -- Line 7, Named "setColor"
        for _, v in ipairs(HotbarItemRes_upvr.gui.Container:GetChildren()) do
            if v:IsA(HotbarItemRes_upvr.presetFrame.ClassName) then
                v.ImageColor3 = arg1
                v.Index.TextColor3 = arg1
            end
        end
    end;
    show = function() -- Line 16, Named "show"
        local gui = HotbarItemRes_upvr.gui
        if gui then
            gui.Enabled = true
        end
    end;
    hide = function() -- Line 22, Named "hide"
        local gui_2 = HotbarItemRes_upvr.gui
        if gui_2 then
            gui_2.Enabled = false
        end
    end;
}