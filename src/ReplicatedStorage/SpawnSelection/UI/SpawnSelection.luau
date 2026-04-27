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
function SpawnSelectionComponent._startTimer(self)
	local function update()
		local elapsedTime = workspace:GetServerTimeNow() - self.props.bornAt
		if self.props.duration <= elapsedTime then
			self.maid.countdown = nil
		end
		local stateUpdate = {}
		stateUpdate.remaining = math.max(0, (math.ceil(self.props.duration - elapsedTime)))
		self:setState(stateUpdate)
	end
	update()
	self.maid.countdown = Interval.every(1):Connect(update)
end
function SpawnSelectionComponent.didUpdate(self, prevProps, prevState)
	if #self.props.spawns ~= #prevProps.spawns then
		self:_startTimer()
	end
end
function SpawnSelectionComponent.didMount(self)
	if #self.props.spawns > 0 then
		self:_startTimer()
	end
end
function SpawnSelectionComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, dispatch)
	return {
		spawns = state.minimapSpawns,
		bornAt = state.spawnSelectionReceivedAt,
		points = state.minimapPoints,
		circles = state.minimapCircles
	}
end, function(dispatch)
	return {
		hide = function()
			dispatch({
				type = "minimapSetSpawns",
				spawns = {}
			})
		end
	}
end)(SpawnSelectionComponent)
