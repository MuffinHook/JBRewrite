local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 5
    local tbl = {
        onTeamSelected = function(arg1_2) -- Line 10, Named "onTeamSelected"
            print("team selected!", arg1_2)
        end;
    }
    local tbl_4 = {}
    local tbl_2 = {}
    local function onClicked() -- Line 15
        print("CLICKED")
    end
    tbl_2.onClicked = onClicked
    tbl_2.text = "OG JAILBREAK"
    tbl_2.textColor = Color3.fromHex("e88839")
    local tbl_3 = {}
    local function onClicked() -- Line 22
        print("CLICKED")
    end
    tbl_3.onClicked = onClicked
    tbl_3.text = "VOICECHAT SERVER"
    tbl_4[1] = tbl_2
    tbl_4[2] = tbl_3
    tbl_4[3] = {
        onClicked = function() -- Line 28, Named "onClicked"
            print("CLICKED")
        end;
        text = "TRADE WORLD";
    }
    tbl.serverButtons = tbl_4
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr(require(script.Parent.TeamSelect), tbl), arg1)
    return function() -- Line 37
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end