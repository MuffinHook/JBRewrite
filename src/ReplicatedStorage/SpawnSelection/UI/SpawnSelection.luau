-- Reviewed by Claude
-- variables reassigned
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
local SpawnSelectionComponent = Roact.PureComponent:extend("SpawnSelection")
SpawnSelectionComponent.defaultProps = {
	visible = true,
	mapScale = 1,
	showToggleButton = false,
	bornAt = workspace:GetServerTimeNow(),
	duration = 10
}
function SpawnSelectionComponent.init(self)
	self.maid = Maid.new()
	if self.props.containerSize then
		local updateContainerSize = self.props.updateContainerSize
		self.containerSize = self.props.containerSize
		self.updateContainerSize = updateContainerSize
	else
		local containerSizeBinding, updateContainerSize = Roact.createBinding(Vector2.new(512, 512))
		self.containerSize = containerSizeBinding
		self.updateContainerSize = updateContainerSize
	end
	if self.props.containerRef then
		self.containerRef = self.props.containerRef
	else
		self.containerRef = Roact.createRef()
	end
	self:setState({
		remaining = 0
	})
end
function SpawnSelectionComponent.render(self)
	if #self.props.spawns ~= 0 then
		local spawnsList = {}
		for index, spawn in self.props.spawns do
			table.insert(spawnsList, spawn)
		end
		local pointsChildren = {}
		for spawnIndex, spawnData in spawnsList do
			local iconAsset, lockAsset, lockElement
			local buttonId = ("button_%s"):format(spawnData.title)
			local spawnScaledPos = nil
			if typeof(spawnData.position) == "Vector3" then
				local position_2 = spawnData.position
				spawnScaledPos = MinimapUtils.worldToScale(position_2.X, position_2.Z, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapWorldWidth, self.props.mapWorldHeight)
			else
				if typeof(spawnData.position) == "table" and spawnData.position.map then
					spawnScaledPos = spawnData.position:map(function(mapPos)
						return MinimapUtils.worldToScale(mapPos.X, mapPos.Z, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapWorldWidth, self.props.mapWorldHeight)
					end)
				end
			end
			local buttonProps = {
				BackgroundTransparency = 0,
				BorderSizePixel = 0
			}
			buttonProps.BackgroundColor3 = spawnData.backgroundColor or Color3.new(0.1, 0.1, 0.1)
			buttonProps.AnchorPoint = Vector2.new(0.5, 0.5)
			buttonProps.Position = spawnScaledPos
			buttonProps.ZIndex = 1
			buttonProps.Selectable = true
			buttonProps[Roact.Event.Activated] = function()
				self.props.onSpawnPressed(spawnData)
				if not spawnData.locked then
					self.props.hide()
				end
			end
			local buttonClassName = "TextButton"
			buttonProps.Size = self.containerSize:map(function(containerSize)
				return UDim2.new(0, containerSize.X * 0.06, 0, containerSize.X * 0.06)
			end)
			buttonProps.Text = ""
			local buttonChildren = {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0.25, 0)
				})
			}
			local isUnlocked = not spawnData.locked
			if isUnlocked then
				local iconProps = {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0)
				}
				iconAsset = if spawnData.useParachute then "rbxassetid://11414556860" else "rbxassetid://11414555810"
				iconProps.Image = iconAsset
				iconProps.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
				isUnlocked = createElement("ImageLabel", iconProps)
			end
			buttonChildren.Icon = isUnlocked
			if spawnData.locked == true then
				local lockProps = {
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0)
				}
				lockAsset = if spawnData.locked then "rbxassetid://8715708455" else "rbxassetid://8715708824"
				lockProps.Image = lockAsset
				lockProps.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
				lockProps.ZIndex = 3
				lockElement = createElement("ImageLabel", lockProps)
			else
				lockElement = false
			end
			buttonChildren.Lock = lockElement
			buttonChildren.NumPlayers = spawnData.numEnemies and createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0, 0, 1, 0),
				Text = spawnData.numEnemies:map(function(enemyCount)
					return "Enemies: " .. tostring(enemyCount)
				end),
				Font = Enum.Font.Bangers,
				TextSize = 14,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextStrokeTransparency = 0.5,
				TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255),
				ZIndex = 2
			})
			assert(buttonClassName, "missing classname for button")
			pointsChildren[buttonId] = createElement(buttonClassName, buttonProps, buttonChildren)
		end
		local minimapProps = Dictionary.merge(self.props, {
			containerSize = self.containerSize,
			updateContainerSize = self.updateContainerSize,
			containerRef = self.containerRef,
			mapImageColor3 = self.mapImageColor3,
			pointsChildren = pointsChildren,
			onButtonPress = self.props.onButtonPress
		})
		local minimapChildren = {}
		local timerFrameProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0.05, 0),
			Position = UDim2.new(0, 0, 1, 4)
		}
		local timerFrameChildren = {}
		local waypointProps = {
			BackgroundColor3 = self.props.color,
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 1
		}
		local waypointChildren = {}
		local timerTextProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 0.7, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		timerTextProps.Text = "Auto respawn in " .. tostring(self.state.remaining) .. "..."
		timerTextProps.Font = Enum.Font.LuckiestGuy
		timerTextProps.LineHeight = 0.7
		timerTextProps.TextScaled = true
		timerTextProps.TextXAlignment = Enum.TextXAlignment.Center
		timerTextProps.TextYAlignment = Enum.TextYAlignment.Center
		timerTextProps.TextColor3 = Color3.fromRGB(255, 255, 255)
		timerTextProps.ZIndex = 10
		waypointChildren.Title = createElement("TextLabel", timerTextProps)
		waypointChildren.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
		timerFrameChildren.Waypoint = createElement("Frame", waypointProps, waypointChildren)
		minimapChildren.Buttons = createElement("Frame", timerFrameProps, timerFrameChildren)
		return createElement(Minimap, minimapProps, minimapChildren)
	end
end
function v1._startTimer(p1)
	local function update()
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
function v1.didUpdate(p1, p2, p3)
	if #p1.props.spawns ~= #p2.spawns then
		p1:_startTimer()
	end
end
function v1.didMount(p1)
	if #p1.props.spawns > 0 then
		p1:_startTimer()
	end
end
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2)
	return {
		spawns = p1.minimapSpawns,
		bornAt = p1.spawnSelectionReceivedAt,
		points = p1.minimapPoints,
		circles = p1.minimapCircles
	}
end, function(p1)
	return {
		hide = function()
			p1({
				type = "minimapSetSpawns",
				spawns = {}
			})
		end
	}
end)(v1)
