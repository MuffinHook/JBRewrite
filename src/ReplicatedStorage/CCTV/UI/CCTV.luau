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
local function wipeTags(p1)
	for i, v in ipairs((CollectionService:GetTags(p1))) do
		CollectionService:RemoveTag(p1, v)
	end
end
local function wipeTagsRecursively(p1)
	wipeTags(p1)
	for i, v in ipairs(p1:GetDescendants()) do
		wipeTags(v)
	end
end
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2.character = p1
	t2._maid = Maid.new()
	t2.onScreen = false
	t2.lastOnScreenChanged = 0
	local Model = Instance.new("Model")
	local t3 = {}
	local function shouldCopy(p1)
		return (p1:IsA("BasePart") or (p1:IsA("Shirt") or (p1:IsA("Pants") or (p1:IsA("CharacterMesh") or (p1:IsA("WrapTarget") or (p1:IsA("Decal") or (p1:IsA("Accessory") or p1:IsA("Humanoid")))))))) and true or false
	end
	local function v2(p1, p2)
		local v1 = p1:Clone()
		if v1 then
			if p1:IsA("CharacterAppearance") then
				local v22 = p2:FindFirstChild(v1.Name)
				if v22 then
					t3[v22] = nil
					v22:Destroy()
				end
			end
			v1:ClearAllChildren()
			v1.Parent = p2
			wipeTags(v1)
			if v1:IsA("BasePart") then
				v1.Anchored = true
				t3[v1] = p1
			elseif v1:IsA("Humanoid") then
				v1.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			end
			for i, v in ipairs(p1:GetChildren()) do
				v2(v, v1)
			end
			return v1
		end
	end
	local function handleObj(p1)
		if shouldCopy(p1) then
			v2(p1, Model)
		end
	end
	for i, v in ipairs(p1:GetChildren()) do
		if shouldCopy(v) then
			v2(v, Model)
		end
	end
	t2._maid:GiveTask(p1.ChildAdded:Connect(handleObj))
	t2.characterClone = Model
	t2.cloneRef = t3
	t2._maid:GiveTask(Model)
	return t2
end
function t.Update(p1)
	for k, v in pairs(p1.cloneRef) do
		k.CFrame = v.CFrame
	end
end
function t.Destroy(p1)
	p1._maid:Destroy()
	setmetatable(p1, nil)
end
local v1 = Roact.PureComponent:extend("CCTV")
v1.defaultProps = {
	active = true
}
function v1.init(p1)
	p1.cameraRef = Roact.createRef()
	p1.viewportRef = Roact.createRef()
	p1.fuzzRef = Roact.createRef()
	p1._maid = Maid.new()
end
function v1.render(p1)
	local t = {
		BorderSizePixel = 0
	}
	t.BackgroundTransparency = if p1.props.disabled then 0 else 1
	t.BackgroundColor3 = Color3.new(102/255, 0/255, 0/255)
	t.Size = p1.props.size
	t.Position = p1.props.position
	t.LayoutOrder = p1.props.layoutOrder
	t.AnchorPoint = Vector2.new(0.5, 0.5)
	t.ClipsDescendants = true
	local t2 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0.015625, 0)
		}),
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(255/255, 0/255, 0/255),
			Thickness = 2,
			Enabled = p1.props.active
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = p1.props.aspectRatio
		}),
		ViewportFrame = createElement("ViewportFrame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			CurrentCamera = p1.cameraRef,
			ZIndex = 1,
			Visible = not p1.props.disabled,
			[Roact.Ref] = p1.viewportRef
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.015625, 0)
			}),
			Camera = createElement("Camera", {
				FieldOfView = p1.props.fieldOfView,
				CFrame = p1.props.cameraCFrame,
				[Roact.Ref] = p1.cameraRef
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
			[Roact.Ref] = p1.fuzzRef
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.015625, 0)
			})
		})
	}
	local t3 = {
		BackgroundTransparency = p1.props.flash,
		BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
		Size = UDim2.new(1, 1, 1),
		ZIndex = 20
	}
	t3.Visible = p1.props.flash ~= nil
	t2.Flash = createElement("Frame", t3)
	return createElement("Frame", t, t2)
end
function v1._clear(p1)
	for i, v in ipairs(p1.viewportRef:getValue():GetChildren()) do
		if not (v:IsA("UICorner") or v:IsA("Camera")) then
			v:Destroy()
		end
	end
end
function v1._redraw(p1)
	p1:_clear()
	local v1 = Maid.new()
	p1._maid.canvasMaid = v1
	local v2 = p1.viewportRef:getValue()
	local distance = p1.props.distance
	local cameraCFrame = p1.props.cameraCFrame
	local v5 = 2 * distance * math.tan((math.rad(p1.props.fieldOfView / 2)))
	local v7 = Vector3.new(v5 * p1.props.aspectRatio, v5, distance)
	local t2 = { workspace:FindFirstChild("Items") }
	for i, v in ipairs(Players:GetPlayers()) do
		if v.Character then
			table.insert(t2, v.Character)
		end
	end
	local v8 = OverlapParams.new()
	v8.FilterType = Enum.RaycastFilterType.Blacklist
	v8.FilterDescendantsInstances = t2
	for i, v in ipairs((workspace:GetPartBoundsInBox(cameraCFrame * CFrame.new(0, 0, -v7.z * 0.5), v7, v8))) do
		local v10 = v:Clone()
		if v10 then
			wipeTags(v10)
			for i2, v11 in ipairs(v10:GetDescendants()) do
				wipeTags(v11)
			end
			v10.Parent = v2
		end
	end
	local v11 = ManifestBinder.new("Character", {
		HumanoidRootPart = "HumanoidRootPart"
	}, function(p1)
		return BaseObject.new(p1)
	end)
	v11:Start()
	local t3 = {}
	local function onCharacterAdded(p1)
		local v1 = t.new(p1)
		t3[p1] = v1
		v1.characterClone.Parent = v2
	end
	local function onCharacterRemoving(p1)
		local v1 = t3[p1]
		if v1 then
			v1:Destroy()
		end
		t3[p1] = nil
	end
	for v12, v13 in v11:GetAll() do
		local obj = v13.obj
		local v14 = t.new(obj)
		t3[obj] = v14
		v14.characterClone.Parent = v2
	end
	v11:GetClassAddedSignal():Connect(function(p1)
		local obj = p1.obj
		local v1 = t.new(obj)
		t3[obj] = v1
		v1.characterClone.Parent = v2
	end)
	v11:GetClassRemovingSignal():Connect(function(p1)
		local obj = p1.obj
		local v1 = t3[obj]
		if v1 then
			v1:Destroy()
		end
		t3[obj] = nil
	end)
	v1:GiveTask(function()
		for v1, v2 in t3 do
			v2:Destroy()
		end
		table.clear(t3)
	end)
	v1:GiveTask(Interval.every(0.1):Connect(function()
		local v1 = os.clock()
		for v3, v4 in t3 do
			local v2
			local PrimaryPart = v4.character.PrimaryPart
			if PrimaryPart then
				local v5 = PrimaryPart.Position - cameraCFrame.p
				local v6 = v5.Unit:Dot(cameraCFrame.LookVector)
				v2 = if v5.Magnitude < p1.props.distance then math.cos((math.rad(p1.props.aspectRatio * p1.props.fieldOfView / 2))) < v6 else false
				if v2 ~= v4.onScreen then
					v4.onScreen = v2
					v4.lastOnScreenChanged = v1
					if v2 and p1.props.onCharacterEnter then
						p1.props.onCharacterEnter(v4.character)
					end
				end
			end
			if v4.onScreen or v1 - v4.lastOnScreenChanged < 1 then
				v4:Update()
			end
		end
	end))
	local v15 = p1.fuzzRef:getValue()
	local v16 = math.random() * 512
	v1:GiveTask(RunService.Heartbeat:Connect(function()
		v15.Position = UDim2.new(0.5, 0, math.cos(os.clock() * 512 + v16) * 0.05 + 0.5, 0)
	end))
end
function v1.didUpdate(p1, p2)
	if (p1.props.cameraCFrame.p - p2.cameraCFrame.p).Magnitude > 0.1 then
		p1:_redraw()
	end
end
function v1.didMount(p1)
	p1:_redraw()
end
function v1.willUnmount(p1)
	p1._maid:DoCleaning()
end
return v1