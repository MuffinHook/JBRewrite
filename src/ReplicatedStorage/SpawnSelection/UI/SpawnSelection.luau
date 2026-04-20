local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("SpawnSelection")
any_extend_result1.defaultProps = {
    visible = true;
    mapScale = 1;
    showToggleButton = false;
    bornAt = workspace:GetServerTimeNow();
    duration = 10;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 22
    arg1.maid = Maid_upvr.new()
    if arg1.props.containerSize then
        arg1.containerSize = arg1.props.containerSize
        arg1.updateContainerSize = arg1.props.updateContainerSize
    else
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(Vector2.new(512, 512))
        arg1.containerSize = any_createBinding_result1
        arg1.updateContainerSize = any_createBinding_result2
    end
    if arg1.props.containerRef then
        arg1.containerRef = arg1.props.containerRef
    else
        arg1.containerRef = Roact_upvr.createRef()
    end
    arg1:setState({
        remaining = 0;
    })
end
local MinimapUtils_upvr = require(ReplicatedStorage.App.UI.MinimapUtils)
local createElement_upvr = Roact_upvr.createElement
local Minimap_upvr = require(ReplicatedStorage.App.UI.Minimap)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 38
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if #arg1.props.spawns == 0 then return end
    for _, v in arg1.props.spawns do
        table.insert({}, v)
        local var30
    end
    local tbl_2 = {}
    for _, v_2_upvr in var30 do
        local var32
        if typeof(v_2_upvr.position) == "Vector3" then
            local position = v_2_upvr.position
            var32 = MinimapUtils_upvr.worldToScale(position.X, position.Z, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
        elseif typeof(v_2_upvr.position) == "table" and v_2_upvr.position.map then
            var32 = v_2_upvr.position:map(function(arg1_2) -- Line 64
                return MinimapUtils_upvr.worldToScale(arg1_2.X, arg1_2.Z, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
            end)
        end
        local tbl = {
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
        }
        local backgroundColor = v_2_upvr.backgroundColor
        if not backgroundColor then
            backgroundColor = Color3.new(0.1, 0.1, 0.1)
        end
        tbl.BackgroundColor3 = backgroundColor
        tbl.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl.Position = var32
        tbl.ZIndex = 1
        tbl.Selectable = true
        tbl[Roact_upvr.Event.Activated] = function() -- Line 84
            arg1.props.onSpawnPressed(v_2_upvr)
            if not v_2_upvr.locked then
                arg1.props.hide()
            end
        end
        local var38 = "TextButton"
        tbl.Size = arg1.containerSize:map(function(arg1_3) -- Line 97
            return UDim2.new(0, arg1_3.X * 0.06, 0, arg1_3.X * 0.06)
        end)
        tbl.Text = ""
        local tbl_4 = {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0.25, 0);
            });
        }
        local var42 = not v_2_upvr.locked
        if var42 then
            var42 = createElement_upvr
            local tbl_5 = {
                BackgroundTransparency = 1;
            }
            local udim2_2 = UDim2.new(1, 0, 1, 0)
            tbl_5.Size = udim2_2
            if v_2_upvr.useParachute then
                udim2_2 = "rbxassetid://11414556860"
            else
                udim2_2 = "rbxassetid://11414555810"
            end
            tbl_5.Image = udim2_2
            tbl_5.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
            var42 = var42("ImageLabel", tbl_5)
        end
        tbl_4.Icon = var42
        var42 = false
        local var45 = var42
        if v_2_upvr.locked == true then
            var45 = createElement_upvr
            local tbl_3 = {
                BorderSizePixel = 0;
                BackgroundTransparency = 1;
            }
            local udim2 = UDim2.new(1, 0, 1, 0)
            tbl_3.Size = udim2
            if v_2_upvr.locked then
                udim2 = "rbxassetid://8715708455"
            else
                udim2 = "rbxassetid://8715708824"
            end
            tbl_3.Image = udim2
            tbl_3.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
            tbl_3.ZIndex = 3
            var45 = var45("ImageLabel", tbl_3)
        end
        tbl_4.Lock = var45
        var45 = v_2_upvr.numEnemies
        local var48 = var45
        if var48 then
            var48 = createElement_upvr
            var48 = var48("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0, 0, 1, 0);
                Text = v_2_upvr.numEnemies:map(function(arg1_4) -- Line 124
                    return "Enemies: "..tostring(arg1_4)
                end);
                Font = Enum.Font.Bangers;
                TextSize = 14;
                TextColor3 = Color3.new(1, 1, 1);
                TextStrokeTransparency = 0.5;
                TextStrokeColor3 = Color3.new(0, 0, 0);
                ZIndex = 2;
            })
        end
        tbl_4.NumPlayers = var48
        assert(var38, "missing classname for button")
        tbl_2["button_%s":format(v_2_upvr.title)] = createElement_upvr(var38, tbl, tbl_4)
    end
    return createElement_upvr(Minimap_upvr, Dictionary_upvr.merge(arg1.props, {
        containerSize = arg1.containerSize;
        updateContainerSize = arg1.updateContainerSize;
        containerRef = arg1.containerRef;
        mapImageColor3 = arg1.mapImageColor3;
        pointsChildren = tbl_2;
        onButtonPress = arg1.props.onButtonPress;
    }), {
        Buttons = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0.05, 0);
            Position = UDim2.new(0, 0, 1, 4);
        }, {
            Waypoint = createElement_upvr("Frame", {
                BackgroundColor3 = arg1.props.color;
                Size = UDim2.new(1, 0, 1, 0);
                LayoutOrder = 1;
            }, {
                Title = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    Size = UDim2.new(0.9, 0, 0.7, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = "Auto respawn in "..tostring(arg1.state.remaining).."...";
                    Font = Enum.Font.LuckiestGuy;
                    LineHeight = 0.7;
                    TextScaled = true;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    TextYAlignment = Enum.TextYAlignment.Center;
                    TextColor3 = Color3.fromRGB(255, 255, 255);
                    ZIndex = 10;
                });
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
            });
        });
    })
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1._startTimer(arg1) -- Line 183
    local function update() -- Line 184
        local var60 = workspace:GetServerTimeNow() - arg1.props.bornAt
        if arg1.props.duration <= var60 then
            arg1.maid.countdown = nil
        end
        arg1:setState({
            remaining = math.max(0, math.ceil(arg1.props.duration - var60));
        })
    end
    update()
    arg1.maid.countdown = Interval_upvr.every(1):Connect(update)
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 197
    if #arg1.props.spawns ~= #arg2.spawns then
        arg1:_startTimer()
    end
end
function any_extend_result1.didMount(arg1) -- Line 202
    if 0 < #arg1.props.spawns then
        arg1:_startTimer()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 207
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 210
    return {
        spawns = arg1.minimapSpawns;
        bornAt = arg1.spawnSelectionReceivedAt;
        points = arg1.minimapPoints;
        circles = arg1.minimapCircles;
    }
end, function(arg1) -- Line 217
    return {
        hide = function() -- Line 219, Named "hide"
            arg1({
                type = "minimapSetSpawns";
                spawns = {};
            })
        end;
    }
end)(any_extend_result1)