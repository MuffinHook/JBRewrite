local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProximitySoundConsts_upvr = require(script.Parent.ProximitySoundConsts)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr_2.new(arg1) -- Line 14
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr._maid = Maid_upvr.new()
    if not arg1:GetAttribute(ProximitySoundConsts_upvr.ENABLED_ATTR_NAME) then
        arg1:SetAttribute(ProximitySoundConsts_upvr.ENABLED_ATTR_NAME, false)
    end
    if not arg1:GetAttribute(ProximitySoundConsts_upvr.RADIUS_ATTR_NAME) then
        arg1:SetAttribute(ProximitySoundConsts_upvr.RADIUS_ATTR_NAME, 32)
    end
    if not arg1:GetAttribute(ProximitySoundConsts_upvr.MAX_VOLUME_ATTR_NAME) then
        arg1:SetAttribute(ProximitySoundConsts_upvr.MAX_VOLUME_ATTR_NAME, 1)
    end
    module_upvr._target = 0
    module_upvr._current = 0
    module_upvr._maid:GiveTask(arg1:GetAttributeChangedSignal(ProximitySoundConsts_upvr.ENABLED_ATTR_NAME):Connect(function() -- Line 34, Named "updateEnabled"
        if arg1:GetAttribute(ProximitySoundConsts_upvr.ENABLED_ATTR_NAME) then
            module_upvr:Listen(arg1)
        else
            module_upvr._maid._stop = nil
        end
    end))
    if arg1:GetAttribute(ProximitySoundConsts_upvr.ENABLED_ATTR_NAME) then
        module_upvr:Listen(arg1)
        return module_upvr
    end
    module_upvr._maid._stop = nil
    return module_upvr
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr_2.Listen(arg1, arg2) -- Line 47
    local var10_upvw
    local var11_upvw
    local _maid_upvr = arg1._maid
    local var14_upvw = false
    _maid_upvr._listenLoop = Interval_upvr.every(0.5):Connect(function() -- Line 52
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
        if not any_getRootPart_result1 or not any_getRootPart_result1:IsDescendantOf(workspace) then return end
        local attribute = arg2:GetAttribute(ProximitySoundConsts_upvr.RADIUS_ATTR_NAME)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if var11_upvw then
            var11_upvw:cancel()
            var11_upvw = nil
        end
        if not var10_upvw then
            var10_upvw = Audio_upvr.ObjectLocal(arg2, arg2:GetAttribute(ProximitySoundConsts_upvr.ID_ATTR_NAME), {
                Looped = true;
                Volume = 0;
                RollOffMaxDistance = attribute + 64;
                RollOffMinDistance = attribute * 0.1;
            })
        end
        var14_upvw = true
        var11_upvw = Audio_upvr.promiseFadeTo(var10_upvw, 1, 1):andThen(function() -- Line 75
            var11_upvw = nil
        end)
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if var14_upvw then
            if var11_upvw then
                var11_upvw:cancel()
                var11_upvw = nil
            end
            var14_upvw = false
            var11_upvw = Audio_upvr.promiseFadeTo(var10_upvw, 0, 1):andThen(function() -- Line 87
                var10_upvw:Destroy()
                var10_upvw = nil
            end):andThen(function() -- Line 91
                var11_upvw = nil
            end)
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
    function _maid_upvr._stop() -- Line 97
        _maid_upvr._listenLoop = nil
        if var11_upvw then
            var11_upvw:cancel()
            var11_upvw = nil
        end
        if var10_upvw then
            Audio_upvr.promiseFadeTo(var10_upvw, 0, 1):andThen(function() -- Line 104
                var10_upvw:Destroy()
                var10_upvw = nil
            end)
        end
    end
end
function module_upvr_2.Destroy(arg1) -- Line 111
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr_2