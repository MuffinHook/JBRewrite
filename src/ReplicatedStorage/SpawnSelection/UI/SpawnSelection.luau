local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local MinimapUtils = require(ReplicatedStorage.App.UI.MinimapUtils)
local Minimap = require(ReplicatedStorage.App.UI.Minimap)
require(ReplicatedStorage.Std.Debug.table2Lua)
local v1 = Roact.PureComponent:extend("SpawnSelection")
v1.defaultProps = {
	visible = true,
	mapScale = 1,
	showToggleButton = false,
	bornAt = workspace:GetServerTimeNow(),
	duration = 10
}
function v1.init(p1) --[[ Line: 22 | Upvalues: Maid (copy), Roact (copy) ]]
	p1.maid = Maid.new()
	if p1.props.containerSize then
		local updateContainerSize = p1.props.updateContainerSize
		p1.containerSize = p1.props.containerSize
		p1.updateContainerSize = updateContainerSize
	else
		local v1, v2 = Roact.createBinding(Vector2.new(512, 512))
		p1.containerSize = v1
		p1.updateContainerSize = v2
	end
	if p1.props.containerRef then
		p1.containerRef = p1.props.containerRef
	else
		p1.containerRef = Roact.createRef()
	end
	p1:setState({
		remaining = 0
	})
end
function v1.render(p1) --[[ Line: 38 | Upvalues: MinimapUtils (copy), Roact (copy), createElement (copy), Minimap (copy), Dictionary (copy) ]]
	if #p1.props.spawns ~= 0 then
		local t = {}
		for v1, v2 in p1.props.spawns do
			table.insert(t, v2)
		end
		local t2 = {}
		for v6, v7 in t do
			local v3, v4, v5
			local v8 = ("button_%s"):format(v7.title)
			local v9 = nil
			if typeof(v7.position) == "Vector3" then
				local position_2 = v7.position
				v9 = MinimapUtils.worldToScale(position_2.X, position_2.Z, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
			else
				if typeof(v7.position) == "table" and v7.position.map then
					v9 = v7.position:map(function(p12) --[[ Line: 64 | Upvalues: MinimapUtils (ref), p1 (copy) ]]
						return MinimapUtils.worldToScale(p12.X, p12.Z, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
					end)
				end
			end
			local t3 = {
				BackgroundTransparency = 0,
				BorderSizePixel = 0
			}
			t3.BackgroundColor3 = v7.backgroundColor or Color3.new(0.1, 0.1, 0.1)
			t3.AnchorPoint = Vector2.new(0.5, 0.5)
			t3.Position = v9
			t3.ZIndex = 1
			t3.Selectable = true
			t3[Roact.Event.Activated] = function() --[[ Line: 84 | Upvalues: p1 (copy), v7 (copy) ]]
				p1.props.onSpawnPressed(v7)
				if not v7.locked then
					p1.props.hide()
				end
			end
			local v13 = "TextButton"
			t3.Size = p1.containerSize:map(function(p1) --[[ Line: 97 ]]
				return UDim2.new(0, p1.X * 0.06, 0, p1.X * 0.06)
			end)
			t3.Text = ""
			local t4 = {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0.25, 0)
				})
			}
			local v14 = not v7.locked
			if v14 then
				local t5 = {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0)
				}
				v3 = if v7.useParachute then "rbxassetid://11414556860" else "rbxassetid://11414555810"
				t5.Image = v3
				t5.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
				v14 = createElement("ImageLabel", t5)
			end
			t4.Icon = v14
			if v7.locked == true then
				local t5 = {
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0)
				}
				v4 = if v7.locked then "rbxassetid://8715708455" else "rbxassetid://8715708824"
				t5.Image = v4
				t5.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
				t5.ZIndex = 3
				v5 = createElement("ImageLabel", t5)
			else
				v5 = false
			end
			t4.Lock = v5
			t4.NumPlayers = v7.numEnemies and createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0, 0, 1, 0),
				Text = v7.numEnemies:map(function(p1) --[[ Line: 124 ]]
					return "Enemies: " .. tostring(p1)
				end),
				Font = Enum.Font.Bangers,
				TextSize = 14,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextStrokeTransparency = 0.5,
				TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255),
				ZIndex = 2
			})
			assert(v13, "missing classname for button")
			t2[v8] = createElement(v13, t3, t4)
		end
		local v22 = Dictionary.merge(p1.props, {
			containerSize = p1.containerSize,
			updateContainerSize = p1.updateContainerSize,
			containerRef = p1.containerRef,
			mapImageColor3 = p1.mapImageColor3,
			pointsChildren = t2,
			onButtonPress = p1.props.onButtonPress
		})
		local t3 = {}
		local t4 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0.05, 0),
			Position = UDim2.new(0, 0, 1, 4)
		}
		local t5 = {}
		local t6 = {
			BackgroundColor3 = p1.props.color,
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 1
		}
		local t7 = {}
		local t8 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 0.7, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		t8.Text = "Auto respawn in " .. tostring(p1.state.remaining) .. "..."
		t8.Font = Enum.Font.LuckiestGuy
		t8.LineHeight = 0.7
		t8.TextScaled = true
		t8.TextXAlignment = Enum.TextXAlignment.Center
		t8.TextYAlignment = Enum.TextYAlignment.Center
		t8.TextColor3 = Color3.fromRGB(255, 255, 255)
		t8.ZIndex = 10
		t7.Title = createElement("TextLabel", t8)
		t7.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
		t5.Waypoint = createElement("Frame", t6, t7)
		t3.Buttons = createElement("Frame", t4, t5)
		return createElement(Minimap, v22, t3)
	end
end
function v1._startTimer(p1) --[[ Line: 183 | Upvalues: Interval (copy) ]]
	local function update() --[[ Line: 184 | Upvalues: p1 (copy) ]]
		local v1 = workspace:GetServerTimeNow() - p1.props.bornAt
		if p1.props.duration <= v1 then
			p1.maid.countdown = nil
		end
		local t = {}
		t.remaining = math.max(0, (math.ceil(p1.props.duration - v1)))
		p1:setState(t)
	end
	update()
	p1.maid.countdown = Interval.every(1):Connect(update)
end
function v1.didUpdate(p1, p2, p3) --[[ Line: 197 ]]
	if #p1.props.spawns ~= #p2.spawns then
		p1:_startTimer()
	end
end
function v1.didMount(p1) --[[ Line: 202 ]]
	if #p1.props.spawns > 0 then
		p1:_startTimer()
	end
end
function v1.willUnmount(p1) --[[ Line: 207 ]]
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2) --[[ Line: 210 ]]
	return {
		spawns = p1.minimapSpawns,
		bornAt = p1.spawnSelectionReceivedAt,
		points = p1.minimapPoints,
		circles = p1.minimapCircles
	}
end, function(p1) --[[ Line: 217 ]]
	return {
		hide = function() --[[ Name: hide | Line: 219 | Upvalues: p1 (copy) ]]
			p1({
				type = "minimapSetSpawns",
				spawns = {}
			})
		end
	}
end)(v1)