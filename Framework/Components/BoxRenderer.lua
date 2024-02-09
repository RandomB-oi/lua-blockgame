local module = {}
module.__index = module
module.__derives = "Component"

local red, green
function module.Init()
	red = Color4.new(1,0,0,1)
	green = Color4.new(0,1,0,1)
end

local function DrawRectangle(cf, size, color)
	local width = size.X
	local height = size.Y
	local x = cf.X
	local y = cf.Y
	local r = cf.R
	
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(r)
	color:Apply()
	love.graphics.rectangle("fill", -width/2, -height/2, width, height)
	love.graphics.pop()
end

function module.new(self)
	local run = GetService("RunService")

	self.Color = Color4.new(1,1,1,1)
	self.Maid:GiveTask(run.Draw:Connect(function()
		local transform = self.Object:GetTransform()
		if not transform then return end

		if self.Object.Parent then
			self.Object.Parent._drawn:Wait()
		end

		local cf, size = transform.RenderCFrame, transform.RenderSize
		if transform:IsA("GuiTransform") then -- guis start from the top left
			cf = cf * (size/2)
		end
		local color = self.Color

		DrawRectangle(cf, size, color)
		-- DrawRectangle(cf * CFrame.new(0, 50), Vector2.new(10, 10), red)
		-- DrawRectangle(cf * CFrame.new(50, 0), Vector2.new(10, 10), green)
		self.Object._drawn:Fire()
	end))

	return self
end

Class.RegisterComponent("BoxRenderer", module)

return module