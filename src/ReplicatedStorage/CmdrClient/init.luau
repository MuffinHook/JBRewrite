local RunService = game:GetService("RunService")
local Shared = script:WaitForChild("Shared")
local module_upvr = require(Shared:WaitForChild("Util"))
if RunService:IsClient() == false then
    error("[Cmdr] Server scripts cannot require the client library. Please require the server library from the server to use Cmdr in your own code.")
end
local setmetatable_result1_upvw = setmetatable({
    ReplicatedRoot = script;
    RemoteFunction = script:WaitForChild("CmdrFunction");
    RemoteEvent = script:WaitForChild("CmdrEvent");
    ActivationKeys = {
        [Enum.KeyCode.F2] = true;
    };
    Enabled = true;
    MashToEnable = false;
    ActivationUnlocksMouse = false;
    HideOnLostFocus = true;
    PlaceName = "Cmdr";
    Util = module_upvr;
    Events = {};
}, {
    __index = function(arg1, arg2) -- Line 76, Named "__index"
        local var7_upvr = arg1.Dispatcher[arg2]
        if var7_upvr and type(var7_upvr) == "function" then
            return function(arg1_2, ...) -- Line 79
                return var7_upvr(arg1.Dispatcher, ...)
            end
        end
    end;
})
setmetatable_result1_upvw.Registry = require(Shared.Registry)(setmetatable_result1_upvw)
setmetatable_result1_upvw.Dispatcher = require(Shared.Dispatcher)(setmetatable_result1_upvw)
local var10_upvr = require(script.CmdrInterface)(setmetatable_result1_upvw)
function setmetatable_result1_upvw.SetActivationKeys(arg1, arg2) -- Line 97
    arg1.ActivationKeys = module_upvr.MakeDictionary(arg2)
end
function setmetatable_result1_upvw.SetPlaceName(arg1, arg2) -- Line 106
    arg1.PlaceName = arg2
    var10_upvr.Window:UpdateLabel()
end
function setmetatable_result1_upvw.SetEnabled(arg1, arg2) -- Line 116
    arg1.Enabled = arg2
end
function setmetatable_result1_upvw.SetActivationUnlocksMouse(arg1, arg2) -- Line 125
    arg1.ActivationUnlocksMouse = arg2
end
function setmetatable_result1_upvw.Show(arg1) -- Line 134
    if not arg1.Enabled then
    else
        var10_upvr.Window:Show()
    end
end
function setmetatable_result1_upvw.Hide(arg1) -- Line 147
    var10_upvr.Window:Hide()
end
function setmetatable_result1_upvw.Toggle(arg1) -- Line 156
    if not arg1.Enabled then
        arg1:Hide()
    else
        var10_upvr.Window:SetVisible(not var10_upvr.Window:IsVisible())
    end
end
function setmetatable_result1_upvw.SetMashToEnable(arg1, arg2) -- Line 172
    arg1.MashToEnable = arg2
    if arg2 then
        arg1:SetEnabled(false)
    end
end
function setmetatable_result1_upvw.SetHideOnLostFocus(arg1, arg2) -- Line 186
    arg1.HideOnLostFocus = arg2
end
function setmetatable_result1_upvw.HandleEvent(arg1, arg2, arg3) -- Line 195
    arg1.Events[arg2] = arg3
end
if RunService:IsServer() == false then
    task.delay(1, function() -- Line 203
        setmetatable_result1_upvw.Registry:RegisterTypesIn(script:WaitForChild("Types"))
        setmetatable_result1_upvw.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
    end)
end
setmetatable_result1_upvw.RemoteEvent.OnClientEvent:Connect(function(arg1, ...) -- Line 210
    if setmetatable_result1_upvw.Events[arg1] then
        setmetatable_result1_upvw.Events[arg1](...)
    end
end)
require(script.DefaultEventHandlers)(setmetatable_result1_upvw)
return setmetatable_result1_upvw