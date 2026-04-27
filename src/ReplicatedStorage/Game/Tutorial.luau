local TreeClass = {
	ClassName = "Tree"
}
TreeClass.__index = TreeClass
function TreeClass.new()
	local treeNode = setmetatable({}, TreeClass)
	treeNode.Root = true
	treeNode.Depth = 1
	treeNode.Branches = {}
	treeNode.Leaf = nil
	return treeNode
end
function TreeClass.AddBranch(parentNode, childNode)
	assert(childNode.ClassName == TreeClass.ClassName)
	assert(childNode.Root)
	childNode.Root = false
	childNode.Depth = parentNode.Depth + 1
	table.insert(parentNode.Branches, childNode)
end
function TreeClass.Complete(node)
	node.State = 4
	for i = 1, #node.Branches do
		node.Branches[i].State = 2
	end
end
local tutorialTree = {
	Welcome = TreeClass.new()
}
tutorialTree.Welcome.Leaf = {
	Title = "Welcome to Jailbreak!",
	Body = "This tutorial will teach you the basics of Jailbreak.",
	Duration = 15
}
tutorialTree.Escape = TreeClass.new()
tutorialTree.Escape.Leaf = {
	Title = "Getting Started",
	Body = "Figure out how to escape the prison.",
	Duration = 15,
	Team = 2
}
tutorialTree.GetCar = TreeClass.new()
tutorialTree.GetCar.Leaf = {
	Title = "Life of a Criminal",
	Body = "You escaped! Look for a car to drive...",
	Duration = 15,
	Team = 2
}
tutorialTree.GetCarDone = TreeClass.new()
tutorialTree.GetCarDone.Leaf = {
	Title = "Driving",
	Body = "This is your starter car. You can upgrade it, and buy other cars!",
	Duration = 15,
	Team = 2,
	OneShot = true
}
tutorialTree.BankRobbery = TreeClass.new()
tutorialTree.BankRobbery.Leaf = {
	Title = "Robbery",
	Body = "Go to the bank in the city to rob it!",
	Duration = 15,
	Team = 2
}
tutorialTree.BankRobberyDone = TreeClass.new()
tutorialTree.BankRobberyDone.Leaf = {
	Title = "Robbery Complete",
	Body = "Earn money by robbing the bank, jewelry store, train, museum, and more!",
	Duration = 15,
	Team = 2,
	OneShot = true
}
tutorialTree.CustomizeCar = TreeClass.new()
tutorialTree.CustomizeCar.Leaf = {
	Title = "Customize Your Car",
	Body = "Go to the garage in the city to customize your car.",
	Duration = 15,
	Team = 2
}
tutorialTree.Welcome:AddBranch(tutorialTree.Escape)
tutorialTree.Escape:AddBranch(tutorialTree.GetCar)
tutorialTree.GetCar:AddBranch(tutorialTree.GetCarDone)
tutorialTree.GetCar:AddBranch(tutorialTree.BankRobbery)
tutorialTree.BankRobbery:AddBranch(tutorialTree.BankRobberyDone)
tutorialTree.GetCar:AddBranch(tutorialTree.CustomizeCar)
local function CompleteTree(node)
	node.State = 4
	for i = 1, #node.Branches do
		node.Branches[i].State = 2
	end
end
local function findNextActiveNode(node)
	assert(node.State == 4 or node.State == 2)
	if node.State == 2 then
		return node
	else
		if node.State == 4 then
			for i = 1, #node.Branches do
				local branchNode = node.Branches[i]
				if branchNode.State == 2 and branchNode.Leaf.OneShot then
					return branchNode
				end
			end
		end
		local maxDepth = 0
		local deepestNode = nil
		for j = 1, #node.Branches do
			local branchNode = node.Branches[j]
			if branchNode.State == 4 or branchNode.State == 2 then
				local foundNode = findNextActiveNode(branchNode)
				if foundNode then
					local Depth = foundNode.Depth
					if maxDepth < Depth then
						maxDepth = Depth
						deepestNode = foundNode
					end
				end
			end
		end
		return deepestNode
	end
end
local screenGui = nil
local messageQueue = {}
local isQueueProcessing = false
local function ProcessMessage(messageData)
	screenGui.Message.Inner.Title.Text = messageData.Title
	screenGui.Message.Inner.Body.Text = messageData.Body
end
local function ProcessQueue()
	isQueueProcessing = true
	if screenGui.Icon.Visible then
		screenGui.Icon:TweenPosition(UDim2.new(1, 0, 1, -266), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function()
			screenGui.Icon.Visible = false
		end)
		wait(0.5)
	else
		screenGui.Icon.Position = UDim2.new(1, 0, 1, -266)
	end
	screenGui.Message.Visible = true
	screenGui.Message:TweenPosition(UDim2.new(1, -200, 1, -300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	while #messageQueue > 0 do
		local messageData = table.remove(messageQueue, 1)
		screenGui.Message.Inner.Title.Text = messageData.Title
		screenGui.Message.Inner.Body.Text = messageData.Body
		wait(messageData.Duration)
	end
	screenGui.Message:TweenPosition(UDim2.new(1, 0, 1, -300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function()
		screenGui.Message.Visible = false
	end)
	wait(0.5)
	screenGui.Icon.Visible = true
	screenGui.Icon:TweenPosition(UDim2.new(1, -40, 1, -266), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	isQueueProcessing = false
end
local function ShowMessage(messageData)
	table.insert(messageQueue, messageData)
	if not isQueueProcessing then
		isQueueProcessing = true
		spawn(ProcessQueue)
	end
end
local function ShowNextMessage()
	local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
	table.insert(messageQueue, Leaf)
	if not isQueueProcessing then
		isQueueProcessing = true
		spawn(ProcessQueue)
	end
end
local function Complete(node)
	node:Complete()
	local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
	table.insert(messageQueue, Leaf)
	if not isQueueProcessing then
		isQueueProcessing = true
		spawn(ProcessQueue)
	end
end
return {
	Init = function(config)
		local _ = config.Event
		screenGui = config.GetScreenGui("Tutorial")
		table.insert(messageQueue, tutorialTree.Welcome.Leaf)
		if not isQueueProcessing then
			isQueueProcessing = true
			spawn(ProcessQueue)
		end
		tutorialTree.Welcome:Complete()
		local Leaf_2 = findNextActiveNode(tutorialTree.Welcome).Leaf
		table.insert(messageQueue, Leaf_2)
		if not isQueueProcessing then
			isQueueProcessing = true
			spawn(ProcessQueue)
		end
		local lastClickTime = tick()
		local function IconInputBegan(inputEvent)
			if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 then
				local currentTime = tick()
				if currentTime - lastClickTime < 0.5 then
					return false
				end
				lastClickTime = currentTime
				local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
				table.insert(messageQueue, Leaf)
				if not isQueueProcessing then
					isQueueProcessing = true
					spawn(ProcessQueue)
				end
			end
		end
		local function IconMouseEnter(inputEvent)
			local currentTime = tick()
			if currentTime - lastClickTime < 0.5 then
				return false
			end
			lastClickTime = currentTime
			local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
			table.insert(messageQueue, Leaf)
			if not isQueueProcessing then
				isQueueProcessing = true
				spawn(ProcessQueue)
			end
		end
		screenGui.Icon.InputBegan:Connect(IconInputBegan)
		screenGui.Icon.MouseEnter:Connect(IconMouseEnter)
		function config.em.nvyrkw5r(stateTable, shouldSkip)
			for stateName, v2 in next, stateTable do
				local tutorialNode = tutorialTree[stateName]
				if tutorialNode and tutorialNode.State ~= 4 then
					if shouldSkip then
						TreeClass:Complete()
					else
						TreeClass:Complete()
						local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
						table.insert(messageQueue, Leaf)
						if not isQueueProcessing then
							isQueueProcessing = true
							spawn(ProcessQueue)
						end
					end
				end
			end
		end
	end
}
