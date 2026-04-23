local t = {
	ClassName = "Tree"
}
t.__index = t
function t.new() --[[ Line: 28 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)
	v2.Root = true
	v2.Depth = 1
	v2.Branches = {}
	v2.Leaf = nil
	return v2
end
function t.AddBranch(p1, p2) --[[ Line: 36 | Upvalues: t (copy) ]]
	assert(p2.ClassName == t.ClassName)
	assert(p2.Root)
	p2.Root = false
	p2.Depth = p1.Depth + 1
	table.insert(p1.Branches, p2)
end
function t.Complete(p1) --[[ Line: 43 ]]
	p1.State = 4
	for i = 1, #p1.Branches do
		p1.Branches[i].State = 2
	end
end
local t2 = {
	Welcome = t.new()
}
t2.Welcome.Leaf = {
	Title = "Welcome to Jailbreak!",
	Body = "This tutorial will teach you the basics of Jailbreak.",
	Duration = 15
}
t2.Escape = t.new()
t2.Escape.Leaf = {
	Title = "Getting Started",
	Body = "Figure out how to escape the prison.",
	Duration = 15,
	Team = 2
}
t2.GetCar = t.new()
t2.GetCar.Leaf = {
	Title = "Life of a Criminal",
	Body = "You escaped! Look for a car to drive...",
	Duration = 15,
	Team = 2
}
t2.GetCarDone = t.new()
t2.GetCarDone.Leaf = {
	Title = "Driving",
	Body = "This is your starter car. You can upgrade it, and buy other cars!",
	Duration = 15,
	Team = 2,
	OneShot = true
}
t2.BankRobbery = t.new()
t2.BankRobbery.Leaf = {
	Title = "Robbery",
	Body = "Go to the bank in the city to rob it!",
	Duration = 15,
	Team = 2
}
t2.BankRobberyDone = t.new()
t2.BankRobberyDone.Leaf = {
	Title = "Robbery Complete",
	Body = "Earn money by robbing the bank, jewelry store, train, museum, and more!",
	Duration = 15,
	Team = 2,
	OneShot = true
}
t2.CustomizeCar = t.new()
t2.CustomizeCar.Leaf = {
	Title = "Customize Your Car",
	Body = "Go to the garage in the city to customize your car.",
	Duration = 15,
	Team = 2
}
t2.Welcome:AddBranch(t2.Escape)
t2.Escape:AddBranch(t2.GetCar)
t2.GetCar:AddBranch(t2.GetCarDone)
t2.GetCar:AddBranch(t2.BankRobbery)
t2.BankRobbery:AddBranch(t2.BankRobberyDone)
t2.GetCar:AddBranch(t2.CustomizeCar)
local function CompleteTree(p1) --[[ Line: 120 ]]
	p1.State = 4
	for i = 1, #p1.Branches do
		p1.Branches[i].State = 2
	end
end
local function v1(p1) --[[ Line: 126 | Upvalues: v1 (copy) ]]
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
				local v6 = v1(v5)
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
local v3 = false
local function ProcessMessage(p1) --[[ Line: 163 | Upvalues: v2 (ref) ]]
	v2.Message.Inner.Title.Text = p1.Title
	v2.Message.Inner.Body.Text = p1.Body
end
local function ProcessQueue() --[[ Line: 167 | Upvalues: v3 (ref), v2 (ref), t3 (copy) ]]
	v3 = true
	if v2.Icon.Visible then
		v2.Icon:TweenPosition(UDim2.new(1, 0, 1, -266), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function() --[[ Line: 176 | Upvalues: v2 (ref) ]]
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
	v2.Message:TweenPosition(UDim2.new(1, 0, 1, -300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function() --[[ Line: 203 | Upvalues: v2 (ref) ]]
		v2.Message.Visible = false
	end)
	wait(0.5)
	v2.Icon.Visible = true
	v2.Icon:TweenPosition(UDim2.new(1, -40, 1, -266), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	v3 = false
end
local function ShowMessage(p1) --[[ Line: 218 | Upvalues: t3 (copy), v3 (ref), ProcessQueue (copy) ]]
	table.insert(t3, p1)
	if not v3 then
		v3 = true
		spawn(ProcessQueue)
	end
end
local function ShowNextMessage() --[[ Line: 225 | Upvalues: v1 (copy), t2 (copy), t3 (copy), v3 (ref), ProcessQueue (copy) ]]
	local Leaf = v1(t2.Welcome).Leaf
	table.insert(t3, Leaf)
	if not v3 then
		v3 = true
		spawn(ProcessQueue)
	end
end
local function Complete(p1) --[[ Line: 229 | Upvalues: v1 (copy), t2 (copy), t3 (copy), v3 (ref), ProcessQueue (copy) ]]
	p1:Complete()
	local Leaf = v1(t2.Welcome).Leaf
	table.insert(t3, Leaf)
	if not v3 then
		v3 = true
		spawn(ProcessQueue)
	end
end
return {
	Init = function(p1) --[[ Name: Init | Line: 236 | Upvalues: v2 (ref), t2 (copy), t3 (copy), v3 (ref), ProcessQueue (copy), v1 (copy), t (copy) ]]
		local _ = p1.Event
		v2 = p1.GetScreenGui("Tutorial")
		table.insert(t3, t2.Welcome.Leaf)
		if not v3 then
			v3 = true
			spawn(ProcessQueue)
		end
		t2.Welcome:Complete()
		local Leaf_2 = v1(t2.Welcome).Leaf
		table.insert(t3, Leaf_2)
		if not v3 then
			v3 = true
			spawn(ProcessQueue)
		end
		local v32 = tick()
		local function IconInputBegan(p1) --[[ Line: 246 | Upvalues: v32 (ref), v1 (ref), t2 (ref), t3 (ref), v3 (ref), ProcessQueue (ref) ]]
			if p1.UserInputType == Enum.UserInputType.MouseButton1 then
				local v12 = tick()
				if v12 - v32 < 0.5 then
					return false
				end
				v32 = v12
				local Leaf = v1(t2.Welcome).Leaf
				table.insert(t3, Leaf)
				if not v3 then
					v3 = true
					spawn(ProcessQueue)
				end
			end
		end
		local function IconMouseEnter(p1) --[[ Line: 256 | Upvalues: v32 (ref), v1 (ref), t2 (ref), t3 (ref), v3 (ref), ProcessQueue (ref) ]]
			local v12 = tick()
			if v12 - v32 < 0.5 then
				return false
			end
			v32 = v12
			local Leaf = v1(t2.Welcome).Leaf
			table.insert(t3, Leaf)
			if not v3 then
				v3 = true
				spawn(ProcessQueue)
			end
		end
		v2.Icon.InputBegan:Connect(IconInputBegan)
		v2.Icon.MouseEnter:Connect(IconMouseEnter)
		function p1.em.nvyrkw5r(p1, p2) --[[ Line: 267 | Upvalues: t2 (ref), t (ref), v1 (ref), t3 (ref), v3 (ref), ProcessQueue (ref) ]]
			for v12, v2 in next, p1 do
				local v32 = t2[v12]
				if v32 and v32.State ~= 4 then
					if p2 then
						t:Complete()
					else
						t:Complete()
						local Leaf = v1(t2.Welcome).Leaf
						table.insert(t3, Leaf)
						if not v3 then
							v3 = true
							spawn(ProcessQueue)
						end
					end
				end
			end
		end
	end
}