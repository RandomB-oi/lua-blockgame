local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	local run = GetService("RunService")

	self.Color = {1,1,1}

	self.Maid:GiveTask(run.Draw:Connect(function()
		love.graphics.push()
		local width = self.Object.Size.X
		local height = self.Object.Size.Y
		local x = self.Object.CFrame.X
		local y = self.Object.CFrame.Y
		local r = self.Object.CFrame.R

		love.graphics.translate(x, y)
		love.graphics.rotate(r)
		self.Color:Apply()
		love.graphics.rectangle("fill", -width/2, -height/2, width, height)
		love.graphics.pop()
	end))
	return self
end

Class.RegisterComponent("BoxRenderer", module)

return module