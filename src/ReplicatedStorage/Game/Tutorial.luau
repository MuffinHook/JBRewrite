-- Reviewed by Claude
-- variables reassigned
local TreeClass = {
	ClassName = "Tree"
}
TreeClass.__index = TreeClass
function TreeClass.new()
	local v2 = setmetatable({}, TreeClass)
	v2.Root = true
	v2.Depth = 1
	v2.Branches = {}
	v2.Leaf = nil
	return v2
end
function TreeClass.AddBranch(p1, p2)
	assert(p2.ClassName == TreeClass.ClassName)
	assert(p2.Root)
	p2.Root = false
	p2.Depth = p1.Depth + 1
	table.insert(p1.Branches, p2)
end
function TreeClass.Complete(p1)
	p1.State = 4
	for i = 1, #p1.Branches do
		p1.Branches[i].State = 2
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
local function CompleteTree(p1)
	p1.State = 4
	for i = 1, #p1.Branches do
		p1.Branches[i].State = 2
	end
end
local function findNextActiveNode(p1)
	assert(p1.State == 4 or p1.State == 2)
	if p1.State == 2 then
		return p1
	else
		if p1.State == 4 then
			for i = 1, #p1.Branches do
				local v2 = p1.Branches[i]
				if v2.State == 2 and v2.Leaf.OneShot then
					return v2
				end
			end
		end
		local v3 = 0
		local v4 = nil
		for j = 1, #p1.Branches do
			local v5 = p1.Branches[j]
			if v5.State == 4 or v5.State == 2 then
				local v6 = findNextActiveNode(v5)
				if v6 then
					local Depth = v6.Depth
					if v3 < Depth then
						v3 = Depth
						v4 = v6
					end
				end
			end
		end
		return v4
	end
end
local v2 = nil
local t3 = {}
local isQueueProcessing = false
local function ProcessMessage(p1)
	v2.Message.Inner.Title.Text = p1.Title
	v2.Message.Inner.Body.Text = p1.Body
end
local function ProcessQueue()
	isQueueProcessing = true
	if v2.Icon.Visible then
		v2.Icon:TweenPosition(UDim2.new(1, 0, 1, -266), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function()
			v2.Icon.Visible = false
		end)
		wait(0.5)
	else
		v2.Icon.Position = UDim2.new(1, 0, 1, -266)
	end
	v2.Message.Visible = true
	v2.Message:TweenPosition(UDim2.new(1, -200, 1, -300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	while #t3 > 0 do
		local v1 = table.remove(t3, 1)
		v2.Message.Inner.Title.Text = v1.Title
		v2.Message.Inner.Body.Text = v1.Body
		wait(v1.Duration)
	end
	v2.Message:TweenPosition(UDim2.new(1, 0, 1, -300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function()
		v2.Message.Visible = false
	end)
	wait(0.5)
	v2.Icon.Visible = true
	v2.Icon:TweenPosition(UDim2.new(1, -40, 1, -266), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	isQueueProcessing = false
end
local function ShowMessage(p1)
	table.insert(t3, p1)
	if not isQueueProcessing then
		isQueueProcessing = true
		spawn(ProcessQueue)
	end
end
local function ShowNextMessage()
	local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
	table.insert(t3, Leaf)
	if not isQueueProcessing then
		isQueueProcessing = true
		spawn(ProcessQueue)
	end
end
local function Complete(p1)
	p1:Complete()
	local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
	table.insert(t3, Leaf)
	if not isQueueProcessing then
		isQueueProcessing = true
		spawn(ProcessQueue)
	end
end
return {
	Init = function(p1)
		local _ = p1.Event
		v2 = p1.GetScreenGui("Tutorial")
		table.insert(t3, tutorialTree.Welcome.Leaf)
		if not isQueueProcessing then
			isQueueProcessing = true
			spawn(ProcessQueue)
		end
		tutorialTree.Welcome:Complete()
		local Leaf_2 = findNextActiveNode(tutorialTree.Welcome).Leaf
		table.insert(t3, Leaf_2)
		if not isQueueProcessing then
			isQueueProcessing = true
			spawn(ProcessQueue)
		end
		local v32 = tick()
		local function IconInputBegan(p1)
			if p1.UserInputType == Enum.UserInputType.MouseButton1 then
				local v12 = tick()
				if v12 - v32 < 0.5 then
					return false
				end
				v32 = v12
				local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
				table.insert(t3, Leaf)
				if not isQueueProcessing then
					isQueueProcessing = true
					spawn(ProcessQueue)
				end
			end
		end
		local function IconMouseEnter(p1)
			local v12 = tick()
			if v12 - v32 < 0.5 then
				return false
			end
			v32 = v12
			local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
			table.insert(t3, Leaf)
			if not isQueueProcessing then
				isQueueProcessing = true
				spawn(ProcessQueue)
			end
		end
		v2.Icon.InputBegan:Connect(IconInputBegan)
		v2.Icon.MouseEnter:Connect(IconMouseEnter)
		function p1.em.nvyrkw5r(p1, p2)
			for v12, v2 in next, p1 do
				local v32 = tutorialTree[v12]
				if v32 and v32.State ~= 4 then
					if p2 then
						TreeClass:Complete()
					else
						TreeClass:Complete()
						local Leaf = findNextActiveNode(tutorialTree.Welcome).Leaf
						table.insert(t3, Leaf)
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
