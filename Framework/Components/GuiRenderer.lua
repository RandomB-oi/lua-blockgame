local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	local run = GetService("RunService")

	self._drawn = Class.new("Signal")
	self.Maid:GiveTask(self._drawn)

	self.Color = Color4.new(1,1,1,1)
	self.Maid:GiveTask(run.Draw:Connect(function()
        if self.Parent then
			self.Parent._updated:Wait()
        end
        local pos, size, rot = self.Object:CalculateRenderInfo()
        self.Color:Apply()
	    love.graphics.rectangle("fill", pos.X, pos.Y, size.X, size.Y)
	end))

	return self
end

Class.RegisterComponent("GuiRenderer", module)

return module