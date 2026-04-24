-- Reviewed by Claude
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local createElement = Roact.createElement
local function wipeTags(instance)
	for i, v in ipairs((CollectionService:GetTags(instance))) do
		CollectionService:RemoveTag(instance, v)
	end
end
local function wipeTagsRecursively(instance)
	wipeTags(instance)
	for i, v in ipairs(instance:GetDescendants()) do
		wipeTags(v)
	end
end
local CharacterCloneManager = {}
CharacterCloneManager.__index = CharacterCloneManager
function CharacterCloneManager.new(character)
	local self = {}
	setmetatable(self, CharacterCloneManager)
	self.character = character
	self._maid = Maid.new()
	self.onScreen = false
	self.lastOnScreenChanged = 0
	local cloneModel = Instance.new("Model")
	local partMappings = {}
	local function shouldCopy(instance)
		return (instance:IsA("BasePart") or (instance:IsA("Shirt") or (instance:IsA("Pants") or (instance:IsA("CharacterMesh") or (instance:IsA("WrapTarget") or (instance:IsA("Decal") or (instance:IsA("Accessory") or instance:IsA("Humanoid")))))))) and true or false
	end
	local function cloneChild(sourceInstance, parentClone)
		local clonedPart = sourceInstance:Clone()
		if clonedPart then
			if sourceInstance:IsA("CharacterAppearance") then
				local existingClone = parentClone:FindFirstChild(clonedPart.Name)
				if existingClone then
					partMappings[existingClone] = nil
					existingClone:Destroy()
				end
			end
			clonedPart:ClearAllChildren()
			clonedPart.Parent = parentClone
			wipeTags(clonedPart)
			if clonedPart:IsA("BasePart") then
				clonedPart.Anchored = true
				partMappings[clonedPart] = sourceInstance
			elseif clonedPart:IsA("Humanoid") then
				clonedPart.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			end
			for i, v in ipairs(sourceInstance:GetChildren()) do
				cloneChild(v, clonedPart)
			end
			return clonedPart
		end
	end
	local function handleObj(instance)
		if shouldCopy(instance) then
			cloneChild(instance, cloneModel)
		end
	end
	for i, v in ipairs(character:GetChildren()) do
		if shouldCopy(v) then
			cloneChild(v, cloneModel)
		end
	end
	self._maid:GiveTask(character.ChildAdded:Connect(handleObj))
	self.characterClone = cloneModel
	self.cloneRef = partMappings
	self._maid:GiveTask(cloneModel)
	return self
end
function CharacterCloneManager.Update(self)
	for k, v in pairs(self.cloneRef) do
		k.CFrame = v.CFrame
	end
end
function CharacterCloneManager.Destroy(self)
	self._maid:Destroy()
	setmetatable(self, nil)
end
local CCTVComponent = Roact.PureComponent:extend("CCTV")
CCTVComponent.defaultProps = {
	active = true
}
function CCTVComponent.init(self)
	self.cameraRef = Roact.createRef()
	self.viewportRef = Roact.createRef()
	self.fuzzRef = Roact.createRef()
	self._maid = Maid.new()
end
function CCTVComponent.render(self)
	local frameProps = {
		BorderSizePixel = 0
	}
	frameProps.BackgroundTransparency = if self.props.disabled then 0 else 1
	frameProps.BackgroundColor3 = Color3.new(102/255, 0/255, 0/255)
	frameProps.Size = self.props.size
	frameProps.Position = self.props.position
	frameProps.LayoutOrder = self.props.layoutOrder
	frameProps.AnchorPoint = Vector2.new(0.5, 0.5)
	frameProps.ClipsDescendants = true
	local childrenProps = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0.015625, 0)
		}),
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(255/255, 0/255, 0/255),
			Thickness = 2,
			Enabled = self.props.active
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = self.props.aspectRatio
		}),
		ViewportFrame = createElement("ViewportFrame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			CurrentCamera = self.cameraRef,
			ZIndex = 1,
			Visible = not self.props.disabled,
			[Roact.Ref] = self.viewportRef
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.015625, 0)
			}),
			Camera = createElement("Camera", {
				FieldOfView = self.props.fieldOfView,
				CFrame = self.props.cameraCFrame,
				[Roact.Ref] = self.cameraRef
			})
		}),
		Fuzz = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://8260530429",
			ImageTransparency = 0.5,
			Size = UDim2.new(1.1, 0, 1.1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 10,
			[Roact.Ref] = self.fuzzRef
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.015625, 0)
			})
		})
	}
	local flashProps = {
		BackgroundTransparency = self.props.flash,
		BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
		Size = UDim2.new(1, 1, 1),
		ZIndex = 20
	}
	flashProps.Visible = self.props.flash ~= nil
	childrenProps.Flash = createElement("Frame", flashProps)
	return createElement("Frame", frameProps, childrenProps)
end
function CCTVComponent._clear(self)
	for i, v in ipairs(self.viewportRef:getValue():GetChildren()) do
		if not (v:IsA("UICorner") or v:IsA("Camera")) then
			v:Destroy()
		end
	end
end
function CCTVComponent._redraw(self)
	self:_clear()
	local canvasMaid = Maid.new()
	self._maid.canvasMaid = canvasMaid
	local viewportFrame = self.viewportRef:getValue()
	local distance = self.props.distance
	local cameraCFrame = self.props.cameraCFrame
	local viewportHeight = 2 * distance * math.tan((math.rad(self.props.fieldOfView / 2)))
	local renderBounds = Vector3.new(viewportHeight * self.props.aspectRatio, viewportHeight, distance)
	local filterList = { workspace:FindFirstChild("Items") }
	for i, v in ipairs(Players:GetPlayers()) do
		if v.Character then
			table.insert(filterList, v.Character)
		end
	end
	local overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Blacklist
	overlapParams.FilterDescendantsInstances = filterList
	for i, v in ipairs((workspace:GetPartBoundsInBox(cameraCFrame * CFrame.new(0, 0, -renderBounds.z * 0.5), renderBounds, overlapParams))) do
		local clonedPart = v:Clone()
		if clonedPart then
			wipeTags(clonedPart)
			for i2, descendant in ipairs(clonedPart:GetDescendants()) do
				wipeTags(descendant)
			end
			clonedPart.Parent = viewportFrame
		end
	end
	local characterBinder = ManifestBinder.new("Character", {
		HumanoidRootPart = "HumanoidRootPart"
	}, function(characterObj)
		return BaseObject.new(characterObj)
	end)
	characterBinder:Start()
	local characterCloneMap = {}
	local function onCharacterAdded(characterObj)
		local cloneManager = CharacterCloneManager.new(characterObj)
		characterCloneMap[characterObj] = cloneManager
		cloneManager.characterClone.Parent = viewportFrame
	end
	local function onCharacterRemoving(characterObj)
		local cloneManager = characterCloneMap[characterObj]
		if cloneManager then
			cloneManager:Destroy()
		end
		characterCloneMap[characterObj] = nil
	end
	for key, boundInstance in characterBinder:GetAll() do
		local obj = boundInstance.obj
		local cloneManager = CharacterCloneManager.new(obj)
		characterCloneMap[obj] = cloneManager
		cloneManager.characterClone.Parent = viewportFrame
	end
	characterBinder:GetClassAddedSignal():Connect(function(boundInstance)
		local obj = boundInstance.obj
		local cloneManager = CharacterCloneManager.new(obj)
		characterCloneMap[obj] = cloneManager
		cloneManager.characterClone.Parent = viewportFrame
	end)
	characterBinder:GetClassRemovingSignal():Connect(function(boundInstance)
		local obj = boundInstance.obj
		local cloneManager = characterCloneMap[obj]
		if cloneManager then
			cloneManager:Destroy()
		end
		characterCloneMap[obj] = nil
	end)
	canvasMaid:GiveTask(function()
		for characterKey, cloneManager in characterCloneMap do
			cloneManager:Destroy()
		end
		table.clear(characterCloneMap)
	end)
	canvasMaid:GiveTask(Interval.every(0.1):Connect(function()
		local currentTime = os.clock()
		for characterKey, cloneManager in characterCloneMap do
			local isVisible
			local primaryPart = cloneManager.character.PrimaryPart
			if primaryPart then
				local viewVector = primaryPart.Position - cameraCFrame.p
				local dotProduct = viewVector.Unit:Dot(cameraCFrame.LookVector)
				isVisible = if viewVector.Magnitude < self.props.distance then math.cos((math.rad(self.props.aspectRatio * self.props.fieldOfView / 2))) < dotProduct else false
				if isVisible ~= cloneManager.onScreen then
					cloneManager.onScreen = isVisible
					cloneManager.lastOnScreenChanged = currentTime
					if isVisible and self.props.onCharacterEnter then
						self.props.onCharacterEnter(cloneManager.character)
					end
				end
			end
			if cloneManager.onScreen or currentTime - cloneManager.lastOnScreenChanged < 1 then
				cloneManager:Update()
			end
		end
	end))
	local fuzzLabel = self.fuzzRef:getValue()
	local fuzzOffset = math.random() * 512
	canvasMaid:GiveTask(RunService.Heartbeat:Connect(function()
		fuzzLabel.Position = UDim2.new(0.5, 0, math.cos(os.clock() * 512 + fuzzOffset) * 0.05 + 0.5, 0)
	end))
end
function CCTVComponent.didUpdate(self, previousProps)
	if (self.props.cameraCFrame.p - previousProps.cameraCFrame.p).Magnitude > 0.1 then
		self:_redraw()
	end
end
function CCTVComponent.didMount(self)
	self:_redraw()
end
function CCTVComponent.willUnmount(self)
	self._maid:DoCleaning()
end
return CCTVComponent